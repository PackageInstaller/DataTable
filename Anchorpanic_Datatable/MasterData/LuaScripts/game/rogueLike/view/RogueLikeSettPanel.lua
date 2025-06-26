--[[ 
-----------------------------------------------------
@filename       : RogueLikeSettPanel
@Description    : 肉鸽结算界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("rogueLike.RogueLikeSettPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeSettPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mScoreList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScrollData = self:getChildGO("mScrollData"):GetComponent(ty.ScrollRect)
    self.mDataSettItem = self:getChildGO("mDataSettItem")
    self.mTxtScoreAll = self:getChildGO("mTxtScoreAll"):GetComponent(ty.Text)
    self.mBtnClose = self:getChildGO("mBtnClose")
end

-- 激活
function active(self, args)
    super.active(self)

    local point, data = rogueLike.RogueLikeManager:getServerSettleData()
    self.allPoint = point
    self.data = data
    self:showView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearScoreList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function showView(self)
    local showData = rogueLike.RogueLikeManager:getSettData()
    self.mTxtScoreAll.text = "" .. self.allPoint

    for i = 1, #showData - 1 do
        local item = SimpleInsItem:create(self.mDataSettItem, self.mScrollData.content, "RogueLikeSettPanelscoreItem")
        --针对6进行特殊处理
        if i == 6 then
            local layout = rogueLike.RogueLikeManager:getRogueLayout()
            local difficulty = rogueLike.RogueLikeManager:getRogueDifficulty()

            local s = _TT(56000 + difficulty)
            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = string.substitute(_TT(showData[i].des), s, layout)
        else
            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(showData[i].des)
        end
        local times = rogueLike.RogueLikeManager:getSettleData(i)
        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = times
        table.insert(self.mScoreList, item)
    end
end

function clearScoreList(self)
    for i = 1, #self.mScoreList do
        self.mScoreList[i]:recover()
    end
    self.mScoreList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]