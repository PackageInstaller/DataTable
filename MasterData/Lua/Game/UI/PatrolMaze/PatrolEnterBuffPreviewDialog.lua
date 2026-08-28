-------------------------------------------------------------------------------
-- 夜寻迷宫 - 区域出战编队弹窗 - 圣物预览
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-05-04 02:59:27
-------------------------------------------------------------------------------

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolPrepareRecommendBuffPreview130201.prefab > name: PatrolPrepareRecommendBuffPreview130201
---@class PatrolEnterBuffPreviewDialog
---@field Env                           	PatrolEnterBuffPreviewDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field ClickClose                    	UnityEngine.RectTransform               	@ 1    点击区域
---@field BuffNode                      	UnityEngine.RectTransform               	@ 2    buff节点
local PatrolEnterBuffPreviewDialog = Class('PatrolEnterBuffPreviewDialog')


function PatrolEnterBuffPreviewDialog:__init()
    ---@type PatrolMazeBuffChooseBuffNode
    self.buffNodeEnv_ = nil
end


function PatrolEnterBuffPreviewDialog:__delete()
    self.buffNodeEnv_ = nil
end


function PatrolEnterBuffPreviewDialog:Awake()
    self.buffNodeEnv_ = CfUtils.GetLuaScr(self.BuffNode, 'Game.UI.PatrolMaze.PatrolMazeBuffChooseBuffNode')
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickBlockAreaHandler_))
end


function PatrolEnterBuffPreviewDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        local previewRelicId = checkInt(initParams.relicId)
        self.buffNodeEnv_:SetRelicBuff(true)
        self.buffNodeEnv_:SetShowBuffId(previewRelicId)
    end)
end


function PatrolEnterBuffPreviewDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- public

function PatrolEnterBuffPreviewDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- handler

function PatrolEnterBuffPreviewDialog:OnClickBlockAreaHandler_()
    self:Close()
end


return PatrolEnterBuffPreviewDialog
