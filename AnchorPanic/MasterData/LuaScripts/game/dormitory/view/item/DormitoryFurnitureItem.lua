module("dormitory.DormitoryFurnitureItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgUsing = self:getChildGO("mImgUsing")
    self.mTextAura = self:getChildGO("mTextAura"):GetComponent(ty.Text)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnFurniture"), self.onClick)
end

function onClick(self)
    if self.data.useing == 1 then return end

    if table.empty(self.data.furniture_list) then
        if read.ReadManager:isModuleRead(ReadConst.FURNITURE, self.data.id) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.FURNITURE, id = self.data.id})
        end
        local quotaCount = dormitory.DormitorySceneController:getFurnitureNum(self.data.subType)
        if quotaCount >= sysParam.SysParamManager:getValue(SysParamType.DORMITORY_QUOTA) then
            gs.Message.Show2(_TT(49709))
            return
        end
        GameDispatcher:dispatchEvent(EventName.ADD_FURNITURE_TO_SCENE, {propsVo = self.data})
    else
        local list = self.data.furniture_list

        --收纳全部家具
        DormitoryCost.all_Storage(true)

        for _index, furnitureConfigInfo in pairs(list) do
            local propsVo = props.PropsVo:poolGet()
            propsVo:setTid(furnitureConfigInfo.tid)
            propsVo.id = furnitureConfigInfo.id

            GameDispatcher:dispatchEvent(EventName.ADD_FURNITURE_TO_SCENE, {propsVo = propsVo, config_info = furnitureConfigInfo})

            if propsVo.subType ~= DormitoryCost.FLOOR_SUBTYPE and propsVo.subType ~= DormitoryCost.TOP_SUBTYPE and propsVo.subType ~= DormitoryCost.WALL_SUBTYPE then
                GameDispatcher:dispatchEvent(EventName.PUT_FURNITURE_SURE, propsVo.id)
            end
        end
    end
end

function setData(self, data)
    super.setData(self, data)
    if table.empty(self.data.furniture_list) then
        self.mTxtName.text = self.data:getName()
        self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.data.tid), false)
        if read.ReadManager:isModuleRead(ReadConst.FURNITURE, self.data.id) then
            RedPointManager:add(self.UIObject.transform, UrlManager:getCommon4Path("common_9999.png"), 55, 52)
        else
            RedPointManager:remove(self.UIObject.transform)
        end
        self.mImgUsing:SetActive(self.data.useing == 1)

        self.baseData = dormitory.DormitoryManager:getDormitoryBaseVo(self.data.tid)
        self.mTextAura.text = self.baseData.aura
    else
        self.mTxtName.text = _TT(self.data.land_id)
        self.mImgIcon:SetImg("arts/ui/icon/" .. self.data.icon_path, false)

        RedPointManager:remove(self.UIObject.transform)

        self.mImgUsing:SetActive(self.data.useing == 1)
        self.mTextAura.text = self.data.aura
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
