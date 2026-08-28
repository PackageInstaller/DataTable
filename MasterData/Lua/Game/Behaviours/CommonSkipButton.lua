
--region global define

--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

--endregion

---@class CommonSkipButton
--- from: Assets/BundleResources/Prefabs/Common/CommonSkipButton.prefab
---@field Env                           	CommonSkipButton                        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnSkip                       	UnityEngine.RectTransform               
local CommonSkipButton = Class('CommonSkipButton')

function CommonSkipButton:__init()

end


function CommonSkipButton:__delete()

end


function CommonSkipButton:Awake()
    KTool.SetActive(self.BtnSkip.gameObject, false)
end


function CommonSkipButton:Start()
    SetButtonAction(self.BtnSkip, Bind(self, self.OnClickBtnSkipAction))
end


function CommonSkipButton:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CommonSkipButton:Init(luaPath, ...)
    ---@type SimpleTimelineLoaderController
    local luaEnv = import(luaPath)
    local envInstance = luaEnv.New()
    envInstance:SetWaitCoIsStartCb(function() 
        KTool.SetActive(self.BtnSkip.gameObject, true)
    end)

    if envInstance.SetWaitCoIsEndCb then
        envInstance:SetWaitCoIsEndCb(function() 
            KTool.SetActive(self.BtnSkip.gameObject, false)
        end)
    end
    self._luaEnv = envInstance
    return envInstance:Start(...)
end

--endregion 


--region get/set 


---endregion 


--region handler 

function CommonSkipButton:OnClickBtnSkipAction()
    if isNull(self._luaEnv) then
        return
    end
    self._luaEnv:Close()
    
end

---endregion 


return CommonSkipButton
