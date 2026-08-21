local HauteCoutureType = {
  HC_None = 0,
  HC_GL = 1,
  HC_KR = 2,
  HC_BLH = 3,
  HC_PLM = 4,
  HC_KL_Re = 1001,
  HC_GL_Re = 1002,
  HC_KR_Re = 1003,
  HC_BLH_Re = 1004,
  HC_QT_Re = 1005,
  HC_PLM_Re = 1006,
  END = 9999
}
_enum("HauteCoutureType", HauteCoutureType)
_class("HauteCouture", Singleton)
HauteCouture = HauteCouture

function HauteCouture:Constructor()
  self.HcType = HauteCoutureType.HC_None
  self.CostCoinId = 0
end
