--[[ 
-----------------------------------------------------
@filename       : EquipPlanScrollItem
@Description    : 模组方案item
@date           : 2023-12-6 00:00:00
@Author         : zzz
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipPlanScrollItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mGroupUnSelect = self:getChildGO("GroupUnSelect")
    self.mTxtUnSelect = self:getChildGO("mTxtUnSelect"):GetComponent(ty.Text)
    self.mGroupSelect = self:getChildGO("GroupSelect")
    self.mTxtSelect = self:getChildGO("mTxtSelect"):GetComponent(ty.Text)

    self.mBtnTop = self:getChildGO("mBtnTop")
    --self.mBtnBot = self:getChildGO("mBtnBot")
    self.mClick = self:getChildGO("mClick")
    self:addOnClick(self.mClick, self.onClickItemHandler)

    self:addOnClick(self.mBtnTop, self.onClickTopHandler)
    --self.addOnClick(self.mBtnBot, self.onClickBotHandler)
end

function onClickTopHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_CHANGE,{planVo =self.data:getDataVo() })
end


function getGuideTrans(self)
    return nil
end

function setData(self, param)
    super.setData(self, param)
    local selectVo = self.data
    local equipPlanVo = selectVo:getDataVo()
    if (equipPlanVo) then
        self.mTxtUnSelect.text = equipPlanVo.name
        self.mTxtSelect.text = equipPlanVo.name
        self.mGroupUnSelect:SetActive(not selectVo:getSelect())
        self.mGroupSelect:SetActive(selectVo:getSelect())

        local list = equipBuild.EquipPlanManager:getEquipPlanList()
        if list and #list > 1 then
            self.mBtnTop:SetActive(list ~=nil and equipPlanVo.sort ~= list[1].sort and equipPlanVo.name ~= _TT(1412))
        else
            self.mBtnTop:SetActive(false)
        end
       
    else
        super.deActive(self)
    end

   
end

function onClickItemHandler(self)
    local selectVo = self.data
    local equipPlanVo = selectVo:getDataVo()
    equipBuild.EquipPlanManager:dispatchEvent(equipBuild.EquipPlanManager.EQUIP_PLAN_SELECT, equipPlanVo)
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

function destroy(self)
    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]