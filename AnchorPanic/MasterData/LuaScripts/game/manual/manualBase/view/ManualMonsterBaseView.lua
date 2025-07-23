--[[ 
-----------------------------------------------------
@filename       : ManualMonsterBaseView
@Description    : 图鉴怪物面板
@date           : 2022-4-19 17:35:10
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMonsterBaseView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("manual/ManualMonsterBaseView.prefab")
destroyTime = -1 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(manual.ManualMonsterItem)
    self.mTxtTcollect = self:getChildGO("mTxtTcollect"):GetComponent(ty.Text)
    self.mTxt_1 = self:getChildGO("mTxt_1"):GetComponent(ty.Text)
end

function initViewText(self)
end

function addAllUIEvent(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    manual.ManualManager:addEventListener(manual.ManualManager.MANUAL_DATA_UPDATE, self.updateView, self)
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    manual.ManualManager:removeEventListener(manual.ManualManager.MANUAL_DATA_UPDATE, self.updateView, self)
    if (self.mScroller) then
        self.mScroller:CleanAllItem()
    end
end

function updateView(self)
    local list = {}
    local noFight = {}
    for i, vo in ipairs(manual.ManualManager:getCurListDataByType(manual.ManualManager:getLastIndex())) do
        if manual.ManualManager:judgeIsHasFight(vo.id) then
            table.insert(list, vo)
        else
            table.insert(noFight, vo)
        end
    end
    for _, v in ipairs(noFight) do
        table.insert(list, v)
    end
    for index, monsterVo in ipairs(list) do
        monsterVo.tweenId = (2 * index) - 1
    end
    local collect = 0

    if #noFight <= 0 then
        collect = 100
    else
        collect = string.format("%.2f", (#list - #noFight) / #list) * 100
    end
    self.mTxtTcollect.text = _TT(70099, collect)
    self.mTxt_1.text = _TT(70006)
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]