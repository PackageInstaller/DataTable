require("ai_node_new")
_class("ActionSpeak", AINewNode)
ActionSpeak = ActionSpeak

function ActionSpeak:InitializeNode(cfg, context, parentNode, configData)
  ActionSpeak.super.InitializeNode(self, cfg, context, parentNode, configData)
end

function ActionSpeak:Reset()
  ActionSpeak.super.Reset(self)
end

function ActionSpeak:OnBegin()
  local casterEntity = self.m_entityOwn
  local prob = self:GetLogicData(-1)
  local tipsList = self:GetLogicData(-2)
  local rand = Mathf.Random(1, 100)
  if prob >= rand then
    local index = Mathf.Random(1, #tipsList)
    local innerStoryService = self._world:GetService("InnerStory")
    innerStoryService:DoMonsterStoryTips(casterEntity:MonsterID():GetMonsterID(), casterEntity:GetID(), tonumber(tipsList[index]))
  end
end

function ActionSpeak:OnUpdate()
  return AINewNodeStatus.Success
end
