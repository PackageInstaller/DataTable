
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils
--endregion

--region import
local Application                 = CS.UnityEngine.Application
---@type ActivityUtils
local ActivityUtils               = import("Game.Activity.ActivityUtils")
---@type HotPointCollectionComponent
local component                   = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HotPointCollectionComponent)
---@type HotPointCollectionConstants
local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")
---@type GoodsConfMgr
local goodsConfMgr                = GoodsConfMgr:GetInstance()
--endregion

--region define

local CELL_ANIM_NAME = {
    HIDE = 'UI_Common_List_Cell_Hide',
    IDLE = 'UI_Common_List_Cell_Idle',
    SHOW = 'HotpointAssociatedNode_List_Cell_Show',
    WAIT = 'UI_Common_List_Cell_Wait',
}

--endregion

--- from: Assets/BundleResources/Prefabs/Hotpoint/HotpointAssociatedNode.prefab > name: HotpointAssociatedNode
---@class HotPointCollectionAssociatedNode
---@field Env                           	HotPointCollectionAssociatedNode        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FinishGroup                   	UnityEngine.RectTransform               
---@field TxtNotStarted                 	UnityEngine.RectTransform               
---@field TxtTime                       	UnityEngine.UI.Text                     
---@field TimeLayout                    	UnityEngine.RectTransform               
---@field ImgGo                         	UnityEngine.RectTransform               
---@field OpenGroup                     	UnityEngine.RectTransform               
---@field CommonWebImageGroup           	UnityEngine.RectTransform               
---@field Button                        	UnityEngine.RectTransform               
---@field AnimationComp                 	UnityEngine.Animation                   
local HotPointCollectionAssociatedNode = Class('HotPointCollectionAssociatedNode')

function HotPointCollectionAssociatedNode:__init()

end


function HotPointCollectionAssociatedNode:__delete()
    self._aniCb = nil
end


function HotPointCollectionAssociatedNode:Awake()
    self:PlayAnimByHide()
    -- local RootTrans = self.controller.transform:Find("Root")
    -- self.RootTrans = RootTrans
    -- self._originLocalScale = RootTrans.localScale
    -- self._originLocalScale = self.Root.alpha
    -- self:PlayAnimByHide()
end


function HotPointCollectionAssociatedNode:Start()
    self._isStart = true
    if self._aniCb then
        self._aniCb()
        self._aniCb = nil
    end
    SetButtonAction(self.Button, Bind(self, self.OnClickButtonAction))
end


function HotPointCollectionAssociatedNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param data table
--- ----  type int 类型1活动 2功能
--- ----  tab int 页签
--- ----  jumpActivityUuid int 关联活动唯一id
--- ----  functionId int 系统功能表id
--- ----  startTime int 开始时大于0倒计时 小于0 已开启的时间
--- ----  endTime int 倒计时大于0倒计时 小于0 已结束
--- ----  hotspotCollectionImage str 热点活动图
function HotPointCollectionAssociatedNode:FreshUI(data, curTime)
    -- local isExistUrl = not string.isEmpty(data.hotspotCollectionImage)
    self._data = data
    --- 活动页签图
    -- CfUtils.SetActive(self.ImgTab,       isExistUrl)
    -- CfUtils.SetActive(self.ImgLoading,   isExistUrl)
    -- if isExistUrl then
        -- CfUtils.FillWebRawImage(data.hotspotCollectionImage)
    -- end
    UICommonUtils.LoadWebTexture(self.CommonWebImageGroup, component:GetTexturePool(), data.hotspotCollectionImage)
    
    local isStart  = curTime >= data.startTime
    local isFinish = curTime >= data.endTime

    CfUtils.SetActive(self.OpenGroup,   not isFinish)
    CfUtils.SetActive(self.FinishGroup, isFinish)
    if not isFinish then
        CfUtils.SetActive(self.ImgGo,   isStart)
        CfUtils.SetActive(self.TxtNotStarted,  not isStart)

        --- 活动时间
        local text
        if isStart then
            text = localize("剩余时间：_time_",{_time_ = ActivityUtils.ConventLeftTimeText(data.endTime)})
        else
            text = ActivityUtils.ConventActivityDojoDurationTime(data)
        end

        self.TxtTime.text = text

    end
    
    
end

function HotPointCollectionAssociatedNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.HIDE)
end


function HotPointCollectionAssociatedNode:PlayAnimByIdle()
    if not self._isStart then
        self._aniCb = function() 
            CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
        end
        return
    end
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
end


function HotPointCollectionAssociatedNode:PlayDelayAnimByShow(delayIndex)
    if not self._isStart then
        self._aniCb = function ()
            CfUtils.PlayDelayShowAnimation(self.controller.gameObject, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
        end
        return
    end
    CfUtils.PlayDelayShowAnimation(self.controller.gameObject, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end

--endregion 


--region get/set 


---endregion 


--region handler 

function HotPointCollectionAssociatedNode:OnClickButtonAction()
    local data = self._data
    local functionId = checkNumber(data.functionId)
    local row
    if functionId > 0 then
        row = goodsConfMgr:GetJumpModuleRow(functionId)
        if not goodsConfMgr:CheckIsCanJump(row) then
            return
        end
    end

    local dataType   = data.type
    local isActivity = dataType == HotPointCollectionConstants.DataType.Activity
    local isModule   = dataType == HotPointCollectionConstants.DataType.Module
    if isActivity then
        if ActivityUtils.IsActivityStart(data) then
            if ActivityUtils.IsActivityEnabled(data) then
                local activityUUID = data.jumpActivityUuid
                component:SetIsDisableLoop(true)
                goodsConfMgr:ExecuteJump(row, nil, nil, nil, activityUUID)
            else
                GameUtils.Toast(localize("活动已结束"))
            end
        else
            GameUtils.Toast(localize("活动未开启")) 
        end

    elseif isModule then
        local link   = data.link
        if not string.isEmpty(link) then
            component:SetIsDisableLoop(true)
            CfUtils.OpenURL(link)
        else
            printError("链接地址为空")
        end
    end


end

---endregion 


return HotPointCollectionAssociatedNode
