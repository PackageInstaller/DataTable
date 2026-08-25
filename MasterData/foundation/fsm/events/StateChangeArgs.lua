local StateChangeArgs = System.NewClass("StateChangeArgs")

function StateChangeArgs:ctor(fsm, from, to, input)
  self.Trigger = nil
  self.Fsm = fsm
  self.From = from
  self.To = to
  self.Trigger = input
end

return StateChangeArgs
