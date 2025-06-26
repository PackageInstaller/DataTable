--[[ 
-----------------------------------------------------
@filename       : PasswordGameView
@Description    : 剧情游戏——密码锁游戏
@date           : 2020-12-28 16:43:04
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.view.PasswordGameView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/PasswordGameView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
end
--析构  
function dtor(self)
end

function initData(self)
    self.result = "90120414"
    self.maxNum = 8
    self.list = {}
    self.showNum = ""
end

-- 初始化
function configUI(self)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtShow = self:getChildGO("mTxtShow"):GetComponent(ty.Text)
    self.mImgLigth = self:getChildGO("mImgLigth"):GetComponent(ty.AutoRefImage)
    for i = 1, 10 do
        local btn = self:getChildGO("mBtn" .. i)
        table.insert(self.list, btn)
    end

    self.mBtnDel = self:getChildGO("mBtnDel")
    self.mBtnEnter = self:getChildGO("mBtnEnter")
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:resetState()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtTips.text = "密码可能是:" .. self.result
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    for i, v in ipairs(self.list) do
        self:addUIEvent(v, function()
            self:addNum(i)
        end)
    end

    self:addUIEvent(self.mBtnDel, self.onClickDel)
    self:addUIEvent(self.mBtnEnter, self.onClickEnter)
end

-- 更新数字显示
function updateShow(self)
    self.mTxtShow.text = self.showNum
end

-- 键入数字
function addNum(self, cusNum)
    if self.timeId then
        self:clearTimeout(self.timeId)
        self.timeId = nil
    end
    if #self.showNum >= self.maxNum then
        gs.Message.Show(string.format("密码为%s位数", self.maxNum))
        return
    end
    cusNum = cusNum == 10 and 0 or cusNum
    self.showNum = self.showNum .. cusNum
    self:updateShow()
end
-- 删除
function onClickDel(self)
    self.showNum = string.sub(self.showNum, 1, #self.showNum - 1)
    self:updateShow()
end
-- 确认
function onClickEnter(self)
    if self.showNum == self.result then
        self.mImgLigth:SetImg("arts/emoji/11.png", false)

        self.mTxtShow.text = "Success"
        self:setTimeout(0.5, function()
            self:close()
            UIFactory:alertMessge("完成啦，好开心啊！恭喜恭喜啊~ 你好棒棒啊~", true)
        end)

    else
        self.mImgLigth:SetImg("arts/emoji/17.png", false)
        self.mTxtShow.text = "Error"
        self.timeId = self:setTimeout(1, function()
            self:resetState()
        end)
    end
end
function resetState(self)
    if self.timeId then
        self:clearTimeout(self.timeId)
        self.timeId = nil
    end
    self.showNum = ""
    self.mTxtShow.text = ""
    self.mImgLigth:SetImg(UrlManager:getPackPath("common/progress/bar_bg_1.png"), false)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
