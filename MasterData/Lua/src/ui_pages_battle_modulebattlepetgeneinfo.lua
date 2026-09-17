local this = class("moduleBattlePetGeneInfo", G_UIModuleBase)

function this.bind()
  return {
    moduleBattlePetGeneTip = {
      moduleName = "pages/pet/new/moduleBattlePetGeneTip"
    },
    moduleBattlePetGeneDetailsTip = {
      moduleName = "pages/pet/new/moduleBattlePetGeneTip"
    }
  }
end

function this.methods()
  return {
    moduleBattlePetGeneTip = {
      onClick = function(self)
        self:switchTip(true)
      end
    },
    moduleBattlePetGeneDetailsTip = {
      onClick = function(self)
        self:switchTip(false)
      end
    }
  }
end

function this:open()
  local scanLevel = L_PetManager:judgeShowScanPet()
  if 4 < scanLevel then
    L_ShortCutManager:registerShortCut(self.parent.pageName, C_InputManager_KeyType.EBattleGeneTipSwitch, function()
      self:switchTip(not self.isShowDetails)
    end)
  end
end

function this:close()
  L_ShortCutManager:removeShortCut(self.parent.pageName)
end

function this:show()
end

function this:hide()
end

function this:showTip()
  self.isShow = true
  self:switchTip(false)
end

function this:hideTip()
  self.isShow = false
  self.modules.moduleBattlePetGeneTip:hide()
  self.modules.moduleBattlePetGeneDetailsTip:hide()
end

function this:setPetData(data)
  self.petInfo = data
  self.modules.moduleBattlePetGeneTip:setPetData(data)
  self.modules.moduleBattlePetGeneDetailsTip:setPetData(data, true)
end

function this:switchTip(isShowDetails)
  if not self.isShow or table.isEmpty(self.petInfo) then
    return
  end
  self.isShowDetails = isShowDetails
  local scanLevel = L_PetManager:judgeShowScanPet()
  local showSwitchBtn = 4 < scanLevel
  if self.isShowDetails and showSwitchBtn then
    self.modules.moduleBattlePetGeneTip:hide()
    self.modules.moduleBattlePetGeneDetailsTip:setSelectMonster(true)
  else
    self.modules.moduleBattlePetGeneTip:setSelectMonster(showSwitchBtn)
    self.modules.moduleBattlePetGeneDetailsTip:hide()
  end
end

function this:geneIsEmpty()
end

return this
