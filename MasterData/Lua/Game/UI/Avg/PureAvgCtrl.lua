local PureAvgCtrl = class("PureAvgCtrl", BaseCtrl)
PureAvgCtrl._mapNodeConfig = {}
PureAvgCtrl._mapEventConfig = {}

function PureAvgCtrl:Awake()
end

function PureAvgCtrl:OnEnable()
  self.bOpen = false
end

function PureAvgCtrl:OnDisable()
end

function PureAvgCtrl:OnDestroy()
end

function PureAvgCtrl:OnEventOpen()
  self.bOpen = not self.bOpen
end

return PureAvgCtrl
