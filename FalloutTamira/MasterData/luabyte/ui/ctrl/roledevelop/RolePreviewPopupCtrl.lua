local RolePreviewPopupCtrl = BaseClass("RolePreviewPopupCtrl", BaseUICtrl)
local M = RolePreviewPopupCtrl
local AttrType = { None = 0, HP = 1, ATK = 2, DEF = 3, DEFM = 4, SHIELD = 5 }
local ItemPfbUI = CS.GameX.ItemPfbUI

function M:Init()
    self._view.lastBtn:onClick(Bind(self, self._ClickLastBtn))
    self._view.nextBtn:onClick(Bind(self, self._ClickNextBtn))
    self._view.closeBtn:onClick(Bind(self, self._ClickCloseBtn))
    self._curHeroBreak = nil
    self._curBreakIdx = 0
    self._breakArr = nil
    self._costItems = {}
end

function M:OnEnter(heroData)
    self.heroData = heroData
    self._curHeroBreak = CS.GameBase.JHeroBreak.GetBreak(heroData:GetHeroId(), heroData:GetHeroBreak().breakLevel + 1)

    if self._curHeroBreak == nil then
        self._curHeroBreak = heroData:GetHeroBreak()
    end

    self._curBreakIdx = self._curHeroBreak.breakLevel
    self.rare = heroData:GetHeroCfg().rare
    self._breakArr = CS.GameBase.JHeroBreak.GetBreaks(heroData:GetHeroCfg().id)
    self:_SetAttrInfo(self._curHeroBreak)
    self:_SetCostItems(self._curHeroBreak)
    self:_SetRoleInfo(heroData:GetHeroCfg())
    self:_SetBreakInfo(self._breakArr[self._curHeroBreak.breakLevel])
    UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):SetAttrState(2)
end

function M:_ClickLastBtn(go)
    self._curBreakIdx = self._curBreakIdx - 1
    self._curBreakIdx = math.max(self._curBreakIdx, self._curHeroBreak.breakLevel - 1)
    self:_SetBreakInfo(self._breakArr[self._curBreakIdx])
    self:_SetAttrInfo(self._breakArr[self._curBreakIdx])
    self:_SetCostItems(self._breakArr[self._curBreakIdx])
end

function M:_ClickNextBtn(go)
    self._curBreakIdx = self._curBreakIdx + 1
    self._curBreakIdx = math.max(self._curBreakIdx, self._curHeroBreak.breakLevel - 1)
    self:_SetBreakInfo(self._breakArr[self._curBreakIdx])
    self:_SetAttrInfo(self._breakArr[self._curBreakIdx])
    self:_SetCostItems(self._breakArr[self._curBreakIdx])
end

function M:_ClickCloseBtn(go)
    UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):SetAttrState(0)
    self:Close()
end

function M:_SetAttrInfo(heroBreak)
    for i = 0, heroBreak.attributeType.Length - 1 do
        local attributeType = heroBreak.attributeType[i]

        if heroBreak.breakLevel == 1 then
            if attributeType == AttrType.HP then
                self._view.hp:SetText(tostring(heroBreak.attributeValue[i]))
            elseif attributeType == AttrType.ATK then
                self._view.atk:SetText(tostring(heroBreak.attributeValue[i]))
            elseif attributeType == AttrType.DEF then
                self._view.def:SetText(tostring(heroBreak.attributeValue[i]))
            elseif attributeType == AttrType.DEFM then
                self._view.defm:SetText(tostring(heroBreak.attributeValue[i]))
            elseif attributeType == AttrType.SHIELD then
                self._view.shield:SetText(tostring(heroBreak.attributeValue[i]))
            end
        else
            local lastHeroBreak = self:_GetLastAttr(heroBreak.id - 1)

            if attributeType == AttrType.HP then
                self._view.hp:SetText(tostring(heroBreak.attributeValue[i] - lastHeroBreak.attributeValue[i]))
            elseif attributeType == AttrType.ATK then
                self._view.atk:SetText(tostring(heroBreak.attributeValue[i] - lastHeroBreak.attributeValue[i]))
            elseif attributeType == AttrType.DEF then
                self._view.def:SetText(tostring(heroBreak.attributeValue[i] - lastHeroBreak.attributeValue[i]))
            elseif attributeType == AttrType.DEFM then
                self._view.defm:SetText(tostring(heroBreak.attributeValue[i] - lastHeroBreak.attributeValue[i]))
            elseif attributeType == AttrType.SHIELD then
                self._view.shield:SetText(tostring(heroBreak.attributeValue[i] - lastHeroBreak.attributeValue[i]))
            end
        end
    end

    self._view.UIBreakCtrl:Updata(self.rare, self._curBreakIdx)
end

function M:_GetLastAttr(id)
    return ConfigHelper.GetCfg("heroBreak", id)
end

function M:_SetCostItems(heroBreak)
    self._view.coin:SetInfo(heroBreak.costItems[0], ItemPfbUI.NUMTYPE.TOTLE, heroBreak.costNum[0])
    local index = 0
    self._view.costItem:SetActive(false)

    for i = 1, heroBreak.costItems.Length - 1 do
        local item = nil

        if i <= #self._costItems then
            item = self._costItems[i]
        else
            item = GameUtil.InstantiateComponent(self._view.costItem, self._view.costContent)
            table.insert(self._costItems, item)
        end

        item:SetInfo(heroBreak.costItems[i], ItemPfbUI.NUMTYPE.BALANCE, heroBreak.costNum[i])
        item:EnablePopItem(true)
        item:SetActive(true)
        index = index + 1
    end

    for i = index + 1, #self._costItems do
        self._costItems[i]:SetActive(false)
    end
end

function M:_SetRoleInfo(heroCfg)
    self._view.chName:SetText(ConfigHelper.GetLocalString(heroCfg.name))
    self._view.enName:SetText(ConfigHelper.GetLocalString(heroCfg.name))
    self._view.rare:SetPic("UI/SpritePics/develop/ui_develop_icon_" .. heroCfg.rare, true)
    self._view.roleImg:SetBattleHalf(heroCfg.id, RoleType.ERT_Hero)
end

function M:_SetBreakInfo(heroBreak)
    local str = ConfigHelper.GetLocalString(618)
    self._view.lv:SetTextFormat(str, heroBreak.needLevel)
    local isMin = self._curHeroBreak.breakLevel < heroBreak.breakLevel
    self._view.lastBtn:SetActive(isMin)
    self._view.nextBtn:SetActive(heroBreak.breakLevel < self._breakArr.Length - 1)
    self._view.starGroup:SetHeroData(8, heroBreak.breakLevel)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return RolePreviewPopupCtrl
