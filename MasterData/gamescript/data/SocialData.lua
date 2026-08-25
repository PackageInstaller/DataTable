local SocialData = Vue.reactive({})
SocialData.myPlayer = {}
SocialData.relationListMap = {}
SocialData.relationListUidMap = {}
SocialData.followListUid2facadeMap = {}
SocialData.onlineState = ""
SocialData.strangerMap = {}
SocialData.firstRequestStranger = true
SocialData.previewAwakerData = {}
SocialData.unfollowingList = {}
SocialData.isUnfollowing = false
SocialData.assetAwakerCount = 0
SocialData.facadeMap = {}
return SocialData
