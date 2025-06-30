module("manual.ManualModulePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualModulePanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1334, 750)
    self:setBg("manual_bg.jpg", false, "manual")
    self:setTxtTitle("模组")
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(manual.ManualModuleItem)
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
    -- self.colorType = manual.getTabList(manual.ManualType.SolderingMark)[args.type].colorType
    GameDispatcher:addEventListener(EventName.UPDATE_MODULE_DETAIL, self.updateView, self)
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
    GameDispatcher:removeEventListener(EventName.UPDATE_MODULE_DETAIL, self.updateView, self)
end

function updateView(self)

    local allList = equip.EquipSuitManager:getSuitConfigList()
    table.sort(allList, function(Fa, Fb)
        if Fa == nil or Fb == nil then
            return false
        end
        return Fa.suitId < Fb.suitId
    end)


    local hasTarget = 0
    for k, v in pairs(allList) do
        if manual.ManualModuleManager:checkModuleIsUnlock(v.suitId) then
            hasTarget = hasTarget + 1
        end
        v.tweenId = k
    end

    local collect = math.floor(hasTarget / #allList * 100)
    self.mTxtTcollect.text = _TT(70099, collect)
    self.mTxt_1.text = _TT(70006)
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = allList
    else
        self.mScroller:ReplaceAllDataProvider(allList)
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]