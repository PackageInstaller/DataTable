local cs_coroutine = require 'XLua.cs_coroutine'
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local KTool = CS.Engine.Lib.KTool
--- from: Assets/BundleResources/Timeline/Prefab/gacha_clothing/gacha_clothing_te.prefab > name: gacha_clothing_te
---@class ActivityGachaponSkinSpecialTimeLine
---@field Env                           	ActivityGachaponSkinSpecialTimeLine     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field cat_loc                       	UnityEngine.Transform                   
---@field gacha_clothing_te             	UnityEngine.Playables.PlayableDirector  
---@field Camera                        	UnityEngine.Transform                   
local ActivityGachaponSkinSpecialTimeLine = Class('ActivityGachaponSkinSpecialTimeLine')

function ActivityGachaponSkinSpecialTimeLine:__init()
end


function ActivityGachaponSkinSpecialTimeLine:__delete()
end


function ActivityGachaponSkinSpecialTimeLine:Awake()
    
end
function ActivityGachaponSkinSpecialTimeLine:SetCamera()
    KTool.SetActive(URPCameraController.mainCamera, false)
    URPCameraController:InitCameraStack(self.Camera)
    KTool.SetActive(self.Camera , true)
end

function ActivityGachaponSkinSpecialTimeLine:GetTime()
    return self.gacha_clothing_te.duration
end


function ActivityGachaponSkinSpecialTimeLine:AddCat(skinId)
    local skinVo = CfUtils.GetCfVo(AutoIds.IdSetting113 , "CardSkinVo" ,skinId)
    local cardId = skinVo.roleId
    local gachaponUtils = import('Game.Gachapon.GachaponUtils')
    local cardVo = CardConfMgr:GetInstance():GetCardByRefId(cardId)
    local prefab = gachaponUtils.GetCatPrefabPathByCardId(cardId)
    local go = GameUtils.LoadBundleAsync(prefab , self.cat_loc.gameObject, false)
    local LayerMask = CS.UnityEngine.LayerMask
    
    -- go.gameObject.layer = 10
    gachaponUtils.BindTimeline(self.gacha_clothing_te , "cat_ani" , go)
    local Yielders = CS.Engine.Lib.Yielders
    gachaponUtils.EachTimelineAnimationClips(self.gacha_clothing_te , "cat_ani" , function(clip)
        if clip.displayName == "jump" then
            local ResourceModule = CS.Engine.Modules.ResourceModule
            ---@type CardProgressionConstants
            local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
            ---@type RolesVo
            local roleVo = CardConfMgr:GetInstance():GetRolesVo(cardVo.characterId)
            local catId = roleVo.catId
            local modelLoader = ResourceModule.LoadBundleAsync(string.format(CardProgressionConstants.AssetPath.JumpAnimPath, catId), nil, false)
            while not modelLoader.IsCompleted do
                coroutine.yield(Yielders.EndOfFrame)
            end
            local clipAsset = clip.asset
            local modelIns = modelLoader.ResultObject
            clipAsset.clip = modelIns
            self.gacha_clothing_te:Play()
            
        end 
    end)
end

function ActivityGachaponSkinSpecialTimeLine:DeletCatPrefab()
    -- local children = self.cat_loc.transform:GetChildren()
    KTool.DestroyGameObjectChildren(self.cat_loc.gameObject)
    -- for k, go in pairs(children) do
    --     go.gameObject:OnDestroy()
       
    --     KTool.SafeDelete(go , true)    
    -- end
end

-- ---@param director UnityEngine.Playables.PlayableDirector
-- ---@param trackName string
-- ---@param object UnityEngine.Object
-- ---@return UnityEngine.Object[]
-- function ActivityGachaponSkinSpecialTimeLine:BindTimeline(director, trackName, object)
--     ---@type UnityEngine.Playables.PlayableBinding[]
--     local support = require 'Frame.support'
--     local list = support.new_list(typeof(CS.UnityEngine.Playables.PlayableBinding))
--     list:AddRange(director.playableAsset.outputs)
--     for i = 0, list.Count - 1 do
--         if list[i].streamName == trackName then
--             director:SetGenericBinding(list[i].sourceObject, object)
--             local animClips = list[i].sourceObject:GetClips()
--             for clipIndex = 0, animClips.Count - 1 do
--                 -- print(clipList[clipIndex], clipList[clipIndex].asset, clipList[clipIndex].asset:GetType())
--                 if eachCB then
--                     local clip = clipList[clipIndex]
--                     eachCB(clip)
--                 end
--             end
--         end
--     end
--     list:Clear()
-- end
function ActivityGachaponSkinSpecialTimeLine:DisableCamera()
    KTool.SetActive(self.Camera , false)
    KTool.SetActive(URPCameraController.mainCamera, true)
end


function ActivityGachaponSkinSpecialTimeLine:Start()
end


function ActivityGachaponSkinSpecialTimeLine:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityGachaponSkinSpecialTimeLine
