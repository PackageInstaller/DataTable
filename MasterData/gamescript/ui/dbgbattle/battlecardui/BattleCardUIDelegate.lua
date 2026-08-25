local BattleCardUIDelegate, Super = System.NewComponent("BattleCardUIDelegate", nil, IBattleCardUIDelegate)

function BattleCardUIDelegate:ctor(ui)
  Super.ctor(self)
  self.ui = ui
end

return BattleCardUIDelegate
