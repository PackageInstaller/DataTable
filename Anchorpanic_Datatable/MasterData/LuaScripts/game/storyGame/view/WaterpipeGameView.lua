--[[ 
-----------------------------------------------------
@filename       : WaterpipeGameView
@Description    : 剧情游戏——接水管游戏
@date           : 2020-12-24 16:23:40
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.view.WaterpipeGameView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/WaterpipeGameView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setInnerOffset(0, 0, 0, 0)
    -- self:setTxtTitle('')
    -- self:setContentBg("")
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mFrame = self:getChildTrans("mFrame")
    self.mGroup = self:getChildTrans("mGroup")
    self.mImgMask = self:getChildGO("mImgMask")
end

--激活
function active(self, args)
    super.active(self, args)
    self.gameId = args.gameId

    self:updateView()

    LoopManager:addFrame(1, 0, self, self.frameUpdate)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.mImgMask:SetActive(false)
    self:poolRecover()
    LoopManager:removeFrame(self, self.frameUpdate)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self)
    local waterpipeGameVo = storyGame.WaterpipeGameManager:getWaterpipeGameData(self.gameId)

    self.gridW = storyGame.WaterpipeGameItem.ITEM_W * waterpipeGameVo.row
    self.gridH = storyGame.WaterpipeGameItem.ITEM_H * waterpipeGameVo.column

    gs.TransQuick:SizeDelta(self.mFrame, self.gridW, self.gridH)

    self.itemList = {}
    for i, id in ipairs(waterpipeGameVo.waterpipeList) do
        local item = storyGame.WaterpipeGameItem:poolGet()
        item:setData(self.mGroup, self.gameId, id)
        table.insert(self.itemList, item)
    end
end

function poolRecover(self)
    for i, v in ipairs(self.itemList) do
        v:poolRecover()
    end
end

function frameUpdate(self)
    local isCorrect = true
    for i, v in ipairs(self.itemList) do
        if v:isCorrect() == false then
            isCorrect = false
            break
        end
    end
    if isCorrect then
        self.mImgMask:SetActive(true)

        self:setTimeout(2, function()
            self:close()
            UIFactory:alertMessge("完成啦，好开心啊！恭喜恭喜啊~ 你好棒棒啊~", true)
        end)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
