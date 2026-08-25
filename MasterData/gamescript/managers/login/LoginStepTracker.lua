local LoginStepTracker, Super = System.NewClass("LoginStepTracker")

function LoginStepTracker:ctor()
end

function LoginStepTracker:TrackStep(step)
end

function LoginStepTracker:Dispose()
end

LoginStepTracker.Instance = LoginStepTracker()
return LoginStepTracker
