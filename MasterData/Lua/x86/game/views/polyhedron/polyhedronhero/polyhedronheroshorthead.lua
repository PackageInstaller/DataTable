local PolyhedronHeroShortHead = class("PolyhedronHeroShortHead", HeroShortHead)

function PolyhedronHeroShortHead:GetHeroUnLock()
	return PolyhedronData:GetPolyhedronHeroUnlock(self.heroInfo_.id)
end

function PolyhedronHeroShortHead:SetHeroData(arg_2_1, arg_2_2)
	PolyhedronHeroShortHead.super.SetHeroData(self, arg_2_1, arg_2_2)

	self.headIcon_.sprite = HeroTools.GetHeadSprite(self.heroInfo_.using_skin)

	if PolyhedronAction:GetPolyhedronHeroRedPointCount(self.heroId_) > 0 then
		manager.redPoint:SetRedPointIndependent(self.noticePos_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.noticePos_, false)
	end
end

function PolyhedronHeroShortHead:SetRedPoint()
	SetActive(self.noticePos_.gameObject, PolyhedronAction:GetPolyhedronHeroRedPointCount(self.heroId_) > 0)
end

return PolyhedronHeroShortHead
