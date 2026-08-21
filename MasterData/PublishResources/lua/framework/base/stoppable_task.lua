function STOP_ST_UNSAFE(ST, id, stoppedFunc, ...)
  if TaskManager:GetInstance():StopTaskUnSafe(ST, id) and stoppedFunc then
    stoppedFunc(...)
  end
end

function YIELD_ST(ST, ms)
  YieldInternal(ST, ms)
end

function SUSPEND_ST(ST)
  SuspendInternal(ST)
end

function RESUME_ST(ST, id)
  return ResumeInternal(id)
end

function JOIN_ST(ST, child)
  JoinInternal(child)
end
