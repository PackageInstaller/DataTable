-------------------------------------------------------------------------------
-- 夜寻迷宫 - 选择圣物弹窗 - 效果节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-03 17:24:40
-------------------------------------------------------------------------------
--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyBuffChooseNode140004.prefab > name: ActivityMonopolyBuffChooseNode
---@class ActivityThrowDiceBuffEffectNode
---@field Env                           	ActivityThrowDiceBuffEffectNode         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 1    动画根节点
---@field SelectBtn                     	UnityEngine.RectTransform               	@ 2    选择按钮
---@field TitleTxt                      	UnityEngine.RectTransform               	@ 3    标题文本
---@field SubTitleTxt                   	UnityEngine.RectTransform               	@ 4    子标题文本
---@field DescrTxt                      	UnityEngine.RectTransform               	@ 5    描述文本
---@field IconImg                       	UnityEngine.RectTransform               	@ 6    图标图片
---@field FrameImg                      	UnityEngine.RectTransform               	@ 7    底框图片
---@field BgImg                         	UnityEngine.RectTransform               	@ 8    背景图片
---@field QualityUIFX                   	UnityEngine.RectTransform               	@ 9    品质特效
---@field UnknownUIFX                   	UnityEngine.RectTransform               	@ 10   (不用控制)
---@field RecommendNode                 	UnityEngine.RectTransform               	@ 11   推荐选择节点
local ActivityThrowDiceBuffEffectNode = Class('ActivityThrowDiceBuffEffectNode')

local KTool = CS.Engine.Lib.KTool
function ActivityThrowDiceBuffEffectNode:__init()
    self.buffId = nil 
    self.selectCallBack = nil

end


function ActivityThrowDiceBuffEffectNode:__delete()
    self.buffId = nil 
    self.selectCallBack = nil
end


function ActivityThrowDiceBuffEffectNode:Awake()
    SetButtonAction(self.SelectBtn, Bind(self, self.OnClickBuffNodeHandler_))
end

function ActivityThrowDiceBuffEffectNode:OnClickBuffNodeHandler_()
    if self.selectCallBack then
        self.selectCallBack(self.buffId)
    end
end
function ActivityThrowDiceBuffEffectNode:Start()

end

function ActivityThrowDiceBuffEffectNode:RefreshUI(buffId , isSelect , selectCallBack )
    ---@type ThrowDiceBuffEffectVo
    local vo =  CfUtils.GetCfVo(AutoIds.IdSetting6601 , "ThrowDiceBuffEffectVo" , buffId)
    CfUtils.SetUISwitchImage(self.FrameImg , vo.quality)
    CfUtils.FillImage(self.IconImg , CfUtils.GetImageFullPath(vo.Icon))
    CfUtils.FillText(self.TitleTxt , vo.name)
    CfUtils.FillText(self.DescrTxt , vo.desc)
    KTool.SetActive(self.SelectBtn , isSelect) 
    self.buffId = buffId 
    self.selectCallBack = selectCallBack
end


function ActivityThrowDiceBuffEffectNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end







return ActivityThrowDiceBuffEffectNode
