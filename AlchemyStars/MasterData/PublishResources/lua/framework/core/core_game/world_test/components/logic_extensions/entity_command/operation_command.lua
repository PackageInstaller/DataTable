_class("AxisOperationCommand", IEntityCommand)

function AxisOperationCommand:Constructor()
  self.CommandType = "AxisOperation"
  self.AxisX = 0
  self.AxisY = 0
end
