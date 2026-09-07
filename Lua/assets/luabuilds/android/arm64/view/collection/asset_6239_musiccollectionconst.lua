local MusicCollectionConst = class("MusicCollectionConst")

MusicCollectionConst.Version = 4
MusicCollectionConst.AutoScrollIndex = 1
MusicCollectionConst.NewCount = 21
MusicCollectionConst.MusicStates = {
	Unlockable = 2,
	Unlocked = 1,
	DirectShow = 0,
	DisUnlockable = 3
}
MusicCollectionConst.Color_Of_Normal_Song = "#343434FF"
MusicCollectionConst.Color_Of_Playing_Song = "#F4434DFF"
MusicCollectionConst.Color_Of_Empty_Song = "#9B9B9BFF"
MusicCollectionConst.Sort_Order_Up = 0
MusicCollectionConst.Sort_Order_Down = 1
MusicCollectionConst.Filte_Normal_Value = 0
MusicCollectionConst.Filte_Like_Value = 1
MusicCollectionConst.MUSIC_COVER_PATH_PREFIX = "musiccover/"
MusicCollectionConst.MUSIC_SONG_PATH_PREFIX = "cue/"
MusicCollectionConst.Still_Show_On_Lock = 0

return MusicCollectionConst
