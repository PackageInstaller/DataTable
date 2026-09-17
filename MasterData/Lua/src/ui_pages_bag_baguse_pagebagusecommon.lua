local this = class("pageBagUseCommon", G_UIPageBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local staminaId = 100000

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {curItemId = nil, curNum = 1}
end

function this.bind()
  return {
    img_icon = "",
    img_quality = "",
    txt_count = "",
    img_type = "",
    txt_type = "",
    txt_desc = "",
    module_selectNum = L_Const.ModuleInfo.SelectNum,
    module_commonTipBoard = L_Const.ModuleInfo.CommonTipBoard
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close("pageBagUseCommon")
    end,
    onClick_cancel = function(self)
      L_UI:close("pageBagUseCommon")
    end,
    onClick_close = function(self)
      L_UI:close("pageBagUseCommon")
    end,
    onClick_use = function(self)
      if self:staminaUse() then
        C_BagMgr:ReqUseItem(self.data.curItemId, self.data.curNum, nil, function(reward)
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_bag_useSuccess"))
          if C_BagMgr:getItemNumByItemId(self.data.curItemId) < 1 then
            L_UI:close(self.pageName)
          else
            self:initPage()
          end
          if self._callback then
            self._callback()
          end
        end)
      else
      end
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.data.curItemId = options.itemId
  self._callback = options.callback
  self:initPage()
end

function this:show()
  self.bind.go_blurBg = true
end

function this:initPage()
  self.data.curNum = 1
  local item = L_ItemManager:parseCommonItem(self.data.curItemId)
  self.bind.txt_name = item.name
  self.bind.img_icon = item.icon
  self.bind.img_quality = item.imgQuality
  self.bind.txt_count = tostring(C_BagMgr:getItemNumByItemId(self.data.curItemId))
  self.bind.img_type = item.imgType
  self.bind.txt_type = item.typeName
  self.bind.txt_desc = item.desc
  self:initSelectNumModule()
end

function this:initSelectNumModule()
  local function max()
    return C_BagMgr:GetMaxCanUseNum(self.data.curItemId)
  end
  
  local function func(num)
    self.data.curNum = num
  end
  
  self.modules.module_selectNum:initModule(func, max)
  func(self.data.curNum)
end

function this:staminaUse()
  if self.data.curItemId == staminaId then
    local curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
    local staminaItem = L_ItemManager:parseCommonItem(staminaId)
    local staminaOne = staminaItem.config.useFunction[1]
    local staminaLimit = tonumber(L_GameTpl:getGameConstTpl():getTplById("STAMINA_LIMIT"))
    local addStamina = staminaOne * self.data.curNum
    if staminaLimit >= curStamina + addStamina or curStamina < staminaLimit then
    else
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_stamina_limit"))
      return false
    end
  end
  return true
end

return this
