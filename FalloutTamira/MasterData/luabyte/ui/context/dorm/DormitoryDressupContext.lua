local DormitoryDressupContext = BaseClass("DormitoryDressupContext", BaseContext)
local M = DormitoryDressupContext
local tInsert = table.insert

local function SortData(data1, data2)
    local cfg1 = ConfigHelper.GetCfgByLua('item', data1.cfg.id) 
    local cfg2 = ConfigHelper.GetCfgByLua('item', data2.cfg.id) 
    --1、同道具类型按照道具品质排序，品质高得排前面，即4在前，1最后；配置字段quality；
    if cfg1.quality == cfg2.quality then
        --2、同类型同品质，按照配置字段order
        return cfg1.order < cfg2.order
    else
        return cfg1.quality > cfg2.quality
    end
end

function M:Init()
    self.isCameraMove = false
    self.operationType = DormConst.DressUpOperationType.None
    self.assetData = nil
    self.furnitureData = nil
    self.homeFurnitureSlot = nil
    self.slotAssetData = nil
    self.beforeOperationData = nil
    self.selectedFurnitureData = nil
    self.areaType = nil
    self.tabType = nil
end

--点击家具回调
function M:DormClickFurnitureEventHandle(handler)
    if self.isCameraMove then
        return
    end
end

--点击附属家具回调
function M:DormClickFurnitureSlotEventHandle(handler)
    if self.isCameraMove then
        return
    end

    if handler.parentFurnitureData.Area.Type ~= self.areaType.type then
        return
    end

    if self.tabType == DormConst.DressupTableType.ParentFurniture and handler.isMainSlot then
        if self.operationType == DormConst.DressUpOperationType.None then
            self:SetCSData(handler, true)
            self:SetOperationType(DormConst.DressUpOperationType.SelectParentSlot)
            self:SelectParentSlot()
            self:SetBeforeOperationData(DormConst.DressupTableType.ParentFurniture, handler.parentFurnitureData.MainAssetType)
            return
        end

        if self.operationType == DormConst.DressUpOperationType.SelectParentSlot then
            --点击同一个槽位
            if handler.parentFurnitureData.FurnitureName == self.furnitureData.FurnitureName then
    
            else
                self:SetCSData(handler, true)
                self:GetCtrl():SetOperationButton()
                self:SelectParentSlot()
                self:SetBeforeOperationData(DormConst.DressupTableType.ParentFurniture, handler.parentFurnitureData.MainAssetType)
            end
            return
        end

        if self.operationType == DormConst.DressUpOperationType.SelectParentFurniture then
            self:SetCSData(handler, true)
            self:SetOperationType(DormConst.DressUpOperationType.SelectParentSlot)
            self:SelectParentSlot()
            self:SetBeforeOperationData(DormConst.DressupTableType.ParentFurniture, handler.parentFurnitureData.MainAssetType)
        end
    end

    if self.tabType == DormConst.DressupTableType.AccessoryFurniture and not handler.isMainSlot then
        if self.operationType == DormConst.DressUpOperationType.None then
            self:SetCSData(handler, false)
            if self.assetData == nil then 
                return 
            end
            self:SetOperationType(DormConst.DressUpOperationType.SelectSlot)
            self:SelectSlot()
            self:SetBeforeOperationData(DormConst.DressupTableType.AccessoryFurniture)
            GameHelper.PlayAudioById(1217)
            return
        end
    
        if self.operationType == DormConst.DressUpOperationType.SelectSlot then
            --点击同一个槽位
            if handler.homeFurnitureSlot.SlotID == self.homeFurnitureSlot.SlotID and
                self.assetData.Id == handler.parentAssetData.Id then
    
            else
                self:SetCSData(handler, false)
                self:GetCtrl():SetOperationButton()
                self:SelectSlot()
                self:SetBeforeOperationData(DormConst.DressupTableType.AccessoryFurniture)
                GameHelper.PlayAudioById(1217)
            end
            return
        end
    
        if self.operationType == DormConst.DressUpOperationType.SelectAccessoryFurniture then
            --判断当前点位是否可以布置家具
            if table.indexof(self.selectedFurnitureData.cfg.positionId, handler.homeFurnitureSlot.SlotType.value__) then
                self:SetCSData(handler, false)
                if self.assetData == nil then 
                    return 
                end
                self:SetBeforeOperationData(DormConst.DressupTableType.AccessoryFurniture)
                self:SelectSlot()
                self:GetCtrl():SetOperationButton()
            else
                GameHelper.Tips("不可在此处布置")
            end
        end
    end
end

function M:Open()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.OnDormClickFurnitureEventHandle = Bind(self, self.DormClickFurnitureEventHandle)
    self.OnDormClickFurnitureSlotEventHandle = Bind(self, self.DormClickFurnitureSlotEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureEvent", self.OnDormClickFurnitureEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnDormClickFurnitureSlotEventHandle)
    self.UpdateAreaFurnitureDataHandle = EventMgr:AddListener(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE,
        Bind(self, self.UpdataFurnitureData))
    self:GetAllFurnitureData()
end

function M:GetAllFurnitureData()
    OtakuFurniturDataMgr:GetFurnituresByPage(-1, Bind(self, self.GetAllFurnituresCallBack))
end

function M:GetAllFurnituresCallBack(datas)
    self.allFurnitures = DeepCopy(datas)
    self:GetFurnituresByHero(self.module.heroId)
end

function M:GetFurnituresByHero(heroId)
    OtakuFurniturDataMgr:GetFurnituresByHero(heroId, Bind(self, self.GetFurnituresByHeroCallBack))
end

--获取当前已摆放的家具回调
function M:GetFurnituresByHeroCallBack(datas)
    self.heroFurnitures = datas
    self:_Show(DormConst.DormArea.MainArea)
end

function M:EnterFitment(areaType, callBack)
    self:ResetParams()
    self.areaType = areaType
    self.areaCallBack = callBack
    self.isCameraMove = true
    DormHelper.EnterFitment(self.areaType.areaName, Bind(self, self.EnterFitmentCallback))
end

function M:EnterFitmentCallback(furnitureDatas)
    self.isCameraMove = false
    self.originFurnitureDatas = self:InitFurniture(furnitureDatas)
    self:GetFurnituresByArea(self.areaType.type)
end

--初始化原始家具数据
function M:InitFurniture(data)
    local len = data.Length
    local originFurnitureDatas = {}

    for i = 0, len - 1 do
        local item = data[i]

        if item.FurnitureName then
            local assetData = DormHelper.GetFurnitureAssetDataByName(item.FurnitureName)
            if assetData then
                local furniture = self.module:GetFurniture(assetData.Id)
                if furniture then
                    tInsert(originFurnitureDatas, furniture)
                    local parents = self.module:GetSlotFurnituresById(assetData.Id)
                    for key, value in pairs(parents) do
                        tInsert(originFurnitureDatas, value)
                    end
                end
            end
        end
    end
    return originFurnitureDatas
end

--获取当前区域可摆放的家具
function M:GetFurnituresByArea(areaType)
    OtakuFurniturDataMgr:GetFurnituresByArea(areaType, Bind(self, self.GetFurnituresByAreaCallBack))
end

--获取当前区域可摆放的家具回调
function M:GetFurnituresByAreaCallBack(datas)
    self.areaFurnitures = datas
    if self.areaCallBack then
        self.areaCallBack()
    end
end

--获取所有附属家具
function M:GetAllAccessoryFurniture()
    local arr = {}
    for key, value in pairs(self.areaFurnitures) do
        if value.cfg.type == DormConst.FurnitureType.AccessoryFurniture then
            value.isSelect = false
            value.num = 1
            value.type = DormConst.DressupTableType.AccessoryFurniture
            tInsert(arr, value)
        end
    end
    table.sort(arr, SortData)
    return arr
end

--根据槽位类型获取附属家具
function M:GetAccessoryFurintureBySlotType(slotType)
    local arr = {}
    for key, value in pairs(self.areaFurnitures) do
        if value.cfg.type == DormConst.FurnitureType.AccessoryFurniture then
            if table.indexof(value.cfg.positionId, slotType) then
                value.isSelect = false
                value.num = 1
                value.type = DormConst.DressupTableType.AccessoryFurniture
                tInsert(arr, value)
            end
        end
    end
    table.sort(arr, SortData)
    return arr
end

--获取所有父家具
function M:GetAllParentFurniture()
    local arr = {}
    for key, value in pairs(self.areaFurnitures) do
        if value.cfg.type ~= DormConst.FurnitureType.AccessoryFurniture then
            value.isSelect = false
            value.num = 1
            value.type = DormConst.DressupTableType.ParentFurniture
            tInsert(arr, value)
        end
    end
    table.sort(arr, SortData)
    return arr
end

--根据类型获取父家具
function M:GetParentFurnitureByType(type)
    local arr = {}
    for key, value in pairs(self.areaFurnitures) do
        if value.cfg.type == type then
            value.isSelect = false
            value.num = 1
            value.type = DormConst.DressupTableType.ParentFurniture
            tInsert(arr, value)
        end
    end
    table.sort(arr, SortData)
    return arr
end

--根据模板id获取家具数据
function M:GetFurnitureDataByTemplateId(TemplateId)
    local arr = {}
    for k, v in pairs(self.allFurnitures) do
        if v.TemplateId == TemplateId then
            tInsert(arr, v)
        end
    end
    return arr
end

function M:GetNotDressupFurnitureDataTemplateId(TemplateId)
    for k, v in pairs(self.allFurnitures) do
        if v.TemplateId == TemplateId and v.HeroId == 0 then
            return v
        end
    end
    return nil
end

function M:CheckDressUp(type, templateId, parentFurnitureType, slotId)
    local isDressUp = false
    for key, value in pairs(self.heroFurnitures) do
        if value.TemplateId == templateId then
            if type == DormConst.DressupTableType.ParentFurniture then
                isDressUp = true
                return isDressUp
            end

            if type == DormConst.DressupTableType.AccessoryFurniture then
                --判断附属家具是否摆在正确位置
                local parentFurnitureData = OtakuFurniturDataMgr:GetFurnitureDataById(value.ParentId)
                if parentFurnitureData.cfg.type == parentFurnitureType and value.PosIndex == slotId then
                    isDressUp = true
                    return isDressUp
                end
            end
        end
    end
    return isDressUp
end

function M:UpdataFurnitureData(data, isDel)
    self:UpdateAreaFurnitureData(data, isDel)
    self:UpdateHeroFurnitureData(data, not isDel)
end

function M:UpdateAreaFurnitureData(data, isDel)
    if isDel then
        for key, value in pairs(self.areaFurnitures) do
            if value.FurnitureId == data.FurnitureId then
                table.removebyvalue(self.areaFurnitures, value)
                return
            end
        end
    else
        data.cfg = ConfigHelper.GetCfgByLua("houseFurniture", data.TemplateId)
        tInsert(self.areaFurnitures, data)
    end
end

function M:UpdateHeroFurnitureData(data, isDel)
    if isDel then
        for key, value in pairs(self.heroFurnitures) do
            if value.FurnitureId == data.FurnitureId then
                table.removebyvalue(self.heroFurnitures, value)
                return
            end
        end
    else
        data.cfg = ConfigHelper.GetCfgByLua("houseFurniture", data.TemplateId)
        tInsert(self.heroFurnitures, data)
    end
end

function M:UpdateAllFurniture(data)
    for key, value in pairs(self.allFurnitures) do
        if value.FurnitureId == data.FurnitureId then
            value.HeroId = data.HeroId
            value.ParentId = data.ParentId
            value.PosIndex = data.PosIndex
            break
        end
    end
end

function M:SetCSData(handler, isMain)
    if isMain then
        self.assetData = handler.parentAssetData
        self.furnitureData = handler.parentFurnitureData
        self.homeFurnitureSlot = handler.homeFurnitureSlot
        self.slotAssetData = nil
    else
        self.assetData = handler.parentAssetData
        self.furnitureData = handler.parentFurnitureData
        self.homeFurnitureSlot = handler.homeFurnitureSlot
        self.slotAssetData = handler.slotAssetData
    end

end

--选择槽位
function M:SelectSlot()
    if self.operationType == DormConst.DressUpOperationType.SelectSlot then
        local arr = self:GetAccessoryFurintureBySlotType(self.homeFurnitureSlot.SlotType.value__)
        self:GetCtrl():UpdateFurnitures(arr)
    end

    if self.operationType == DormConst.DressUpOperationType.SelectAccessoryFurniture then
        if self.selectedFurnitureData.type == DormConst.DressupTableType.AccessoryFurniture then
            self.module:ChangeAccessoryFurniture(self.assetData.Id, self.homeFurnitureSlot.SlotID,
                self.selectedFurnitureData.FurnitureId, self.selectedFurnitureData.TemplateId)
            self.slotAssetData = DormHelper.GetFurnitureAssetDataByName(tostring(self.selectedFurnitureData.FurnitureId))
        end
    end
end

--选择父家具槽位
function M:SelectParentSlot()
    if self.operationType == DormConst.DressUpOperationType.SelectParentSlot then
        local arr = self:GetParentFurnitureByType(self.furnitureData.MainAssetType)
        self:GetCtrl():UpdateFurnitures(arr)
    end

    if self.operationType == DormConst.DressUpOperationType.SelectParentFurniture then
        if self.selectedFurnitureData.type == DormConst.DressupTableType.ParentFurniture then
            self.module:ChangeFurniture(self.selectedFurnitureData.cfg.type, self.selectedFurnitureData.FurnitureId,
            self.selectedFurnitureData.TemplateId)
            self.slotAssetData = DormHelper.GetFurnitureAssetDataByName(self.selectedFurnitureData.cfg.homeFurniturePoint)
        end
    end
end

--设置操作类型
function M:SetOperationType(operationType)
    self.operationType = operationType
    self:GetCtrl():SetOperationButton()
end

--设置操作前数据
function M:SetBeforeOperationData(type, furnitureType)
    if self.beforeOperationData == nil then
        self.beforeOperationData = {}
        if type == DormConst.DressupTableType.AccessoryFurniture then
            self.beforeOperationData.type = type
            self.beforeOperationData.parentFurnitureId = self.assetData.Id
            self.beforeOperationData.SlotID = self.homeFurnitureSlot.SlotID
            if self.slotAssetData then
                self.beforeOperationData.newFurnitureId = self.slotAssetData.Id
                self.beforeOperationData.newTemplateId = self.slotAssetData.TemplateId
            else
                self.beforeOperationData.newFurnitureId = nil
                self.beforeOperationData.newTemplateId = nil
            end
        end
    
        if type == DormConst.DressupTableType.ParentFurniture then
            local furnitureData = self.module:GetFurnitureByType(furnitureType)
            self.beforeOperationData.type = type
            self.beforeOperationData.furnitureType = furnitureType
            if furnitureData then
                self.beforeOperationData.newFurnitureId = furnitureData.id 
                self.beforeOperationData.newTemplateId = furnitureData.TemplateId
            else
                self.beforeOperationData.newFurnitureId = nil 
                self.beforeOperationData.newTemplateId = nil
            end
        end
    end
end

--设置选择家具
function M:SetSelectedFurnitureData(data)
    self.selectedFurnitureData = data
end

--还原操作前数据
function M:RestoreBeforeOperationData()
    if self.beforeOperationData then
        if self.beforeOperationData.type == DormConst.DressupTableType.AccessoryFurniture then
            self.module:ChangeAccessoryFurniture(self.beforeOperationData.parentFurnitureId,
                self.beforeOperationData.SlotID,
                self.beforeOperationData.newFurnitureId, self.beforeOperationData.newTemplateId)
        end

        if self.beforeOperationData.type == DormConst.DressupTableType.ParentFurniture then
            self.module:ChangeFurniture(self.beforeOperationData.furnitureType, self.beforeOperationData.newFurnitureId, 
            self.beforeOperationData.newTemplateId)
        end
        --重置操作前数据
        self.beforeOperationData = nil
    end
end

--撤下当前附属家具
function M:RemoveCurAccessoryFurniture()
    if self.slotAssetData then
        self.module:ChangeAccessoryFurniture(self.assetData.Id,
            self.homeFurnitureSlot.SlotID, nil, nil)
        self.slotAssetData = nil
    end
end

--判断是否可以保存
function M:CheckSave(callback)
    if self.areaType then
        OtakuFurniturDataMgr:SetFurnitureAreaTypeRedPoint(self.areaType.type)
        EventMgr:Broadcast(UIMessageNames.DORM_FURNITURE_REDPOINT)
    end
    if #self.module.changeFurnitureData > 0 then
        GameHelper.Confirm("是否保存当前配置", function(ok)
            if ok then
                self.module:SetFurnitures(function ()
                    callback()
                end)
            end
        end,function ()
            local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName(self.areaType.areaName)
            local curFurnitureDatas = self:InitFurniture(furnitureDatas)
            self.module:ResetFurniture(curFurnitureDatas,self.originFurnitureDatas)
            callback()
        end)
    else
        callback()
    end
end

--根据类型获取默认家具数据
function M:GetDefaultFurnitureByType(type)
    local cfgs = ConfigHelper.GetCfgs("initialFurniture")
    for key, value in pairs(cfgs) do
        if value.pointId == type then
            local furnitureData = self:GetNotDressupFurnitureDataTemplateId(value.furnitureId)
            return furnitureData
        end
    end
    return nil
end

function M:ResetParams()
    self.isCameraMove = false
    self.operationType = DormConst.DressUpOperationType.None
    self.assetData = nil
    self.furnitureData = nil
    self.homeFurnitureSlot = nil
    self.slotAssetData = nil
    self.beforeOperationData = nil
    self.selectedFurnitureData = nil
end

function M:_Destory()
    M.super._Destory(self)
end

function M:OnDispose()
    self:ResetParams()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureEvent", self.OnDormClickFurnitureEventHandle)
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnDormClickFurnitureSlotEventHandle)
    EventMgr:RemoveListener(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, self.UpdateAreaFurnitureDataHandle)
    self.OnDormClickFurnitureEventHandle = nil
    self.OnDormClickFurnitureSlotEventHandle = nil
    self.areaCallBack = nil
    M.super.OnDispose(self)
end

return DormitoryDressupContext
