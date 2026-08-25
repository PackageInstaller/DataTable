local UpdateArgs = System.NewClass("UpdateArgs")

function UpdateArgs:ctor(machine, state)
  self.Machine = machine
  self.State = state
end

return UpdateArgs
