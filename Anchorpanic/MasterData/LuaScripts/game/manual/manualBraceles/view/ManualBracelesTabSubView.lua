module("manual.ManualBracelesTabSubView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("manual/ManualBracelesTabSubView.prefab")
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
    self.mScroller:SetItemRender(manual.ManualBracelesItem)
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
    self.colorType = manual.getTabList(manual.ManualType.SolderingMark)[args.type].colorType
    manual.ManualManager:addEventListener(manual.ManualManager.MANUAL_DATA_UPDATE, self.updateView, self)
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    manual.ManualManager:removeEventListener(manual.ManualManager.MANUAL_DATA_UPDATE, self.updateView, self)
    self.mScroller:CleanAllItem()
end

function updateView(self)
    local equipList = manual.ManualManager:getBracelesConfigDic(self.colorType)
    local hasTarget = 0 
    for k,v in pairs(equipList) do
        v.tweenId = k
        if manual.ManualManager:jugEquipHasUnlockByTid(v.tid) then 
            hasTarget = hasTarget + 1
        end
    end
    local collect = math.floor(hasTarget / #equipList * 100) 
    self.mTxtTcollect.text = _TT(70099, collect)
    self.mTxt_1.text = _TT(70006)
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = equipList
    else
        self.mScroller:ReplaceAllDataProvider(equipList)
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]