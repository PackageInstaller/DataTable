_class("Common_WaitUnscaledTime", Common_AsyncBase)
Common_WaitUnscaledTime = Common_WaitUnscaledTime

function Common_WaitUnscaledTime:Constructor(pManger, nWaitTime)
  self.m_nWaitTime = nWaitTime
  self.m_nWaitStart = 0
end

function Common_WaitUnscaledTime:TaskFunc(TT, outResult)
  self._beginUnscaledTimeMS = UnityEngine.Time.unscaledTime * 1000
  while UnityEngine.Time.unscaledTime * 1000 - self._beginUnscaledTimeMS < self.m_nWaitTime do
    YIELD(TT)
  end
end
