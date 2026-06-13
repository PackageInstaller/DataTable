local title = {
	id = 0,
	activityId = 0,
	rewardChildId = 0,
	groupChildId = {},
	itemGroup = 0
}

local value = {
[1] =
{
 		id=1,
 		activityId=6010,
 		rewardChildId=1,
 		groupChildId={1,2,3},
 	itemGroup=360
},
[2] =
{
 		id=2,
 		activityId=6010,
 		rewardChildId=2,
 		groupChildId={4,5,6},
 	itemGroup=361
},
[3] =
{
 		id=3,
 		activityId=6010,
 		rewardChildId=3,
 		groupChildId={7,8,9},
 	itemGroup=362
},
[4] =
{
 		id=4,
 		activityId=6010,
 		rewardChildId=4,
 		groupChildId={1,4,7},
 	itemGroup=363
},
[5] =
{
 		id=5,
 		activityId=6010,
 		rewardChildId=5,
 		groupChildId={2,5,8},
 	itemGroup=364
},
[6] =
{
 		id=6,
 		activityId=6010,
 		rewardChildId=6,
 		groupChildId={3,6,9},
 	itemGroup=365
},
[7] =
{
 		id=7,
 		activityId=6010,
 		rewardChildId=7,
 		groupChildId={1,2,3,4,5,6,7,8,9},
 	itemGroup=366
}
}

return {title=title, value=value}