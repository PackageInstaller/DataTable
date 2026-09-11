local PolyhedronHeroLongHead = class("PolyhedronHeroLongHead", HeroLongHead)

function PolyhedronHeroLongHead:GetHeroUnLock()
	return PolyhedronData:GetPolyhedronHeroUnlock(self.heroInfo_.id)
end

function PolyhedronHeroLongHead:SetHeroData(arg_2_1, arg_2_2)
	PolyhedronHeroLongHead.super.SetHeroData(self, arg_2_1, arg_2_2)

	self.headIcon_.sprite = HeroTools.GetHeadSprite(self.heroInfo_.using_skin)

	if PolyhedronAction:GetPolyhedronHeroRedPointCount(self.heroId_) > 0 then
		manager.redPoint:SetRedPointIndependent(self.noticePos_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.noticePos_, false)
	end
end

function PolyhedronHeroLongHead:SetRedPoint()
	SetActive(self.noticePos_.gameObject, PolyhedronAction:GetPolyhedronHeroRedPointCount(self.heroId_) > 0)
end

return PolyhedronHeroLongHead
