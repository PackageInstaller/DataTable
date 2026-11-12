local MathParkourBuffCtrl = class("MathParkourBuffCtrl", BaseCtrl)
local AssetPath = "UI_Activity/_400018/SpriteAtlas/"
MathParkourBuffCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  TMPBuffTime1 = {sComponentName = "TMP_Text"}
}
MathParkourBuffCtrl._mapEventConfig = {}
MathParkourBuffCtrl._mapRedDotConfig = {}

function MathParkourBuffCtrl:Awake()
  self.timer = nil
  self.boomTimer = nil
  self.animator = self.gameObject:GetComponent("Animator")
end

function MathParkourBuffCtrl:OnEnable()
end

function MathParkourBuffCtrl:ShowBuff(nBuffId, bPause)
  self.nBuffId = nBuffId
  local buffCfg = ConfigTable.GetData("MathParkourBuffItem", nBuffId)
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  if buffCfg.Icon ~= "" then
    self:SetPngSprite(self._mapNode.imgIcon, AssetPath .. buffCfg.Icon)
  end
  self.nCurTime = buffCfg.Time
  self.nBoomTime = buffCfg.Time
  self:SetTimeText(self.nCurTime)
  self.timer = self:AddTimer(0, 1, function()
    self.nCurTime = self.nCurTime - 1
    self.nCurTime = math.max(self.nCurTime, 0)
    if self.nCurTime <= 0 then
      self.timer:Cancel()
      self.timer = nil
      self:HideBuff()
      return
    end
    self:SetTimeText(self.nCurTime)
  end, true, true, true)
  self.timer:Pause(bPause)
  if buffCfg.ObjType == GameEnum.MathParkourBuffType.Boom then
    if self.boomTimer ~= nil then
      self.boomTimer:Cancel()
      self.boomTimer = nil
    end
    EventManager.Hit("MathParkour_BoomTime", 1.0)
    self.boomTimer = self:AddTimer(0, 0.02, function()
      self.nBoomTime = self.nBoomTime - 0.02
      if self.nBoomTime <= 0 then
        self.boomTimer:Cancel()
        self.boomTimer = nil
        return
      end
      EventManager.Hit("MathParkour_BoomTime", self.nBoomTime / buffCfg.Time)
    end, true, true, true)
    self.boomTimer:Pause(bPause)
  end
  if self.animator ~= nil then
    self.animator:Play("rtBuff_in")
  end
end

function MathParkourBuffCtrl:SetTimeText(nTime)
  nTime = math.max(nTime, 0)
  nTime = math.floor(nTime)
  local sTimeText = string.format("%02d:%02d", math.floor(nTime / 60), nTime % 60)
  NovaAPI.SetTMPText(self._mapNode.TMPBuffTime1, sTimeText)
end

function MathParkourBuffCtrl:HideBuff()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  if self.boomTimer ~= nil then
    self.boomTimer:Cancel()
    self.boomTimer = nil
  end
  if self.nBuffId ~= nil and self.nBuffId ~= 0 then
    EventManager.Hit("MathParkour_BuffTimeOut", self.nBuffId)
  end
  self.nBuffId = 0
end

function MathParkourBuffCtrl:Pause(bPause)
  if self.timer ~= nil then
    self.timer:Pause(bPause)
  end
  if self.boomTimer ~= nil then
    self.boomTimer:Pause(bPause)
  end
end

return MathParkourBuffCtrl
