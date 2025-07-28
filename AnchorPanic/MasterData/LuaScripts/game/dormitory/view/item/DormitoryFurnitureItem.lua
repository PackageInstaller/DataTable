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
    self:addUIEvent(self:getChildGO("mBtnFurniture"), function()
        if self.data.useing == 1 then return end

        if read.ReadManager:isModuleRead(ReadConst.FURNITURE, self.data.id) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.FURNITURE, id = self.data.id})
        end
        local quotaCount = dormitory.DormitorySceneController:getFurnitureNum(self.data.subType)
        if quotaCount >= sysParam.SysParamManager:getValue(SysParamType.DORMITORY_QUOTA) then
            gs.Message.Show2(_TT(49709))
            return
        end
        GameDispatcher:dispatchEvent(EventName.ADD_FURNITURE_TO_SCENE, self.data)
    end)
end

function setData(self, data)
    super.setData(self, data)
    self.mTxtName.text = self.data:getName()
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.data.tid), false)
    if read.ReadManager:isModuleRead(ReadConst.FURNITURE, self.data.id) then
        RedPointManager:add(self.UIObject.transform, UrlManager:getCommon4Path("common_9999.png"), 55, 52)
    else
        RedPointManager:remove(self.UIObject.transform)
    end
    local useing = false
    if self.data.useing and self.data.useing == 1 then
        useing = true
    end
    self.mImgUsing:SetActive(useing)

    self.baseData = dormitory.DormitoryManager:getDormitoryBaseVo(self.data.tid)
    self.mTextAura.text = self.baseData.aura
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
