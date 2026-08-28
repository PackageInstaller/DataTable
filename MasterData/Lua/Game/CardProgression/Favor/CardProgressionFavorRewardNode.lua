
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
------------ import ------------


------------ define ------------
local FavorRewardType = CardProgressionConstants.FavorRewardType
local AniName = "CultivateOverseaFeelingRewardNodeloop"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFeelingRewardNode.prefab > name: CultivateOverseaFeelingRewardNode
---@class CardProgressionFavorRewardNode
---@field Env                           	CardProgressionFavorRewardNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field redPoint                      	UnityEngine.RectTransform               
---@field TextNumberImproveLimit        	TMPro.TextMeshProUGUI                   
---@field ImproveLimit                  	UnityEngine.RectTransform               
---@field AnimRoot                      	UnityEngine.Animation                   
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field HasReceived                   	UnityEngine.RectTransform               
---@field ImgGoodsIcon2                 	Engine.UI.ImageAlterable             
---@field ImgGoodsIcon                  	Engine.UI.ImageAlterable             
---@field ImgGoodsIconRoot              	UnityEngine.Animation                   
---@field CanReceive                    	UnityEngine.RectTransform               
---@field Preload                       	UnityEngine.RectTransform               
local CardProgressionFavorRewardNode = Class('CardProgressionFavorRewardNode')

function CardProgressionFavorRewardNode:__init()

end


function CardProgressionFavorRewardNode:__delete()

end


function CardProgressionFavorRewardNode:Awake()
end


function CardProgressionFavorRewardNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickNodeAction))
end


function CardProgressionFavorRewardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------
--- FreshUI
---@param data table{
---@    vo: FavorableExpRewardVo
---@    expData: table {exp, totalExp}
---@}
---@
---@param isReceived boolean 是否领取
---@param favorLevel number 好感度等级
function CardProgressionFavorRewardNode:FreshUI(data, isReceived, favorLevel, originFavorLevel, cardId, originFavorLevelData)
    self._data = data
    self._cardId = cardId
    ---@type FavorableExpRewardVo
    local vo = data.vo
    local level = vo.level
    --- 0: 不能领取 1: 可领取 2: 预览 3: 已领取 
    local status = 0
    if isReceived then
        status = 3
    elseif originFavorLevel >= level then
        status = 1        
    elseif favorLevel >= level then
        status = 2        
    end

    if self._status ~= status then
        self._status = status

        local function GetPhotoPath()
            local rewardIcon = vo.rewardIcon
            if string.isEmpty(rewardIcon) then
                return nil
            end
            return rewardIcon
        end
        local photoPath = GetPhotoPath()
        local isShowEffect = photoPath ~= nil
        if isShowEffect then
            self.ImgGoodsIcon:LoadSprite(photoPath)
            self.ImgGoodsIcon2:LoadSprite(photoPath)
            KTool.SetActive(self.Preload.gameObject,     status == 2)
            KTool.SetActive(self.CanReceive.gameObject,  status == 1)
            KTool.SetActive(self.HasReceived.gameObject, status == 3)

            if status == 2 then
                self.ImgGoodsIconRoot:Play(AniName)
            else
                self.ImgGoodsIconRoot:Stop()
            end
            KTool.SetActive(self.redPoint.gameObject, status == 1)
        else
            self.ImgGoodsIconRoot:Stop()
        end

        self.TextNumber.text = level
        
    end

    --- 下一等级的奖励如果有心情值上限提升，在按钮上方显示图标和动效
    local isShowImproveLimit = (originFavorLevel + 1) == level and vo.mood ~= originFavorLevelData.vo.mood
    KTool.SetActive(self.ImproveLimit.gameObject, isShowImproveLimit)
    if isShowImproveLimit then
        self.TextNumberImproveLimit.text = string.format("+%s", vo.mood)
    end
    
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionFavorRewardNode:SetCallback(callback)
    self._callback = callback
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionFavorRewardNode:OnClickNodeAction()
    --- 0: 不能领取 1: 可领取 2: 预览 3: 已领取 
    
    if self._status == 1 then
        if self._callback then
            self._callback(self._data)
        end
    elseif self._status == 0 or self._status == 2 then
        CardProgressionUtils.ShowFavorRewardTips(self.controller.gameObject, self._data, self._cardId)
    end

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFavorRewardNode
