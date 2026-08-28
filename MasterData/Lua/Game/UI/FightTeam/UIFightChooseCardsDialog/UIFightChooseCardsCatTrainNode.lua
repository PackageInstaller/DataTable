---
--- Created by Eric.
--- DateTime: 2022/3/22 15:40
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

------------ import ------------

------------ define ------------

------------ define ------------


---@class UIFightChooseCardsCatTrainNode
---@field EstimatedAddition             	UnityEngine.RectTransform
---@field CultivationAddition           	UnityEngine.RectTransform
---@field RoleInformation               	UnityEngine.RectTransform
---@field AttributeNode                 	UnityEngine.RectTransform
---@field LayoutAtrribute               	UnityEngine.RectTransform
---@field AdditionList                  	SuperScrollView.LoopGridView
---@field StarLevel                     	StarProgressNode
---@field GradeNum                      	TMPro.TextMeshProUGUI
---@field CardName                      	UnityEngine.UI.Text
---@field BtnLevelUp                    	UnityEngine.RectTransform
local UIFightChooseCardsCatTrainNode = Class("UIFightChooseCardsCatTrainNode")
function UIFightChooseCardsCatTrainNode:__init()
    --self.btnAction = nil
    self.cardData = nil
    self.cardSkillData = {}
    self.catAttrVo = {}
    self.attrNodeMap = {}


end

function UIFightChooseCardsCatTrainNode:__delete()
    --self.btnAction = nil
    self.cardData = nil
    self.cardSkillData = nil
    self.catAttrVo = nil
    self.attrNodeMap = nil

    self.controller = nil
end

-----SetCallBack
-----设置单击回调函数
--function UIFightChooseCardsCatTrainNode:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

function UIFightChooseCardsCatTrainNode:Awake()
    --KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end

end

function UIFightChooseCardsCatTrainNode:SetInitialAttrPanel(catData)
    self.catData = catData
    if #self.catAttrVo == 0 then
        self.catAttrVo = CfUtils.GetWholeVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo")
    end
    for i, v in pairs(self.catAttrVo) do
        --当前基础属性刷新
        --totalGrowthValueNow = totalGrowthValueNow + currentCatData.attr[checkString(v.id)]
        local go
        go = self.attrNodeMap[tostring(v.id)]
        if not go then
            go = CfUtils.InstantiateGo(self.AttributeNode, self.LayoutAtrribute)
            go.name = "Node" .. v.id
            self.attrNodeMap[tostring(v.id)] = go
        end
        local goEnv = CfUtils.GetLuaScr(go, "Game.CatHouse.Interaction.CatHouseInteractionAttributeNode")
        local attrData = {
            id = v.id,
            num = catData.attr[checkString(v.id)],
            subJoin = 0,
            --upperLimit = v.upperLimit
        }
        goEnv:SetCatData(self.catData)--设置猫数据，训练技能需要用到
        goEnv:FreshBaseUI(self.catAttrVo[i])--非数字部分
        goEnv:FreshAttrValue(attrData)--数字部分
        KTool.SetActive(go, true)
    end
end



function UIFightChooseCardsCatTrainNode:FreshBaseUI(cardData)
    self.cardData = cardData
    local vo =  CfUtils.GetCfVo(AutoIds.IdSetting1915, "CatCardTrainSkillVo", cardData.refId)
    KTool.SetActive(self.RoleInformation, true)
    KTool.SetActive(self.CultivationAddition, true)
    KTool.SetActive(self.EstimatedAddition, true)
    local cardDojo = cardComponent:GetCardById(cardComponent:GetIdByCardId(cardData.refId))
    SetButtonAction(self.BtnLevelUp, function()
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        --local cardDojo = cardComponent:GetCardById(cardComponent:GetIdByCardId(cardData.refId))
        CardUtils.ShowCultivateMain({JumpFrom = JumpFromType.JF_TeamChoose2, selectCardDojo = cardDojo})
        Events.Broadcast(Constants.EventNames.FightChooseCardsDialogAct,{isTrue = false})
        --Events.Broadcast(Constants.EventNames.UIEntrustBattleTeamDialogActive,{isTrue = false})
    end)
    local dataVo = CardConfMgr:GetInstance():GetCardByRefId(cardData.refId)
    self.CardName.text = dataVo.name
    self.GradeNum.text = checkInt(cardDojo.star) == Constants.CardMaxStar and "MAX" or cardDojo.cardLevel
    self.StarLevel:SetStarNo(Constants.CardMaxStar, checkNumber(cardDojo.star))
    self.cardSkillData = vo.skillGroup
    if not self.AdditionList.IsListViewInit then
        self.AdditionList:InitGridView(#self.cardSkillData, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.AdditionList, #self.cardSkillData)
    end

    --猫屋不跳
    CfUtils.SetActive(self.BtnLevelUp, false)
end

function UIFightChooseCardsCatTrainNode:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.FightTeam.UIFightChooseCardsDialog.UIFightChooseCardsCatTrainAdditionCell")
    if nodeEnv then
        local luaIndex = index + 1
        local data = self.cardSkillData[luaIndex]
        nodeEnv:FreshBaseUI(data, self.cardData, self.catData)
    end
    return cell
end

function UIFightChooseCardsCatTrainNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return UIFightChooseCardsCatTrainNode