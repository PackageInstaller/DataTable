local this = class("cellExploreTxt", G_UIModuleBase)
local txtPosAndRot = {
  [1] = {
    [1] = -63.49,
    [2] = -20.34,
    [3] = 56
  },
  [2] = {
    [1] = -57.84,
    [2] = -12.29,
    [3] = 52
  },
  [3] = {
    [1] = -51.89,
    [2] = -4.46,
    [3] = 44
  },
  [4] = {
    [1] = -43.71,
    [2] = 2.33,
    [3] = 40
  },
  [5] = {
    [1] = -34.85,
    [2] = 3,
    [3] = 40
  },
  [6] = {
    [1] = -29.95,
    [2] = 10.04,
    [3] = 28
  },
  [7] = {
    [1] = -20.29,
    [2] = 13.67,
    [3] = 22
  },
  [8] = {
    [1] = -11.94,
    [2] = 11.71,
    [3] = 22
  },
  [9] = {
    [1] = -4.89,
    [2] = 16.92,
    [3] = 0
  },
  [10] = {
    [1] = 5.36,
    [2] = 16.92,
    [3] = 0
  }
}

function this.bind()
  return {
    txt = "",
    localRot = C_Vector3.zero,
    localPos = C_Vector3.zero
  }
end

function this:open()
  if self.isBind and not math.isEmpty(self.bind.index) then
    self.bind.localRot = L_Vector3.new(0, 0, txtPosAndRot[self.bind.index][3])
    self.bind.localPos = L_Vector3.new(txtPosAndRot[self.bind.index][1], txtPosAndRot[self.bind.index][2], 0)
  end
end

return this
