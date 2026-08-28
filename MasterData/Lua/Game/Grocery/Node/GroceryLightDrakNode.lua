-------------------------------------------------------------------------------
-- GroceryLightDrakNode Brief
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-05 16:26:32
-------------------------------------------------------------------------------

local GroceryClubNode = import('Game.Grocery.Node.GroceryClubNode')
---@type GroceryMgr
local GroceryMgr = import('Game.Grocery.GroceryMgr'):GetInstance()
---@type GroceryConstants
local GroceryConstants = import('Game.Grocery.GroceryConstants')
---@type GroceryUtils
local GroceryUtils = import('Game.Grocery.GroceryUtils')


--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreLightDrakDialog.prefab > name: OverseaStoreLightDrakDialog
---@class GroceryLightDrakNode
---@field Env                           	GroceryLightDrakNode                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LockTextDesc                  	UnityEngine.RectTransform               	@ 0    
---@field Lock                          	UnityEngine.RectTransform               	@ 1    
---@field Viewport                      	UnityEngine.RectTransform               	@ 2    
---@field Content                       	UnityEngine.RectTransform               	@ 3    
---@field Root                          	UnityEngine.Animation                   	@ 4    
---@field TabScrollView                 	SuperScrollView.LoopGridView            	@ 5    
---@field Right                         	UnityEngine.RectTransform               	@ 6    
---@field Left                          	UnityEngine.RectTransform               	@ 7    
---@field RefreshTimer                  	UnityEngine.RectTransform               	@ 8    
---@field TimerGroup                    	UnityEngine.RectTransform               	@ 9    
---@field ScrollView                    	Engine.UI.AutoFixSizeListView           	@ 10   
---@field Container                     	UnityEngine.RectTransform               	@ 11   
local GroceryLightDrakNode = Class("GroceryLightDrakNode", GroceryClubNode)


function GroceryLightDrakNode:__init()
    GroceryClubNode.__init(self)
end


function GroceryLightDrakNode:__delete()
    GroceryClubNode.__delete(self)
end


function GroceryLightDrakNode:Start()
    GroceryClubNode.Start(self)
end


function GroceryLightDrakNode:OnDestroy()
    GroceryClubNode.OnDestroy(self)
end


-------------------------------------------------
-- override

--- 初始化顶部页签
---@return boolean 是否启用顶部页签
function GroceryLightDrakNode:InitTopTabState()
    return true
end


---初始化刷新定时器
---@return integer or nil
function GroceryLightDrakNode:InitRefreshTimer()
    local refreshSeconds = GroceryClubNode.InitRefreshTimer(self)
    return checkInt(refreshSeconds) >= 0 and refreshSeconds or nil
end


--- 初始化杂货铺类型
---@return GroceryConstants.GroceryType
function GroceryLightDrakNode:InitGroceryType()
    return GroceryConstants.GroceryType.LightDark
end


--- 获取当前商店数据
---@return table
function GroceryLightDrakNode:GetMallData()
    return GroceryMgr:GetLightDarkData()
end


--- 顶部页签 指定位置 解锁条件id
---@param tabIndex integer
---@return integer
function GroceryLightDrakNode:GetTopTabUnlockIdByIndex(tabIndex)
    return GroceryConstants.LightDarkUnlockConfig[tabIndex]
end


return GroceryLightDrakNode
