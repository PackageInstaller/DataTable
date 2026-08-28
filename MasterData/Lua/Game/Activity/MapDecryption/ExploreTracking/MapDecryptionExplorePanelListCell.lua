
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/MapDecryption/MapDecryptionExploreTrackingListCell.prefab
---@class MapDecryptionExplorePanelListCell
---@field Env                           	MapDecryptionExplorePanelListCell                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field GetNode                       	UnityEngine.RectTransform               
---@field GetRewardNode                 	UnityEngine.RectTransform               
---@field GoodNode                      	UnityEngine.RectTransform               
---@field Slider                        	UnityEngine.UI.Slider                   
---@field TxtNumber                     	TMPro.TextMeshProUGUI                   
---@field TxtContent                    	UnityEngine.UI.Text                     
---@field ImgFrame2                     	Game.Native.Common.UISwitchImage        
---@field ImgFrame1                     	Game.Native.Common.UISwitchImage        
local MapDecryptionExplorePanelListCell = Class('MapDecryptionExplorePanelListCell')

function MapDecryptionExplorePanelListCell:__init()

end


function MapDecryptionExplorePanelListCell:__delete()

end


function MapDecryptionExplorePanelListCell:Awake()
end


function MapDecryptionExplorePanelListCell:Start()
end


function MapDecryptionExplorePanelListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

--- FreshUI
---@param taskEntity MapDecryptionExploreTaskEntity
function MapDecryptionExplorePanelListCell:FreshUI(taskEntity, mapId)
    
    --- 任务描述
    self.TxtContent.text = taskEntity.desc
    
    --- 任务进度
    local progress, targetNum = taskEntity.taskProgress, taskEntity.targetNum
    self.TxtNumber.text = string.format("<size=30><color=#545454>%s</color></size>/%s", progress, targetNum)
    self.Slider.value = progress/targetNum

    self:FreshGoodNode(table.takeFirst(taskEntity.rewards), taskEntity.status, taskEntity.taskId, mapId)

    self:FreshStatusUI(taskEntity)

end

function MapDecryptionExplorePanelListCell:FreshGoodNode(reward, status, taskId, mapId)
    CfUtils.RefeshGoodGo(self.GoodNode, reward.goodsId, reward.num, 0.5, nil, function() 
        if status == MapDecryptionConstants.ReceiveStatus.CanReceive then
            MapDecryptionMgr:RequestDrawTask(taskId, mapId)
        else
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(reward.goodsId)
            GameUtils.ShowCommonTipsBoard(self.GoodNode, vo.name, vo.desc, vo.quality, vo.id, true)
        end
    end)
    
end

--- FreshStatusUI
---@param taskEntity MapDecryptionExploreTaskEntity
function MapDecryptionExplorePanelListCell:FreshStatusUI(taskEntity)
    local status        = taskEntity.status
    local ReceiveStatus = MapDecryptionConstants.ReceiveStatus

    local isCanReceive  = status == ReceiveStatus.CanReceive
    local isReceived    = status == ReceiveStatus.Received

    self.ImgFrame1.Status = isCanReceive and 2 or 1
    self.ImgFrame2.Status = isCanReceive and 2 or 1

    KTool.SetActive(self.GetRewardNode.gameObject, isCanReceive)
    KTool.SetActive(self.GetNode.gameObject, isReceived)

end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionExplorePanelListCell
