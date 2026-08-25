local BattleCardPreviewPanel, Super = System.NewClass("BattleCardPreviewPanel", FuncBattleCardDisplayPanel)
BattleCardPreviewPanel.uiResCls = Func_Battle_CardPreviewResource

function BattleCardPreviewPanel:_OnBindGroupKeyWord()
end

function BattleCardPreviewPanel:SavePosition()
end

function BattleCardPreviewPanel:ReloadPosition()
end

function BattleCardPreviewPanel:RevertKeyWord()
end

function BattleCardPreviewPanel:_OnTouchEndEvent()
end

return BattleCardPreviewPanel
