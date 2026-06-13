local DormitoryDressupCtrl = BaseClass("DormitoryDressupCtrl", BaseUICtrl)
local M = DormitoryDressupCtrl
local tInsert = table.insert
function M:Init()
    self._view.BtnL:onClick(Bind(self, self.OnClickLeft))
    self._view.BtnR:onClick(Bind(self, self.OnClickRight))
    self._view.BtnSave:onClick(Bind(self, self.OnClickSave))
    self._view.BtnFold:onClick(Bind(self, self.OnClickFold))
    self._view.BtnOK:onClick(Bind(self, self.OnClickOK))
    self._view.BtnCancel:onClick(Bind(self, self.OnClickCancel))
    self._view.BgDown:onClick(Bind(self, self.OnClickDown))
    self._view.BgUp:onClick(Bind(self, self.OnClickUp))
    self._view.obtainBtn:onClick(Bind(self, self.OnGain))
    self._view.BtnAuto:onClick(Bind(self,self.OnClickAuto))
    self.scrollView = self._view.ScrollView
    self.selectItemCallback = EventMgr:AddListener(UIMessageNames.DORM_SELECT_FURNITURE, Bind(self, self.OnSelectItem))
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI")
    self.tabItemCtrlList = {}
    for i = 1, 3 do
        local tableCtrl = require("UI.Ctrl.Dorm.DormitoryDressupTabItemCtrl").New(self._view["TabItem" .. i])
        tableCtrl:SetCallback(Bind(self, self.ClickTabCallback))
        tInsert(self.tabItemCtrlList, tableCtrl)
    end
    self.areaCtrl = require("UI.Ctrl.Dorm.DormitoryDressupAreaCtrl").New(self._view.AreaPart)
    self.areaCtrl:SetCallback(Bind(self, self.UpdateAreaType))
    self.areaCtrl:UpdateDropdown()

    self.furnitureItems = {}
    self.furnitureObjs = {}
    self.pageIndex = 1
    self.areaType = nil
    self.tabType = nil
end

function M:OnGain(go)
    GameHelper.Jump(4)
end

function M:OnEnter(area)
    self.dormAction.state = DormConst.RoleState.DressUp
    self.areaCtrl:SelectArea(area)
end

--更新区域类型
function M:UpdateAreaType(areaType)
    self.areaType = areaType
    self.context:EnterFitment(self.areaType, Bind(self, self.EnterFitmentCallback))
end

--移动镜头回调
function M:EnterFitmentCallback()
    for i = 1, #self.tabItemCtrlList do
        if self.areaType.tables[i] then
            self.tabItemCtrlList[i]:Enable(true)
            self.tabItemCtrlList[i]:UpdateData(self.areaType.tables[i])
        else
            self.tabItemCtrlList[i]:Enable(false)
        end
    end
    self.tabType = nil
    self.tabItemCtrlList[1]:OnClickTab()
end

--选择页签回调
function M:ClickTabCallback(tabType)
    if self.tabType then
        OtakuFurniturDataMgr:SetFurnitureTypeRedPoint(self.tabType)
        EventMgr:Broadcast(UIMessageNames.DORM_FURNITURE_REDPOINT)
    end
    self.tabType = tabType
    self.context.tabType = tabType
    for i = 1, #self.tabItemCtrlList do
        if self.tabItemCtrlList[i].type ~= tabType then
            self.tabItemCtrlList[i]._view.UIState:SetState(1)
        end
    end
    self:SetFurnitureList()
    self.context:ResetParams()
    self:SetOperationButton()
    self:SetAreaSlot()
end

function M:SetAreaSlot()
    if self.tabType == DormConst.DressupTableType.AccessoryFurniture then
        DormHelper.AreaSlotEnable(true)
        DormHelper.AreaMainSlotEnable(false)

    end

    if self.tabType == DormConst.DressupTableType.ParentFurniture then
        DormHelper.AreaSlotEnable(false)
        DormHelper.AreaMainSlotEnable(true)
    end
end 

--设置家具列表
function M:SetFurnitureList()
    if self.tabType == DormConst.DressupTableType.AccessoryFurniture then
        self.furnitureItems = self.context:GetAllAccessoryFurniture()
    end

    if self.tabType == DormConst.DressupTableType.ParentFurniture then
        self.furnitureItems = self.context:GetAllParentFurniture()
    end

    self:InitFurnitures()

end

function M:UpdateFurnitures(furnitureItems)
    self.furnitureItems = furnitureItems
    self:InitFurnitures()
end

function M:InitFurnitures()
    local len = #self.furnitureItems
    self.scrollView:SetActive(len > 0)
    self._view.noGifts:SetActive(len == 0)
    if len <= 0 then
        return
    end
    self.furnitureArray = {}
    local index = 0
    local singleFurnitureArray = {}
    for i = 1, len do
        index = index + 1
        if index <= 6 then
            tInsert(singleFurnitureArray, self.furnitureItems[i])
        end
        if index == 6 or i == len then
            tInsert(self.furnitureArray, singleFurnitureArray)
            singleFurnitureArray = {}
            index = 0
        end
    end
    self.pageCount = #self.furnitureArray
    self:CreateFurnitures()
    self:SetPageButton()
end

--选择家具
function M:OnSelectItem(id)
    for i, v in ipairs(self.furnitureObjs) do
        if v.data.FurnitureId ~= id then
            v.data.isSelect = false
        else
            v.data.isSelect = not v.data.isSelect
        end
        v:SetSelect()
    end
end

function M:CreateFurnitures()
    if #self.furnitureObjs > 0 then
        for i = 1, #self.furnitureObjs do
            GameUtil.DestroyGo(self.furnitureObjs[i]._view.gameObject)
        end
    end
    self.furnitureObjs = {}
    local array = {}
    if self.furnitureArray[self.pageIndex] then
        array = self.furnitureArray[self.pageIndex]
    else
        array = self.furnitureArray[1]
    end
    local ctrlItemCls = require("UI.Ctrl.Dorm.FurnitureItemCtrl")
    for k, v in pairs(array) do
        local furnitureItem = self._view.FurnitureItem:Instantiate()
        furnitureItem:SetParent(self._view.Content)
        furnitureItem:SetActive(true)
        local ctrlItem = ctrlItemCls.New(furnitureItem)
        ctrlItem:UpdateItem(v)
        tInsert(self.furnitureObjs, ctrlItem)
    end
end

function M:OnClickLeft(go)
    self.pageIndex = Mathf.Clamp(self.pageIndex - 1, 1, self.pageCount)
    self:CreateFurnitures()
    self:SetPageButton()
end

function M:OnClickRight(go)
    self.pageIndex = Mathf.Clamp(self.pageIndex + 1, 1, self.pageCount)
    self:CreateFurnitures()
    self:SetPageButton()
end

function M:SetPageButton()
    self._view.BtnL.gameObject:SetActive(self.pageIndex > 1)
    self._view.BtnR.gameObject:SetActive(self.pageIndex < self.pageCount)
end

function M:OnClickFold(go)
    self.context:RemoveCurAccessoryFurniture()
    self:SetOperationButton()
    if self.context.operationType == DormConst.DressUpOperationType.SelectSlot then
        local arr = self.context:GetAccessoryFurintureBySlotType(self.context.homeFurnitureSlot.SlotType.value__)
        self:UpdateFurnitures(arr)
    end

    if self.context.operationType == DormConst.DressUpOperationType.SelectAccessoryFurniture then
        self:SetFurnitureList()
    end
end

function M:OnClickOK(go)
    self:ResetPanel()
end

function M:OnClickCancel(go)
    self.context:RestoreBeforeOperationData()
    self:ResetPanel()
end

function M:SetOperationButton()
    if self.context.operationType == DormConst.DressUpOperationType.None then
        self._view.BtnSave.gameObject:SetActive(true)
        self._view.BtnGroup.gameObject:SetActive(false)
        self._view.BtnAuto.gameObject:SetActive(true)
    else
        self._view.BtnAuto.gameObject:SetActive(false)
        self._view.BtnSave.gameObject:SetActive(false)
        self._view.BtnGroup.gameObject:SetActive(true)
        self._view.BtnFold.gameObject:SetActive(self.context.slotAssetData ~= nil)
    end
end

function M:ResetPanel()
    self.context:SetOperationType(DormConst.DressUpOperationType.None)
    self.context:ResetParams()
    self:SetFurnitureList()
    self:SetAreaSlot()
    self:SetOperationButton()
end

function M:OnClickAuto(go)
    if self.tabType == DormConst.DressupTableType.AccessoryFurniture then
        self.UnarrangedSlots = DormHelper.GetUnarrangedHomeFurnitureSlots()
        if self.UnarrangedSlots.Count > 0 then
            local furnitureItems = DeepCopy(self.furnitureItems)
            for i = 0, self.UnarrangedSlots.Count - 1 do
                for key, value in pairs(furnitureItems) do
                    if table.indexof(value.cfg.positionId, self.UnarrangedSlots[i].SlotType.value__) then
                        local parentAssetData = DormHelper.GetFurnitureAssetDataByName(self.UnarrangedSlots[i].Owner.FurnitureName)
                        if parentAssetData ~= nil then
                            self.module:ChangeAccessoryFurniture(parentAssetData.Id, self.UnarrangedSlots[i].SlotID,
                            value.FurnitureId, value.TemplateId)
                            OtakuFurniturDataMgr:SetCach(value.FurnitureId)
                        end
                        table.remove(furnitureItems, key)
                        break
                    end
                end
            end
        end
        self:ResetPanel()
        EventMgr:Broadcast(UIMessageNames.DORM_FURNITURE_REDPOINT)
    end

    if self.tabType == DormConst.DressupTableType.ParentFurniture then
        self.areaFurnitures = DormHelper.GetAreaFurnitureDatas()
        if not IsNull(self.areaFurnitures) then
            local furnitureItems = DeepCopy(self.furnitureItems)
            for i = 0, self.areaFurnitures.Length - 1 do
                local assetData = DormHelper.GetFurnitureAssetDataByName(self.areaFurnitures[i].FurnitureName)
                for key, value in pairs(furnitureItems) do
                    if assetData.Type == value.cfg.type then
                        self.module:ChangeFurniture(assetData.Type, value.FurnitureId, value.TemplateId)
                        OtakuFurniturDataMgr:SetCach(value.FurnitureId)
                    end
                    table.remove(furnitureItems, key)
                    break
                end
            end
        end
        self:ResetPanel()
        EventMgr:Broadcast(UIMessageNames.DORM_FURNITURE_REDPOINT)
    end
end

function M:OnClickSave(go)
    self.module:SetFurnitures()
end

function M:OnClickUp(go)
    self._view.Animator:Play("DormitoryDressupUIBotUp")
    self._view.BgDown.gameObject:SetActive(true)
    self._view.BgUp.gameObject:SetActive(false)
end

function M:OnClickDown(go)
    self._view.Animator:Play("DormitoryDressupUIBotDown")
    self._view.BgDown.gameObject:SetActive(false)
    self._view.BgUp.gameObject:SetActive(true)
end

function M:OnBack()
    if #self.module.changeFurnitureData > 0 then
        GameHelper.Confirm("是否保存当前配置", function(ok)
            if ok then
                self.module:SetFurnitures(function()
                    self:Close()
                    UIContextMgr:GetInstance():Show("Dorm")
                end)
            end
        end,function ()
            local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName(self.context.areaType.areaName)
            local curFurnitureDatas = self.context:InitFurniture(furnitureDatas)
            self.module:ResetFurniture(curFurnitureDatas,self.context.originFurnitureDatas, true)
            self:Close()
            UIContextMgr:GetInstance():Show("Dorm")
        end)
    else
        self:Close()
        UIContextMgr:GetInstance():Show("Dorm")
    end
end

function M:OnClose()
    self.context.areaType = nil
    self.dormAction.state = DormConst.RoleState.None
    DormHelper.ExitFitment()
    self.dormAction:CommanderMoveToFurniture("Main")
    self.module:OnUpdateSweepMachine(false)
end

function M:OnDispose()
    for key, value in pairs(self.tabItemCtrlList) do
        value:OnDispose()
    end
    self.tabItemCtrlList = nil
    self.areaCtrl:OnDispose()
    self.areaCtrl = nil
    M.super.OnDispose(self)
    EventMgr:RemoveListener(UIMessageNames.DORM_SELECT_FURNITURE, self.selectItemCallback)
end

return DormitoryDressupCtrl
