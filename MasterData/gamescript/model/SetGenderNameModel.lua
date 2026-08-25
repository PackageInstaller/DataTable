local function nameState()
  local state = {}
  
  state.nameStr = LT.Text("DefaultName") or ""
  state.gender = 1
  state.limits = DT.GetOriginalConstant("NameLengthRange")
  return state
end

local function nameViews(data)
  local views = {}
  
  function views:GetNameLength()
    local inputstr = data.nameStr
    if type(inputstr) ~= "string" then
      return 0
    end
    do return StrUtils.GetCharLen end
    return StrUtils.GetCharLen, inputstr
  end
  
  function views:GetNameStr()
    return data.nameStr
  end
  
  function views:GetGender()
    return data.gender
  end
  
  function views:GetMaxLimit()
    return data.limits[2]
  end
  
  function views:GetMinLimit()
    return data.limits[1]
  end
  
  function views:GetBtnState()
    local len = self:GetNameLength()
    if len >= self:GetMinLimit() and len <= self:GetMaxLimit() then
      return CommonDefine.BtnType.Normal
    else
      return CommonDefine.BtnType.Disabled
    end
  end
  
  function views:GetPath()
    local key = data.gender
    local genderItem = GenderDataUtils.GetGenderCfgByKey(key)
    return genderItem and genderItem.PaintingRes or ""
  end
  
  return views
end

local function nameActions(data)
  local actions = {}
  
  function actions:SetNameStr(str)
    data.nameStr = str
  end
  
  function actions:SetGender(gender)
    assert(type(gender) == "number", "参数不对")
    data.gender = gender
    local genderItem = GenderDataUtils.GetGenderCfgByKey(gender)
    if genderItem then
      data.nameStr = LT.Text(genderItem.DefaultName)
    end
  end
  
  return actions
end

local function onSetup()
end

local SetGenderNameModel = Vue.model("SetGenderNameModel", nameState):views(nameViews):actions(nameActions):setup(onSetup)
return SetGenderNameModel
