--- from: Assets/BundleResources/Timeline/Prefab/gacha_clothing/gacha_clothing_pu.prefab > name: gacha_clothing_pu
---@class ActivityGachaponSkinNormaTimeLine
---@field Env                           	ActivityGachaponSkinNormaTimeLine       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Camera                        	UnityEngine.Camera                      
---@field gacha_clothing_pu             	UnityEngine.Playables.PlayableDirector  
local ActivityGachaponSkinNormaTimeLine = Class('ActivityGachaponSkinNormaTimeLine')
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local KTool = CS.Engine.Lib.KTool 
function ActivityGachaponSkinNormaTimeLine:__init()
end


function ActivityGachaponSkinNormaTimeLine:__delete()
end


function ActivityGachaponSkinNormaTimeLine:Awake()
end
function ActivityGachaponSkinNormaTimeLine:SetCamera()
    KTool.SetActive(URPCameraController.mainCamera, false)
    URPCameraController:InitCameraStack(self.Camera)
    KTool.SetActive(self.Camera , true)
end
function ActivityGachaponSkinNormaTimeLine:DisableCamera()
    KTool.SetActive(self.Camera , false)
    KTool.SetActive(URPCameraController.mainCamera, true)
end


function ActivityGachaponSkinNormaTimeLine:Start()
    
end

function ActivityGachaponSkinNormaTimeLine:GetTime()
    return self.gacha_clothing_pu.duration
end

function ActivityGachaponSkinNormaTimeLine:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityGachaponSkinNormaTimeLine
