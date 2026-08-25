local AwakerBasePageComp, Super = System.NewComponent("AwakerBasePageComp")

function AwakerBasePageComp:ctor()
  Super.ctor(self)
end

function AwakerBasePageComp:GetOpenAnim()
  assert("子类实现PlayEnterAnim")
end

function AwakerBasePageComp:GetCloseAnim()
  assert("子类实现PlayCloseAnim")
end

function AwakerBasePageComp:GetEnterDetailAnim()
  assert("子类实现PlayEnterDetailAnim")
end

function AwakerBasePageComp:GetExitDetailAnim()
  assert("子类实现PlayCloseDetailAnim")
end

function AwakerBasePageComp:OnOpen()
end

function AwakerBasePageComp:OnClose()
end

function AwakerBasePageComp:OnEnterDetail()
end

function AwakerBasePageComp:OnExitDetail()
end

function AwakerBasePageComp:OnOpenAnimFinish()
end

function AwakerBasePageComp:OnCloseAnimFinish()
end

function AwakerBasePageComp:OnEnterDetailAnimFinish()
end

function AwakerBasePageComp:OnExitDetailAnimFinish()
end

return AwakerBasePageComp
