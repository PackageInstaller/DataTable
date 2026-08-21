require("buff_logic_base")
_class("BuffLogicChangeHybridSkillPreviewParam", BuffLogicBase)
BuffLogicChangeHybridSkillPreviewParam = BuffLogicChangeHybridSkillPreviewParam

function BuffLogicChangeHybridSkillPreviewParam:Constructor(buffInstance, logicParam)
  self._param = logicParam.param
end

function BuffLogicChangeHybridSkillPreviewParam:DoLogic()
  local e = self._buffInstance:Entity()
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    buffCmpt:SetBuffValue("HybridSkillPreviewParam", self._param)
    self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, e:GetID(), "HybridSkillPreviewParam", self._param)
  end
end

_class("BuffLogicUndoChangeHybridSkillPreviewParam", BuffLogicBase)
BuffLogicUndoChangeHybridSkillPreviewParam = BuffLogicUndoChangeHybridSkillPreviewParam

function BuffLogicUndoChangeHybridSkillPreviewParam:DoLogic()
  local e = self._buffInstance:Entity()
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    buffCmpt:SetBuffValue("HybridSkillPreviewParam", nil)
    self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, e:GetID(), "HybridSkillPreviewParam", nil)
  end
end
