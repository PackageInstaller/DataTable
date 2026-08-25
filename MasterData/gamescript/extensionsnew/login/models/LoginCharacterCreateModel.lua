local LoginCharacterCreateModel = NewClass("LoginCharacterCreateModel", BaseModel)

function LoginCharacterCreateModel:OnInit()
  self:OnReset()
end

function LoginCharacterCreateModel:OnReset()
  self.nameStr = LT.Text("DefaultName") or ""
  self.gender = CommonDefine.GenderID.Boy
  self.limits = DT.GetOriginalConstant("NameLengthRange")
end

function LoginCharacterCreateModel:ResetData()
  self:OnReset()
end

function LoginCharacterCreateModel:GetNameLength()
  local inputstr = self.nameStr
  if type(inputstr) ~= "string" then
    return 0
  end
  do return StrUtils.GetCharLen end
  return StrUtils.GetCharLen, inputstr
end

function LoginCharacterCreateModel:GetNameStr()
  return self.nameStr
end

function LoginCharacterCreateModel:GetGender()
  return self.gender
end

function LoginCharacterCreateModel:GetMaxLimit()
  return self.limits[2]
end

function LoginCharacterCreateModel:GetMinLimit()
  return self.limits[1]
end

function LoginCharacterCreateModel:GetBtnState()
  local len = self:GetNameLength()
  if len >= self:GetMinLimit() and len <= self:GetMaxLimit() then
    return CommonDefine.BtnType.Normal
  else
    return CommonDefine.BtnType.Disabled
  end
end

function LoginCharacterCreateModel:GetPath()
  local key = self.gender
  local genderItem = GenderDataUtils.GetGenderCfgByKey(key)
  return genderItem and genderItem.PaintingRes or ""
end

function LoginCharacterCreateModel:SetNameStr(str)
  self.nameStr = str
end

function LoginCharacterCreateModel:SetGender(gender)
  assert(type(gender) == "number", "参数不对")
  self.gender = gender
  local genderItem = GenderDataUtils.GetGenderCfgByKey(gender)
  if genderItem then
    self.nameStr = LT.Text(genderItem.DefaultName)
  end
end

return LoginCharacterCreateModel
