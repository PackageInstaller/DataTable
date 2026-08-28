
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define

--endregion

---@class ActionRecommendEnter
local ActionRecommendEnter = Class('ActionRecommendEnter')

function ActionRecommendEnter:__init()

end


function ActionRecommendEnter:__delete()

end


-- function ActionRecommendEnter:Awake()
-- end


function ActionRecommendEnter:Start()
    SetButtonAction(self.controller, Bind(self, self.OnClickBtnAction))
end


function ActionRecommendEnter:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

--endregion 


--region get/set 
function ActionRecommendEnter:SetParams(tipsId)
    self._tipsId = checkNumber(tipsId)

    if tipsId > 0 then
        local str    = string.format("%s_%s", "ActionRecommendEnter", tipsId)
        local isAuto = checkNumber(CfUtils.GetLocalData(str)) == 0
        self._isAuto = isAuto
        if isAuto then
            CfUtils.WriteLocalData(str, 1)
            self:OnClickBtnAction() 
        end     
    end
    
end

---endregion 


--region handler 

function ActionRecommendEnter:OnClickBtnAction() 
    if self._tipsId == nil then
        return
    end
    CfUtils.DialogOpen(Constants.UITypeIds.ActionRecommendPopup, {tipsId = self._tipsId, isAuto = self._isAuto})
    self._isAuto = false
end

---endregion 


return ActionRecommendEnter
