
------------ import ------------
---@type Engine.Lib.KTool
local KTool             = CS.Engine.Lib.KTool
local Mathf             = CS.UnityEngine.Mathf
local Color             = CS.UnityEngine.Color
local Time              = CS.System.Time
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival/SpringFestivalRoleDialogueBubble.prefab
---@class MapDecryptionRoleDialogueBubble
---@field Env                           	MapDecryptionRoleDialogueBubble                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TypeGroup3LightGroup          	UnityEngine.RectTransform               
---@field TypeGroup3NormalGroup         	UnityEngine.RectTransform               
---@field TypeGroup3                    	UnityEngine.RectTransform               
---@field TypeGroup2LightGroup          	UnityEngine.RectTransform               
---@field TypeGroup2NormalGroup         	UnityEngine.RectTransform               
---@field TypeGroup2                    	UnityEngine.RectTransform               
---@field TypeGroup1LightGroup          	UnityEngine.RectTransform               
---@field TypeGroup1NormalGroup         	UnityEngine.RectTransform               
---@field TypeGroup1                    	UnityEngine.RectTransform               
---@field TxtOccupation                 	UnityEngine.UI.Text                     
---@field TxtName                       	UnityEngine.UI.Text                     
local MapDecryptionRoleDialogueBubble = Class('MapDecryptionRoleDialogueBubble')

function MapDecryptionRoleDialogueBubble:__init()

end


function MapDecryptionRoleDialogueBubble:__delete()

end


function MapDecryptionRoleDialogueBubble:Awake()
end


function MapDecryptionRoleDialogueBubble:Start()
end


function MapDecryptionRoleDialogueBubble:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

--- MapDecryptionRoleDialogueBubble
---@param mainSceneInteractionVo MapDecryptionMainSceneInteractionVo
function MapDecryptionRoleDialogueBubble:InitUI(mainSceneInteractionVo)
    self.data = mainSceneInteractionVo

    self.TxtName.text       = mainSceneInteractionVo.name
    self.TxtOccupation.text = mainSceneInteractionVo.title
    -- self.TxtOccupation.text = mainSceneInteractionVo.icon

    ---todo 获取红点显示状态
    ---@type MapDecryptionComponent
    local comp = MapDecryptionMgr:GetComponent()
    local isShowRedPoint = comp:GetBubbleRedPointStateByNpcId(mainSceneInteractionVo.id)
    
    local icon = mainSceneInteractionVo.icon
    self.TypeGroup = self[icon].gameObject
    local normalGroup, lightGroup = self[icon .. "NormalGroup"], self[icon .. "LightGroup"]
    self.NormalGroup, self.LightGroup = normalGroup, lightGroup
    KTool.SetActive(normalGroup.gameObject, not isShowRedPoint)
    KTool.SetActive(lightGroup.gameObject, isShowRedPoint)

    KTool.SetActive(self.TypeGroup, true)

    -- self.ImgType:LoadSprite(icon)
    self.alpha = 0.0 

end


--- FreshRoleInfoShowState
--- 刷新人物信息显示状态
-- 暂被下方的 FadeInAndOut() 取代
-- ---@param isShow boolean
-- function MapDecryptionRoleDialogueBubble:FreshRoleInfoShowState(isShow)
--     isShow = checkBool(isShow)
--     KTool.SetActive(self.TxtName.gameObject,       isShow)
--     KTool.SetActive(self.TxtOccupation.gameObject, isShow)
-- end


--- 几个 text 元素的淡入淡出效果
---@param isShow boolean
function MapDecryptionRoleDialogueBubble:FadeInAndOut(isShow)
    isShow = checkBool(isShow)

    local tgtAlpha = isShow and 1.0 or 0.0
    self.alpha = Mathf.MoveTowards( self.alpha, tgtAlpha, 1.0 * CS.UnityEngine.Time.deltaTime )

    local isAlphaBigEnough = self.alpha > 0.002

    if self.TxtName.gameObject.activeSelf == false then 
        if isAlphaBigEnough then 
            KTool.SetActive(self.TxtName.gameObject,       true )
            KTool.SetActive(self.TxtOccupation.gameObject, true )
        end
    else 
        if not isAlphaBigEnough then 
            KTool.SetActive(self.TxtName.gameObject,       false )
            KTool.SetActive(self.TxtOccupation.gameObject, false )
        end
    end
    
    if isAlphaBigEnough then
        local color = self.TxtName.color 
        color.a = self.alpha
        self.TxtName.color = color
        ---:
        color = self.TxtOccupation.color 
        color.a = self.alpha
        self.TxtOccupation.color = color
    end
end




--- FreshBubbleShowState
--- 刷新人物气泡显示状态
---@param isShow boolean
function MapDecryptionRoleDialogueBubble:FreshBubbleShowState(isShow)
    isShow = checkBool(isShow)
    -- KTool.SetActive(self.TypeGroup, isShow)

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

function MapDecryptionRoleDialogueBubble:OnClickBtnDialogueAction()
    if self.callback then
        self.callback(self.data)
    end
    

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionRoleDialogueBubble
