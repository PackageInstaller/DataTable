local this = class("optiondata_shell", G_BaseConfig)
local core = G_Tables.TDOptionDataTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  functionId = 1,
  isActive = 2,
  isShow = 3,
  optionclassification1 = 4,
  optionclassification2 = 5,
  optionclassification2Name = 6,
  optionName = 7,
  optionType = 8,
  optionPara2 = 9,
  optionPara4 = 10,
  optionPara6 = 11,
  optionPara6mobile = 12,
  postpone = 13,
  defaultPara = 14,
  longpress = 15,
  changeImmediately = 16,
  allowChange = 17,
  buttonbindid = 18,
  clientType = 19,
  orderId = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFunctionid(offset)
  return core:GetInt(offset, this.indexMap.functionId)
end

function this:_getIsactive(offset)
  return core:GetInt(offset, this.indexMap.isActive)
end

function this:_getIsshow(offset)
  return core:GetInt(offset, this.indexMap.isShow)
end

function this:_getOptionclassification1(offset)
  return core:GetInt(offset, this.indexMap.optionclassification1)
end

function this:_getOptionclassification2(offset)
  return core:GetInt(offset, this.indexMap.optionclassification2)
end

function this:_getOptionclassification2name(offset)
  local langStr = G_TableMgrIns:GetLangStr("optionData", core:GetVString(offset, this.indexMap.optionclassification2Name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "optionclassification2Name")
end

function this:_getOptionname(offset)
  local langStr = G_TableMgrIns:GetLangStr("optionData", core:GetVString(offset, this.indexMap.optionName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "optionName")
end

function this:_getOptiontype(offset)
  return core:GetInt(offset, this.indexMap.optionType)
end

function this:_getOptionpara2(offset)
  local str = core:GetVString(offset, this.indexMap.optionPara2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOptionpara4(offset)
  local langStr = G_TableMgrIns:GetLangStr("optionData", core:GetVString(offset, this.indexMap.optionPara4))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "optionPara4")
end

function this:_getOptionpara6(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("optionData", core:GetVString(offset, this.indexMap.optionPara6))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "optionData")
end

function this:_getOptionpara6mobile(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("optionData", core:GetVString(offset, this.indexMap.optionPara6mobile))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "optionData")
end

function this:_getPostpone(offset)
  local str = core:GetVString(offset, this.indexMap.postpone).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDefaultpara(offset)
  return core:GetVString(offset, this.indexMap.defaultPara).value
end

function this:_getLongpress(offset)
  return core:GetInt(offset, this.indexMap.longpress)
end

function this:_getChangeimmediately(offset)
  return core:GetInt(offset, this.indexMap.changeImmediately)
end

function this:_getAllowchange(offset)
  return core:GetInt(offset, this.indexMap.allowChange)
end

function this:_getButtonbindid(offset)
  return core:GetInt(offset, this.indexMap.buttonbindid)
end

function this:_getClienttype(offset)
  local str = core:GetVString(offset, this.indexMap.clientType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOrderid(offset)
  return core:GetInt(offset, this.indexMap.orderId)
end

this.keyToMethodsMap = {
  id = this._getId,
  functionId = this._getFunctionid,
  isActive = this._getIsactive,
  isShow = this._getIsshow,
  optionclassification1 = this._getOptionclassification1,
  optionclassification2 = this._getOptionclassification2,
  optionclassification2Name = this._getOptionclassification2name,
  optionName = this._getOptionname,
  optionType = this._getOptiontype,
  optionPara2 = this._getOptionpara2,
  optionPara4 = this._getOptionpara4,
  optionPara6 = this._getOptionpara6,
  optionPara6mobile = this._getOptionpara6mobile,
  postpone = this._getPostpone,
  defaultPara = this._getDefaultpara,
  longpress = this._getLongpress,
  changeImmediately = this._getChangeimmediately,
  allowChange = this._getAllowchange,
  buttonbindid = this._getButtonbindid,
  clientType = this._getClienttype,
  orderId = this._getOrderid
}
return this
