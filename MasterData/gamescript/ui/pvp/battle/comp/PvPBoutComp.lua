local PvPCamp = CommonDefine.PvPCamp
local PvPBoutComp, Super = System.NewComponent("PvPBoutComp")

function PvPBoutComp:ctor(uiNode, mainModel)
  Super.ctor(self)
  self.ui = UI_Pvp_Panel_MainResource(uiNode)
  self.model = mainModel
end

function PvPBoutComp:OnBind(binder)
  self.binder = binder
  local model = self.model
  binder:BindToText(self.ui.Text_Countdown, function()
    return model.boutCountDown
  end)
  binder:BindToVisible(self.ui.Group_Countdown, System.fn(self, self._NeedShowCountDown))
  self:_OnBindBoudEndBtnAnim()
  self:PVPTEST()
end

function PvPBoutComp:OnEndBout()
end

function PvPBoutComp:_NeedShowCountDown()
  local needShowCount = DT.GetConstant("PVPTurnCountdown", 0)
  return needShowCount >= self.model.boutCountDown
end

function PvPBoutComp:PVPTEST()
  local model = self.model
  self.binder:BindButtonClick(self.ui.Btn_Battle_EndOfTurn, function()
    model:SetBattleRst(true)
    model.settleModel:SetPlayerTeamSettleDataGroup({
      [1] = {
        type = CommonDefine.PvPUnitSettleType.Keeper,
        tid1 = 566767,
        tid2 = 567544,
        settleData = {
          damage = 1000,
          heal = 100,
          shield = 200
        }
      },
      [2] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 28,
        tid2 = 466087,
        settleData = {
          damage = 2000,
          heal = 300,
          shield = 400
        }
      },
      [3] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 1443,
        tid2 = 466087,
        settleData = {
          damage = 2100,
          heal = 10,
          shield = 260
        }
      },
      [4] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 243,
        tid2 = 466690,
        settleData = {
          damage = 13000,
          heal = 1200,
          shield = 2100
        }
      },
      [5] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 23,
        tid2 = 467589,
        settleData = {
          damage = 15000,
          heal = 1200,
          shield = 2100
        }
      }
    })
    model.settleModel:SetEnermyTeamSettleDataGroup({
      [1] = {
        type = CommonDefine.PvPUnitSettleType.Keeper,
        tid1 = 566767,
        tid2 = 567544,
        settleData = {
          damage = 1000,
          heal = 100,
          shield = 200
        }
      },
      [2] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 28,
        tid2 = 466087,
        settleData = {
          damage = 2000,
          heal = 300,
          shield = 400
        }
      },
      [3] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 1443,
        tid2 = 466087,
        settleData = {
          damage = 2100,
          heal = 10,
          shield = 260
        }
      },
      [4] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 243,
        tid2 = 466690,
        settleData = {
          damage = 13000,
          heal = 1200,
          shield = 2100
        }
      },
      [5] = {
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = 23,
        tid2 = 467589,
        settleData = {
          damage = 15000,
          heal = 1200,
          shield = 2100
        }
      }
    })
    UIManager.Instance:Reopen(Urls.PVPBattleDataSettlePanel, self.model)
  end)
end

function PvPBoutComp:_OnBindBoudEndBtnAnim()
end

return PvPBoutComp
