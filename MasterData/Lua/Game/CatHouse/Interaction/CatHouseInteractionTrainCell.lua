---
--- Created by Eric.
--- DateTime: 2022/3/16 10:46
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

------------ import ------------

------------ define ------------

------------ define ------------


---@class CatHouseInteractionTrainCell
---@field ImgAttribute                  	Engine.UI.RawImageAlterable
---@field ImgHead                       	Engine.UI.RawImageAlterable
---@field ImgStar                       	UnityEngine.RectTransform
---@field LayoutStar                    	UnityEngine.RectTransform
---@field HasSelectedRole               	UnityEngine.RectTransform
---@field NotSelectRole                 	UnityEngine.RectTransform
---@field Effect                        	UnityEngine.RectTransform
local CatHouseInteractionTrainCell = Class("CatHouseInteractionTrainCell")
function CatHouseInteractionTrainCell:__init()
    self.btnAction = nil

    self.starNodeList = {}
    self.hasSelect = nil

end

function CatHouseInteractionTrainCell:__delete()
    self.btnAction = nil
    self.starNodeList = nil
    self.hasSelect = nil
    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseInteractionTrainCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CatHouseInteractionTrainCell:Awake()
    self.EventConfirmTrain = Events.AddListener(Constants.EventNames.CatHouseCatConfirmTrain, Bind(self, self.FreshEffectStatus))
    KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end
end

function CatHouseInteractionTrainCell:FreshBaseUI(data)
    local hasSelect = table.count(checkTable(data)) > 0
    KTool.SetActive(self.NotSelectRole, not hasSelect )
    KTool.SetActive(self.HasSelectedRole, hasSelect)
    KTool.SetActive(self.Effect, hasSelect)

    self.hasSelect = hasSelect
    if hasSelect then
        local vo =  CfUtils.GetCfVo(AutoIds.IdSetting1915, "CatCardTrainSkillVo", data.refId)
        local dataVo = CardConfMgr:GetInstance():GetCardByRefId(data.refId)
        CfUtils.SetUISwitchParticleSystem(self.Effect.transform:Find("LiuDong"), dataVo.rare)
        CfUtils.SetUISwitchParticleSystem(self.Effect.transform:Find("LiuDong2"), dataVo.rare)
        CfUtils.SetUISwitchParticleSystem(self.Effect.transform:Find("Glow"), dataVo.rare)
        CfUtils.SetUISwitchParticleSystem(self.Effect.transform:Find("Glow2"), dataVo.rare)
        local attrVo = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", vo.attributeId)
        CfUtils.FillImage(self.ImgAttribute, attrVo.picture)
        local cardDojo = cardComponent:GetCardById(cardComponent:GetIdByCardId(data.refId))
        local skinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(cardDojo.cardSkin)
        self.ImgHead:LoadSprite(skinVo.buffHead)
        for i = 1, Constants.CardMaxStar do
            local go
            go = self.starNodeList[i]
            if not go then
                go = CfUtils.InstantiateGo(self.ImgStar, self.LayoutStar)
                go.name = "Node"..i
                go.transform.localPosition = Vector3.zero
                self.starNodeList[i] = go.gameObject
            end
            KTool.SetActive(go, checkNumber(cardDojo.star) >= i)
        end
    end
end

function CatHouseInteractionTrainCell:FreshEffectStatus(data)
    if not isNull(data.isShowEffect) then
        KTool.SetActive(self.Effect,self.hasSelect and data.isShowEffect)
    end
end

function CatHouseInteractionTrainCell:OnDestroy()
    Events.RemoveListener(Constants.EventNames.CatHouseCatConfirmTrain, self.EventConfirmTrain)
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseInteractionTrainCell