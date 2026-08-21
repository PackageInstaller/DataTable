require("buff_logic_base")
_class("BuffLogicChangeHybridSkillPreviewState", BuffLogicBase)
BuffLogicChangeHybridSkillPreviewState = BuffLogicChangeHybridSkillPreviewState

function BuffLogicChangeHybridSkillPreviewState:Constructor(buffInstance, logicParam)
  self._state = logicParam.state
end

function BuffLogicChangeHybridSkillPreviewState:DoLogic()
  local e = self._buffInstance:Entity()
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    buffCmpt:SetBuffValue("HybridSkillPreviewState", self._state)
    self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, e:GetID(), "HybridSkillPreviewState", self._state)
  end
end

_class("BuffLogicUndoChangeHybridSkillPreviewState", BuffLogicBase)
BuffLogicUndoChangeHybridSkillPreviewState = BuffLogicUndoChangeHybridSkillPreviewState

function BuffLogicUndoChangeHybridSkillPreviewState:DoLogic()
  local e = self._buffInstance:Entity()
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    buffCmpt:SetBuffValue("HybridSkillPreviewState", nil)
    self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, e:GetID(), "HybridSkillPreviewState", nil)
  end
end
