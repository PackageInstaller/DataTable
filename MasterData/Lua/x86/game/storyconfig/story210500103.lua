return {
	Play1105003001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105003001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1105003002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K03h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K03h")
				var_4_0.name = "K03h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K03h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K03h

				arg_1_1.bgs_.K03h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K03h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "1050ui_story"

			if arg_1_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1050ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1, -6.1)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1050ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1050ui_story == nil then
				arg_1_1.var_.characterEffect1050ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.0166666666666667

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 2) / var_4_15)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "minigame_activity_2_0", "minigame_activity_2_0_chess_main_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 1.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1105003001).content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 49 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 49)

				if (49 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 49)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_23 = var_4_23 + 0.3

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_23 + 0.3
			local var_4_30 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1105003002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105003002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1105003003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1105003002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 48 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 48)

				if (48 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 48)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1105003003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105003003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105003004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.55

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1105003003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 22 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 22)

				if (22 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 22)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1105003004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105003004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1105003005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1105003004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 18 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 18)

				if (18 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 18)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1105003005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105003005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105003006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1105003005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 26 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 26)

				if (26 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 26)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1105003006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105003006
		arg_25_1.duration_ = 9.73

		local var_25_0 = {
			zh = 9.733,
			ja = 9.033
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1105003007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1050ui_story = arg_25_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1050ui_story"].transform.position).z)
				arg_25_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1050ui_story"].transform.localEulerAngles = arg_25_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_25_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1050ui_story"].transform.position).z)
				arg_25_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1050ui_story"].transform.localEulerAngles = arg_25_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1050ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1050ui_story == nil then
				arg_25_1.var_.characterEffect1050ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1050ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1050ui_story then
				arg_25_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = 0
			local var_28_5 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(1105003006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 40 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 40)

				if (40 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 40)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003006", "story_v_side_new_1105003.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003006", "story_v_side_new_1105003.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_new_1105003", "1105003006", "story_v_side_new_1105003.awb")

						arg_25_1:RecordAudio("1105003006", var_28_11)
						arg_25_1:RecordAudio("1105003006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003006", "story_v_side_new_1105003.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003006", "story_v_side_new_1105003.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1105003007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105003007
		arg_29_1.duration_ = 10.33

		local var_29_0 = {
			zh = 10.333,
			ja = 10
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1105003008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(1105003007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 44 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 44)

				if (44 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 44)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003007", "story_v_side_new_1105003.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003007", "story_v_side_new_1105003.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_side_new_1105003", "1105003007", "story_v_side_new_1105003.awb")

						arg_29_1:RecordAudio("1105003007", var_32_6)
						arg_29_1:RecordAudio("1105003007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003007", "story_v_side_new_1105003.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003007", "story_v_side_new_1105003.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1105003008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105003008
		arg_33_1.duration_ = 9.2

		local var_33_0 = {
			zh = 9.2,
			ja = 7.4
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1105003009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(1105003008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 43 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 43)

				if (43 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 43)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003008", "story_v_side_new_1105003.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003008", "story_v_side_new_1105003.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_side_new_1105003", "1105003008", "story_v_side_new_1105003.awb")

						arg_33_1:RecordAudio("1105003008", var_36_6)
						arg_33_1:RecordAudio("1105003008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003008", "story_v_side_new_1105003.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003008", "story_v_side_new_1105003.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1105003009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105003009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105003010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1050ui_story"]) and arg_37_1.var_.characterEffect1050ui_story == nil then
				arg_37_1.var_.characterEffect1050ui_story = arg_37_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1050ui_story"]) then
				if arg_37_1.var_.characterEffect1050ui_story and not isNil(arg_37_1.actors_["1050ui_story"]) then
					arg_37_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1050ui_story"]) and arg_37_1.var_.characterEffect1050ui_story then
				arg_37_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1105003009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 21 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 21)

				if (21 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 21)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1105003010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105003010
		arg_41_1.duration_ = 7

		local var_41_0 = {
			zh = 5.766,
			ja = 7
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1105003011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1050ui_story = arg_41_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).z)
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles = arg_41_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_41_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).z)
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles = arg_41_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1050ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1050ui_story == nil then
				arg_41_1.var_.characterEffect1050ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1050ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1050ui_story then
				arg_41_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.5

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1105003010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 20 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 20)

				if (20 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 20)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003010", "story_v_side_new_1105003.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003010", "story_v_side_new_1105003.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1105003", "1105003010", "story_v_side_new_1105003.awb")

						arg_41_1:RecordAudio("1105003010", var_44_11)
						arg_41_1:RecordAudio("1105003010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003010", "story_v_side_new_1105003.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003010", "story_v_side_new_1105003.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play1105003011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105003011
		arg_45_1.duration_ = 5.1

		local var_45_0 = {
			zh = 5.1,
			ja = 2.766
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1105003012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(1105003011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 19 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 19)

				if (19 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 19)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003011", "story_v_side_new_1105003.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003011", "story_v_side_new_1105003.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_new_1105003", "1105003011", "story_v_side_new_1105003.awb")

						arg_45_1:RecordAudio("1105003011", var_48_6)
						arg_45_1:RecordAudio("1105003011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003011", "story_v_side_new_1105003.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003011", "story_v_side_new_1105003.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105003012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105003012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1105003013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1050ui_story"]) and arg_49_1.var_.characterEffect1050ui_story == nil then
				arg_49_1.var_.characterEffect1050ui_story = arg_49_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1050ui_story"]) then
				if arg_49_1.var_.characterEffect1050ui_story and not isNil(arg_49_1.actors_["1050ui_story"]) then
					arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1050ui_story"]) and arg_49_1.var_.characterEffect1050ui_story then
				arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1105003012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 31 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 31)

				if (31 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 31)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1105003013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105003013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1105003014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.8

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1105003013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 32 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 32)

				if (32 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 32)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1105003014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1105003014
		arg_57_1.duration_ = 4.73

		local var_57_0 = {
			zh = 3.1,
			ja = 4.733
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1105003015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1050ui_story = arg_57_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1050ui_story"].transform.position).z)
				arg_57_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1050ui_story"].transform.localEulerAngles = arg_57_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_57_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1050ui_story"].transform.position).z)
				arg_57_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1050ui_story"].transform.localEulerAngles = arg_57_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1050ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1050ui_story == nil then
				arg_57_1.var_.characterEffect1050ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1050ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1050ui_story then
				arg_57_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.45

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1105003014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 18 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 18)

				if (18 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 18)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003014", "story_v_side_new_1105003.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003014", "story_v_side_new_1105003.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1105003", "1105003014", "story_v_side_new_1105003.awb")

						arg_57_1:RecordAudio("1105003014", var_60_11)
						arg_57_1:RecordAudio("1105003014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003014", "story_v_side_new_1105003.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003014", "story_v_side_new_1105003.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1105003015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1105003015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1105003016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1050ui_story"]) and arg_61_1.var_.characterEffect1050ui_story == nil then
				arg_61_1.var_.characterEffect1050ui_story = arg_61_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1050ui_story"]) then
				if arg_61_1.var_.characterEffect1050ui_story and not isNil(arg_61_1.actors_["1050ui_story"]) then
					arg_61_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1050ui_story"]) and arg_61_1.var_.characterEffect1050ui_story then
				arg_61_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.775

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1105003015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 31 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 31)

				if (31 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 31)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1105003016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1105003016
		arg_65_1.duration_ = 6.1

		local var_65_0 = {
			zh = 6.1,
			ja = 3.633
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1105003017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1050ui_story = arg_65_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1050ui_story"].transform.position).z)
				arg_65_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1050ui_story"].transform.localEulerAngles = arg_65_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_65_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1050ui_story"].transform.position).z)
				arg_65_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1050ui_story"].transform.localEulerAngles = arg_65_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1050ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1050ui_story == nil then
				arg_65_1.var_.characterEffect1050ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1050ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1050ui_story then
				arg_65_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(1105003016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 28 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 28)

				if (28 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 28)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003016", "story_v_side_new_1105003.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003016", "story_v_side_new_1105003.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_new_1105003", "1105003016", "story_v_side_new_1105003.awb")

						arg_65_1:RecordAudio("1105003016", var_68_11)
						arg_65_1:RecordAudio("1105003016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003016", "story_v_side_new_1105003.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003016", "story_v_side_new_1105003.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play1105003017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1105003017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1105003018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1050ui_story"]) and arg_69_1.var_.characterEffect1050ui_story == nil then
				arg_69_1.var_.characterEffect1050ui_story = arg_69_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1050ui_story"]) then
				if arg_69_1.var_.characterEffect1050ui_story and not isNil(arg_69_1.actors_["1050ui_story"]) then
					arg_69_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1050ui_story"]) and arg_69_1.var_.characterEffect1050ui_story then
				arg_69_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1105003017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 16 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 16)

				if (16 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 16)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1105003018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1105003018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1105003019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.85

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1105003018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 34 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 34)

				if (34 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 34)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1105003019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1105003019
		arg_77_1.duration_ = 6.33

		local var_77_0 = {
			zh = 4.866,
			ja = 6.333
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1105003020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1050ui_story = arg_77_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).z)
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles = arg_77_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_77_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).z)
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles = arg_77_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1050ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1050ui_story == nil then
				arg_77_1.var_.characterEffect1050ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1050ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1050ui_story then
				arg_77_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.3

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(1105003019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 12 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 12)

				if (12 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 12)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003019", "story_v_side_new_1105003.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003019", "story_v_side_new_1105003.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_new_1105003", "1105003019", "story_v_side_new_1105003.awb")

						arg_77_1:RecordAudio("1105003019", var_80_11)
						arg_77_1:RecordAudio("1105003019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003019", "story_v_side_new_1105003.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003019", "story_v_side_new_1105003.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1105003020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1105003020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1105003021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1050ui_story"]) and arg_81_1.var_.characterEffect1050ui_story == nil then
				arg_81_1.var_.characterEffect1050ui_story = arg_81_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1050ui_story"]) then
				if arg_81_1.var_.characterEffect1050ui_story and not isNil(arg_81_1.actors_["1050ui_story"]) then
					arg_81_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1050ui_story"]) and arg_81_1.var_.characterEffect1050ui_story then
				arg_81_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1105003020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 18 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 18)

				if (18 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 18)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1105003021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1105003021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1105003022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.05

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1105003021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 42 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 42)

				if (42 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 42)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1105003022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1105003022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1105003023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.575

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1105003022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 23 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 23)

				if (23 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 23)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1105003023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1105003023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1105003024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.9

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1105003023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 36 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 36)

				if (36 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 36)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1105003024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1105003024
		arg_97_1.duration_ = 4.9

		local var_97_0 = {
			zh = 3,
			ja = 4.9
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1105003025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1050ui_story = arg_97_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1050ui_story"].transform.position).z)
				arg_97_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1050ui_story"].transform.localEulerAngles = arg_97_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_97_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1050ui_story"].transform.position).z)
				arg_97_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1050ui_story"].transform.localEulerAngles = arg_97_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1050ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1050ui_story == nil then
				arg_97_1.var_.characterEffect1050ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1050ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1050ui_story then
				arg_97_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.525

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(1105003024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 21 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 21)

				if (21 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 21)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003024", "story_v_side_new_1105003.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003024", "story_v_side_new_1105003.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_new_1105003", "1105003024", "story_v_side_new_1105003.awb")

						arg_97_1:RecordAudio("1105003024", var_100_11)
						arg_97_1:RecordAudio("1105003024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003024", "story_v_side_new_1105003.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003024", "story_v_side_new_1105003.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play1105003025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1105003025
		arg_101_1.duration_ = 7.47

		local var_101_0 = {
			zh = 5.366,
			ja = 7.466
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1105003026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.85

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(1105003025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 34 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 34)

				if (34 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 34)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003025", "story_v_side_new_1105003.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003025", "story_v_side_new_1105003.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_side_new_1105003", "1105003025", "story_v_side_new_1105003.awb")

						arg_101_1:RecordAudio("1105003025", var_104_6)
						arg_101_1:RecordAudio("1105003025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003025", "story_v_side_new_1105003.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003025", "story_v_side_new_1105003.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1105003026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1105003026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1105003027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1050ui_story"]) and arg_105_1.var_.characterEffect1050ui_story == nil then
				arg_105_1.var_.characterEffect1050ui_story = arg_105_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1050ui_story"]) then
				if arg_105_1.var_.characterEffect1050ui_story and not isNil(arg_105_1.actors_["1050ui_story"]) then
					arg_105_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1050ui_story"]) and arg_105_1.var_.characterEffect1050ui_story then
				arg_105_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1.125

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1105003026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 45 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 45)

				if (45 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 45)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1105003027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1105003027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1105003028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.05

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1105003027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 42 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 42)

				if (42 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 42)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1105003028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1105003028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1105003029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.925

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1105003028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 37 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 37)

				if (37 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 37)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1105003029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1105003029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1105003030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1105003029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 13 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 13)

				if (13 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 13)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1105003030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1105003030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1105003031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.55

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1105003030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 62 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 62)

				if (62 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 62)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1105003031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1105003031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1105003032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.925

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1105003031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 37 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 37)

				if (37 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 37)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1105003032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1105003032
		arg_129_1.duration_ = 1

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"

			SetActive(arg_129_1.choicesGo_, true)

			for iter_130_0, iter_130_1 in ipairs(arg_129_1.choices_) do
				SetActive(iter_130_1.go, iter_130_0 <= 1)
			end

			arg_129_1.choices_[1].txt.text = arg_129_1:FormatText(StoryChoiceCfg[659].name)
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1105003033(arg_129_1)
			end

			arg_129_1:RecordChoiceLog(1105003032, 659)
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= 0 + 0.5 and arg_129_1.time_ < 0 + 0.5 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1105003033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1105003033
		arg_133_1.duration_ = 2

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1105003034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1050ui_story = arg_133_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1050ui_story"].transform.position).z)
				arg_133_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1050ui_story"].transform.localEulerAngles = arg_133_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_133_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1050ui_story"].transform.position).z)
				arg_133_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1050ui_story"].transform.localEulerAngles = arg_133_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1050ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1050ui_story == nil then
				arg_133_1.var_.characterEffect1050ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1050ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1050ui_story then
				arg_133_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.05

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(1105003033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 2 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 2)

				if (2 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 2)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003033", "story_v_side_new_1105003.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003033", "story_v_side_new_1105003.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_side_new_1105003", "1105003033", "story_v_side_new_1105003.awb")

						arg_133_1:RecordAudio("1105003033", var_136_11)
						arg_133_1:RecordAudio("1105003033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003033", "story_v_side_new_1105003.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003033", "story_v_side_new_1105003.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1105003034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1105003034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1105003035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1050ui_story"]) and arg_137_1.var_.characterEffect1050ui_story == nil then
				arg_137_1.var_.characterEffect1050ui_story = arg_137_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1050ui_story"]) then
				if arg_137_1.var_.characterEffect1050ui_story and not isNil(arg_137_1.actors_["1050ui_story"]) then
					arg_137_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1050ui_story"]) and arg_137_1.var_.characterEffect1050ui_story then
				arg_137_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.75

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1105003034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 30 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 30)

				if (30 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 30)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1105003035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1105003035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1105003036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1105003035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)

				if (34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1105003036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1105003036
		arg_145_1.duration_ = 4.57

		local var_145_0 = {
			zh = 4.566,
			ja = 1.999999999999
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1105003037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1050ui_story = arg_145_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1050ui_story"].transform.position).z)
				arg_145_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1050ui_story"].transform.localEulerAngles = arg_145_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_145_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1050ui_story"].transform.position).z)
				arg_145_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1050ui_story"].transform.localEulerAngles = arg_145_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1050ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1050ui_story == nil then
				arg_145_1.var_.characterEffect1050ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1050ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1050ui_story then
				arg_145_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.475

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(1105003036)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 19 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 19)

				if (19 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 19)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003036", "story_v_side_new_1105003.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003036", "story_v_side_new_1105003.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_side_new_1105003", "1105003036", "story_v_side_new_1105003.awb")

						arg_145_1:RecordAudio("1105003036", var_148_11)
						arg_145_1:RecordAudio("1105003036", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003036", "story_v_side_new_1105003.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003036", "story_v_side_new_1105003.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play1105003037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1105003037
		arg_149_1.duration_ = 5.7

		local var_149_0 = {
			zh = 5.7,
			ja = 4.1
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1105003038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_152_0 = 0
			local var_152_1 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(1105003037)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 31 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 31)

				if (31 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 31)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003037", "story_v_side_new_1105003.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003037", "story_v_side_new_1105003.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_side_new_1105003", "1105003037", "story_v_side_new_1105003.awb")

						arg_149_1:RecordAudio("1105003037", var_152_7)
						arg_149_1:RecordAudio("1105003037", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003037", "story_v_side_new_1105003.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003037", "story_v_side_new_1105003.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1105003038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1105003038
		arg_153_1.duration_ = 9.1

		local var_153_0 = {
			zh = 9.1,
			ja = 6.533
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1105003039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_156_0 = 0
			local var_156_1 = 0.675

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(1105003038)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 27 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 27)

				if (27 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 27)) > 0 and var_156_1 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003038", "story_v_side_new_1105003.awb") ~= 0 then
					local var_156_6 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003038", "story_v_side_new_1105003.awb") / 1000

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end

					if var_156_2.prefab_name ~= "" and arg_153_1.actors_[var_156_2.prefab_name] ~= nil then
						local var_156_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_2.prefab_name].transform, "story_v_side_new_1105003", "1105003038", "story_v_side_new_1105003.awb")

						arg_153_1:RecordAudio("1105003038", var_156_7)
						arg_153_1:RecordAudio("1105003038", var_156_7)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003038", "story_v_side_new_1105003.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003038", "story_v_side_new_1105003.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1105003039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1105003039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1105003040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1050ui_story"]) and arg_157_1.var_.characterEffect1050ui_story == nil then
				arg_157_1.var_.characterEffect1050ui_story = arg_157_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1050ui_story"]) then
				if arg_157_1.var_.characterEffect1050ui_story and not isNil(arg_157_1.actors_["1050ui_story"]) then
					arg_157_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1050ui_story"]) and arg_157_1.var_.characterEffect1050ui_story then
				arg_157_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.45

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1105003039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 18 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 18)

				if (18 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 18)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1105003040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1105003040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1105003041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.35

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1105003040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 54 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 54)

				if (54 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 54)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1105003041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1105003041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1105003042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1105003041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 8)

				if (8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 8)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1105003042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1105003042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1105003043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.675

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1105003042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 27 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 27)

				if (27 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 27)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1105003043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1105003043
		arg_173_1.duration_ = 3.1

		local var_173_0 = {
			zh = 2.333,
			ja = 3.1
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1105003044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1050ui_story = arg_173_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1050ui_story"].transform.position).z)
				arg_173_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1050ui_story"].transform.localEulerAngles = arg_173_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_173_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1050ui_story"].transform.position).z)
				arg_173_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1050ui_story"].transform.localEulerAngles = arg_173_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1050ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1050ui_story == nil then
				arg_173_1.var_.characterEffect1050ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1050ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1050ui_story then
				arg_173_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.4

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(1105003043)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 16 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 16)

				if (16 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 16)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003043", "story_v_side_new_1105003.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003043", "story_v_side_new_1105003.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_side_new_1105003", "1105003043", "story_v_side_new_1105003.awb")

						arg_173_1:RecordAudio("1105003043", var_176_11)
						arg_173_1:RecordAudio("1105003043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003043", "story_v_side_new_1105003.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003043", "story_v_side_new_1105003.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play1105003044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1105003044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1105003045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1050ui_story"]) and arg_177_1.var_.characterEffect1050ui_story == nil then
				arg_177_1.var_.characterEffect1050ui_story = arg_177_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1050ui_story"]) then
				if arg_177_1.var_.characterEffect1050ui_story and not isNil(arg_177_1.actors_["1050ui_story"]) then
					arg_177_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1050ui_story"]) and arg_177_1.var_.characterEffect1050ui_story then
				arg_177_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 1.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1105003044).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 44 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 44)

				if (44 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 44)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1105003045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1105003045
		arg_181_1.duration_ = 6.67

		local var_181_0 = {
			zh = 6.666,
			ja = 5.4
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1105003046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1050ui_story = arg_181_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1050ui_story"].transform.position).z)
				arg_181_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1050ui_story"].transform.localEulerAngles = arg_181_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_181_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1050ui_story"].transform.position).z)
				arg_181_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1050ui_story"].transform.localEulerAngles = arg_181_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1050ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1050ui_story == nil then
				arg_181_1.var_.characterEffect1050ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1050ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1050ui_story then
				arg_181_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			local var_184_4 = 0
			local var_184_5 = 0.525

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(1105003045)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 21 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 21)

				if (21 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 21)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003045", "story_v_side_new_1105003.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003045", "story_v_side_new_1105003.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_side_new_1105003", "1105003045", "story_v_side_new_1105003.awb")

						arg_181_1:RecordAudio("1105003045", var_184_11)
						arg_181_1:RecordAudio("1105003045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003045", "story_v_side_new_1105003.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003045", "story_v_side_new_1105003.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1105003046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1105003046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1105003047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1050ui_story"]) and arg_185_1.var_.characterEffect1050ui_story == nil then
				arg_185_1.var_.characterEffect1050ui_story = arg_185_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1050ui_story"]) then
				if arg_185_1.var_.characterEffect1050ui_story and not isNil(arg_185_1.actors_["1050ui_story"]) then
					arg_185_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1050ui_story"]) and arg_185_1.var_.characterEffect1050ui_story then
				arg_185_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 0.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1105003046).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 12 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 12)

				if (12 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 12)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1105003047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1105003047
		arg_189_1.duration_ = 9.2

		local var_189_0 = {
			zh = 9.2,
			ja = 5.2
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1105003048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1050ui_story = arg_189_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1050ui_story"].transform.position).z)
				arg_189_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1050ui_story"].transform.localEulerAngles = arg_189_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_189_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1050ui_story"].transform.position).z)
				arg_189_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1050ui_story"].transform.localEulerAngles = arg_189_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1050ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1050ui_story == nil then
				arg_189_1.var_.characterEffect1050ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1050ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1050ui_story then
				arg_189_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_4 = 0
			local var_192_5 = 1.175

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(1105003047)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 47 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 47)

				if (47 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 47)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003047", "story_v_side_new_1105003.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003047", "story_v_side_new_1105003.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_side_new_1105003", "1105003047", "story_v_side_new_1105003.awb")

						arg_189_1:RecordAudio("1105003047", var_192_11)
						arg_189_1:RecordAudio("1105003047", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003047", "story_v_side_new_1105003.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003047", "story_v_side_new_1105003.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play1105003048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1105003048
		arg_193_1.duration_ = 12.83

		local var_193_0 = {
			zh = 12,
			ja = 12.833
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1105003049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.bgs_.K06f == nil then
				local var_196_0 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06f")
				var_196_0.name = "K06f"
				var_196_0.transform.parent = arg_193_1.stage_.transform
				var_196_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_.K06f = var_196_0
			end

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.K06f

				arg_193_1.bgs_.K06f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "K06f" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_5 = 2

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_5 then
				local var_196_6 = Color.New(0, 0, 0)

				var_196_6.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_4) / var_196_5)
				arg_193_1.mask_.color = var_196_6
			end

			if arg_193_1.time_ >= var_196_4 + var_196_5 and arg_193_1.time_ < var_196_4 + var_196_5 + arg_196_0 then
				local var_196_7 = Color.New(0, 0, 0)

				var_196_7.a = 1
				arg_193_1.mask_.color = var_196_7
			end

			local var_196_8 = 2

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 then
				local var_196_10 = Color.New(0, 0, 0)

				var_196_10.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_8) / var_196_9)
				arg_193_1.mask_.color = var_196_10
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 then
				local var_196_11 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_11.a = 0
				arg_193_1.mask_.color = var_196_11
			end

			local var_196_12 = "1055ui_story"

			if arg_193_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_196_13 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_193_1.stage_.transform)

				var_196_13.name = var_196_12
				var_196_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_[var_196_12] = var_196_13

				local var_196_14 = var_196_13:GetComponentInChildren(typeof(CharacterEffect))

				var_196_14.enabled = true

				local var_196_15 = GameObjectTools.GetOrAddComponent(var_196_13, typeof(DynamicBoneHelper))

				if var_196_15 then
					var_196_15:EnableDynamicBone(false)
				end

				arg_193_1:ShowWeapon(var_196_14.transform, false)

				arg_193_1.var_[var_196_12 .. "Animator"] = var_196_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_193_1.var_[var_196_12 .. "Animator"].applyRootMotion = true
				arg_193_1.var_[var_196_12 .. "LipSync"] = var_196_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_196_16 = arg_193_1.actors_["1055ui_story"].transform

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= 4 + arg_196_0 then
				arg_193_1.var_.moveOldPos1055ui_story = var_196_16.localPosition
			end

			local var_196_17 = 0.001

			if 4 <= arg_193_1.time_ and arg_193_1.time_ < 4 + var_196_17 then
				var_196_16.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_193_1.time_ - 4) / var_196_17)
				var_196_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_16.position).x, (manager.ui.mainCamera.transform.position - var_196_16.position).y, (manager.ui.mainCamera.transform.position - var_196_16.position).z)
				var_196_16.localEulerAngles.z = 0
				var_196_16.localEulerAngles.x = 0
				var_196_16.localEulerAngles = var_196_16.localEulerAngles
			end

			if arg_193_1.time_ >= 4 + var_196_17 and arg_193_1.time_ < 4 + var_196_17 + arg_196_0 then
				var_196_16.localPosition = Vector3.New(0, -0.965, -6.2)
				var_196_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_16.position).x, (manager.ui.mainCamera.transform.position - var_196_16.position).y, (manager.ui.mainCamera.transform.position - var_196_16.position).z)
				var_196_16.localEulerAngles.z = 0
				var_196_16.localEulerAngles.x = 0
				var_196_16.localEulerAngles = var_196_16.localEulerAngles
			end

			local var_196_18 = arg_193_1.actors_["1055ui_story"]

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= 4 + arg_196_0 and not isNil(var_196_18) and arg_193_1.var_.characterEffect1055ui_story == nil then
				arg_193_1.var_.characterEffect1055ui_story = var_196_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_19 = 0.200000002980232

			if 4 <= arg_193_1.time_ and arg_193_1.time_ < 4 + var_196_19 and not isNil(var_196_18) then
				if arg_193_1.var_.characterEffect1055ui_story and not isNil(var_196_18) then
					arg_193_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 4 + var_196_19 and arg_193_1.time_ < 4 + var_196_19 + arg_196_0 and not isNil(var_196_18) and arg_193_1.var_.characterEffect1055ui_story then
				arg_193_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= 4 + arg_196_0 then
				arg_193_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= 4 + arg_196_0 then
				arg_193_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_196_21 = arg_193_1.actors_["1050ui_story"].transform

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				arg_193_1.var_.moveOldPos1050ui_story = var_196_21.localPosition
			end

			local var_196_22 = 0.001

			if 2 <= arg_193_1.time_ and arg_193_1.time_ < 2 + var_196_22 then
				var_196_21.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 2) / var_196_22)
				var_196_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_21.position).x, (manager.ui.mainCamera.transform.position - var_196_21.position).y, (manager.ui.mainCamera.transform.position - var_196_21.position).z)
				var_196_21.localEulerAngles.z = 0
				var_196_21.localEulerAngles.x = 0
				var_196_21.localEulerAngles = var_196_21.localEulerAngles
			end

			if arg_193_1.time_ >= 2 + var_196_22 and arg_193_1.time_ < 2 + var_196_22 + arg_196_0 then
				var_196_21.localPosition = Vector3.New(0, 100, 0)
				var_196_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_21.position).x, (manager.ui.mainCamera.transform.position - var_196_21.position).y, (manager.ui.mainCamera.transform.position - var_196_21.position).z)
				var_196_21.localEulerAngles.z = 0
				var_196_21.localEulerAngles.x = 0
				var_196_21.localEulerAngles = var_196_21.localEulerAngles
			end

			local var_196_23 = 4

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_23 + 2 and arg_193_1.time_ < var_196_23 + 2 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("stop", "effect", "minigame_activity_2_0", "minigame_activity_2_0_chess_main_loop", "")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_196_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_27 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_27

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_27
						arg_193_1.bgmTxt2_.text = var_196_27
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_193_1.time_ and arg_193_1.time_ <= 0.266666666666667 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_196_30 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_30 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_30

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_30
						arg_193_1.bgmTxt2_.text = var_196_30
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_31 = 4
			local var_196_32 = 0.775

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_31 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_33 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_33:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_193_1.dialogCg_.alpha = arg_199_0
				end))
				var_196_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_34 = arg_193_1:GetWordFromCfg(1105003048)
				local var_196_35 = arg_193_1:FormatText(var_196_34.content)

				arg_193_1.text_.text = var_196_35

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_37 = 31 <= 0 and var_196_32 or var_196_32 * (utf8.len(var_196_35) / 31)

				if (31 <= 0 and var_196_32 or var_196_32 * (utf8.len(var_196_35) / 31)) > 0 and var_196_32 < var_196_37 then
					arg_193_1.talkMaxDuration = var_196_37
					var_196_31 = var_196_31 + 0.3

					if var_196_37 + var_196_31 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_37 + var_196_31
					end
				end

				arg_193_1.text_.text = var_196_35
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003048", "story_v_side_new_1105003.awb") ~= 0 then
					local var_196_38 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003048", "story_v_side_new_1105003.awb") / 1000

					if var_196_38 + var_196_31 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_38 + var_196_31
					end

					if var_196_34.prefab_name ~= "" and arg_193_1.actors_[var_196_34.prefab_name] ~= nil then
						local var_196_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_34.prefab_name].transform, "story_v_side_new_1105003", "1105003048", "story_v_side_new_1105003.awb")

						arg_193_1:RecordAudio("1105003048", var_196_39)
						arg_193_1:RecordAudio("1105003048", var_196_39)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003048", "story_v_side_new_1105003.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003048", "story_v_side_new_1105003.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_40 = var_196_31 + 0.3
			local var_196_41 = math.max(var_196_32, arg_193_1.talkMaxDuration)

			if var_196_31 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_40 + var_196_41 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_40) / var_196_41

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_40 + var_196_41 and arg_193_1.time_ < var_196_40 + var_196_41 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play1105003049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1105003049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1105003050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1055ui_story"]) and arg_201_1.var_.characterEffect1055ui_story == nil then
				arg_201_1.var_.characterEffect1055ui_story = arg_201_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1055ui_story"]) then
				if arg_201_1.var_.characterEffect1055ui_story and not isNil(arg_201_1.actors_["1055ui_story"]) then
					arg_201_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1055ui_story"]) and arg_201_1.var_.characterEffect1055ui_story then
				arg_201_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.35

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1105003049).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 14 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 14)

				if (14 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 14)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1105003050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1105003050
		arg_205_1.duration_ = 9.73

		local var_205_0 = {
			zh = 9.733,
			ja = 2.166
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1105003051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1055ui_story = arg_205_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1055ui_story"].transform.position).z)
				arg_205_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1055ui_story"].transform.localEulerAngles = arg_205_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_205_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1055ui_story"].transform.position).z)
				arg_205_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1055ui_story"].transform.localEulerAngles = arg_205_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1055ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1055ui_story == nil then
				arg_205_1.var_.characterEffect1055ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1055ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1055ui_story then
				arg_205_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_208_4 = 0
			local var_208_5 = 1.025

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(1105003050)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 41 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 41)

				if (41 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 41)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003050", "story_v_side_new_1105003.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003050", "story_v_side_new_1105003.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_side_new_1105003", "1105003050", "story_v_side_new_1105003.awb")

						arg_205_1:RecordAudio("1105003050", var_208_11)
						arg_205_1:RecordAudio("1105003050", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003050", "story_v_side_new_1105003.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003050", "story_v_side_new_1105003.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1105003051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1105003051
		arg_209_1.duration_ = 2.37

		local var_209_0 = {
			zh = 2.366,
			ja = 1.999999999999
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1105003052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1055ui_story = arg_209_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1055ui_story"].transform.position).z)
				arg_209_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1055ui_story"].transform.localEulerAngles = arg_209_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_209_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1055ui_story"].transform.position).z)
				arg_209_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1055ui_story"].transform.localEulerAngles = arg_209_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_1 = 0
			local var_212_2 = 0.125

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(1105003051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 5 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 5)

				if (5 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 5)) > 0 and var_212_2 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003051", "story_v_side_new_1105003.awb") ~= 0 then
					local var_212_7 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003051", "story_v_side_new_1105003.awb") / 1000

					if var_212_7 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_1
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_side_new_1105003", "1105003051", "story_v_side_new_1105003.awb")

						arg_209_1:RecordAudio("1105003051", var_212_8)
						arg_209_1:RecordAudio("1105003051", var_212_8)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003051", "story_v_side_new_1105003.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003051", "story_v_side_new_1105003.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_9 and arg_209_1.time_ < var_212_1 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1105003052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1105003052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1105003053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1055ui_story"]) and arg_213_1.var_.characterEffect1055ui_story == nil then
				arg_213_1.var_.characterEffect1055ui_story = arg_213_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1055ui_story"]) then
				if arg_213_1.var_.characterEffect1055ui_story and not isNil(arg_213_1.actors_["1055ui_story"]) then
					arg_213_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1055ui_story"]) and arg_213_1.var_.characterEffect1055ui_story then
				arg_213_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.925

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(1105003052).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 37 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 37)

				if (37 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 37)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1105003053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1105003053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1105003054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.675

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1105003053).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 27 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 27)

				if (27 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 27)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1105003054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1105003054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1105003055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.8

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1105003054).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 32 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 32)

				if (32 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 32)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1105003055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1105003055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1105003056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.6

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1105003055).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 24 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 24)

				if (24 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 24)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1105003056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1105003056
		arg_229_1.duration_ = 12.2

		local var_229_0 = {
			zh = 10.666,
			ja = 12.2
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1105003057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1055ui_story = arg_229_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1055ui_story"].transform.position).z)
				arg_229_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1055ui_story"].transform.localEulerAngles = arg_229_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_229_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1055ui_story"].transform.position).z)
				arg_229_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1055ui_story"].transform.localEulerAngles = arg_229_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1055ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1055ui_story == nil then
				arg_229_1.var_.characterEffect1055ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1055ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1055ui_story then
				arg_229_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_232_4 = 0
			local var_232_5 = 1.2

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(1105003056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 48 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 48)

				if (48 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 48)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003056", "story_v_side_new_1105003.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003056", "story_v_side_new_1105003.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_side_new_1105003", "1105003056", "story_v_side_new_1105003.awb")

						arg_229_1:RecordAudio("1105003056", var_232_11)
						arg_229_1:RecordAudio("1105003056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003056", "story_v_side_new_1105003.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003056", "story_v_side_new_1105003.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1105003057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1105003057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1105003058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1055ui_story"]) and arg_233_1.var_.characterEffect1055ui_story == nil then
				arg_233_1.var_.characterEffect1055ui_story = arg_233_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1055ui_story"]) then
				if arg_233_1.var_.characterEffect1055ui_story and not isNil(arg_233_1.actors_["1055ui_story"]) then
					arg_233_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1055ui_story"]) and arg_233_1.var_.characterEffect1055ui_story then
				arg_233_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.175

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1105003057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 7 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 7)

				if (7 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 7)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1105003058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1105003058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1105003059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.375

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1105003058).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 15 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 15)

				if (15 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 15)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1105003059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1105003059
		arg_241_1.duration_ = 4.17

		local var_241_0 = {
			zh = 4.166,
			ja = 3.733
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1105003060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1055ui_story = arg_241_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).z)
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles = arg_241_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_241_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).z)
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles = arg_241_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1055ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1055ui_story == nil then
				arg_241_1.var_.characterEffect1055ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1055ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1055ui_story then
				arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.35

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(1105003059)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 14 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 14)

				if (14 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 14)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003059", "story_v_side_new_1105003.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003059", "story_v_side_new_1105003.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_side_new_1105003", "1105003059", "story_v_side_new_1105003.awb")

						arg_241_1:RecordAudio("1105003059", var_244_11)
						arg_241_1:RecordAudio("1105003059", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003059", "story_v_side_new_1105003.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003059", "story_v_side_new_1105003.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1105003060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1105003060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1105003061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) and arg_245_1.var_.characterEffect1055ui_story == nil then
				arg_245_1.var_.characterEffect1055ui_story = arg_245_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) then
				if arg_245_1.var_.characterEffect1055ui_story and not isNil(arg_245_1.actors_["1055ui_story"]) then
					arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) and arg_245_1.var_.characterEffect1055ui_story then
				arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.725

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1105003060).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 29 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 29)

				if (29 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 29)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1105003061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1105003061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1105003062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.45

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1105003061).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 18 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 18)

				if (18 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 18)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1105003062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1105003062
		arg_253_1.duration_ = 12.8

		local var_253_0 = {
			zh = 4.333,
			ja = 12.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1105003063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1055ui_story = arg_253_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1055ui_story"].transform.position).z)
				arg_253_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1055ui_story"].transform.localEulerAngles = arg_253_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_253_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1055ui_story"].transform.position).z)
				arg_253_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1055ui_story"].transform.localEulerAngles = arg_253_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1055ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1055ui_story == nil then
				arg_253_1.var_.characterEffect1055ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1055ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1055ui_story then
				arg_253_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(1105003062)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 21 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 21)

				if (21 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 21)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003062", "story_v_side_new_1105003.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003062", "story_v_side_new_1105003.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_side_new_1105003", "1105003062", "story_v_side_new_1105003.awb")

						arg_253_1:RecordAudio("1105003062", var_256_11)
						arg_253_1:RecordAudio("1105003062", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003062", "story_v_side_new_1105003.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003062", "story_v_side_new_1105003.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1105003063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1105003063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1105003064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1055ui_story"]) and arg_257_1.var_.characterEffect1055ui_story == nil then
				arg_257_1.var_.characterEffect1055ui_story = arg_257_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1055ui_story"]) then
				if arg_257_1.var_.characterEffect1055ui_story and not isNil(arg_257_1.actors_["1055ui_story"]) then
					arg_257_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1055ui_story"]) and arg_257_1.var_.characterEffect1055ui_story then
				arg_257_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_260_1 = 0
			local var_260_2 = 0.75

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1105003063).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 30 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 30)

				if (30 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 30)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1105003064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1105003064
		arg_261_1.duration_ = 6.57

		local var_261_0 = {
			zh = 6.566,
			ja = 5.033
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1105003065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1050ui_story = arg_261_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1050ui_story"].transform.position).z)
				arg_261_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1050ui_story"].transform.localEulerAngles = arg_261_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_261_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1050ui_story"].transform.position).z)
				arg_261_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1050ui_story"].transform.localEulerAngles = arg_261_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1050ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1050ui_story == nil then
				arg_261_1.var_.characterEffect1050ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1050ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1050ui_story then
				arg_261_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_264_4 = arg_261_1.actors_["1055ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1055ui_story = var_264_4.localPosition
			end

			local var_264_5 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_5 then
				var_264_4.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_5)
				var_264_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_4.position).x, (manager.ui.mainCamera.transform.position - var_264_4.position).y, (manager.ui.mainCamera.transform.position - var_264_4.position).z)
				var_264_4.localEulerAngles.z = 0
				var_264_4.localEulerAngles.x = 0
				var_264_4.localEulerAngles = var_264_4.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_5 and arg_261_1.time_ < 0 + var_264_5 + arg_264_0 then
				var_264_4.localPosition = Vector3.New(0, 100, 0)
				var_264_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_4.position).x, (manager.ui.mainCamera.transform.position - var_264_4.position).y, (manager.ui.mainCamera.transform.position - var_264_4.position).z)
				var_264_4.localEulerAngles.z = 0
				var_264_4.localEulerAngles.x = 0
				var_264_4.localEulerAngles = var_264_4.localEulerAngles
			end

			local var_264_6 = 0
			local var_264_7 = 1.05

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(1105003064)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 42 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 42)

				if (42 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 42)) > 0 and var_264_7 < var_264_11 then
					arg_261_1.talkMaxDuration = var_264_11

					if var_264_11 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003064", "story_v_side_new_1105003.awb") ~= 0 then
					local var_264_12 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003064", "story_v_side_new_1105003.awb") / 1000

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end

					if var_264_8.prefab_name ~= "" and arg_261_1.actors_[var_264_8.prefab_name] ~= nil then
						local var_264_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_8.prefab_name].transform, "story_v_side_new_1105003", "1105003064", "story_v_side_new_1105003.awb")

						arg_261_1:RecordAudio("1105003064", var_264_13)
						arg_261_1:RecordAudio("1105003064", var_264_13)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003064", "story_v_side_new_1105003.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003064", "story_v_side_new_1105003.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_14 and arg_261_1.time_ < var_264_6 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1105003065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1105003065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1105003066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1050ui_story"]) and arg_265_1.var_.characterEffect1050ui_story == nil then
				arg_265_1.var_.characterEffect1050ui_story = arg_265_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1050ui_story"]) then
				if arg_265_1.var_.characterEffect1050ui_story and not isNil(arg_265_1.actors_["1050ui_story"]) then
					arg_265_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1050ui_story"]) and arg_265_1.var_.characterEffect1050ui_story then
				arg_265_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 0.525

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1105003065).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 21 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 21)

				if (21 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 21)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1105003066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1105003066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1105003067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.625

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1105003066).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 25)

				if (25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 25)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1105003067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1105003067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1105003068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.375

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1105003067).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 15 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 15)

				if (15 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 15)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1105003068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1105003068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1105003069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.075

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1105003068).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 43 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 43)

				if (43 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 43)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1105003069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1105003069
		arg_281_1.duration_ = 6

		local var_281_0 = {
			zh = 3.9,
			ja = 6
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1105003070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1050ui_story = arg_281_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1050ui_story"].transform.position).z)
				arg_281_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1050ui_story"].transform.localEulerAngles = arg_281_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_281_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1050ui_story"].transform.position).z)
				arg_281_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1050ui_story"].transform.localEulerAngles = arg_281_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1050ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1050ui_story == nil then
				arg_281_1.var_.characterEffect1050ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1050ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1050ui_story then
				arg_281_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_4 = 0
			local var_284_5 = 0.7

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(1105003069)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 28 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 28)

				if (28 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 28)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003069", "story_v_side_new_1105003.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003069", "story_v_side_new_1105003.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_side_new_1105003", "1105003069", "story_v_side_new_1105003.awb")

						arg_281_1:RecordAudio("1105003069", var_284_11)
						arg_281_1:RecordAudio("1105003069", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003069", "story_v_side_new_1105003.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003069", "story_v_side_new_1105003.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1105003070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1105003070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1105003071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1050ui_story"]) and arg_285_1.var_.characterEffect1050ui_story == nil then
				arg_285_1.var_.characterEffect1050ui_story = arg_285_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1050ui_story"]) then
				if arg_285_1.var_.characterEffect1050ui_story and not isNil(arg_285_1.actors_["1050ui_story"]) then
					arg_285_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1050ui_story"]) and arg_285_1.var_.characterEffect1050ui_story then
				arg_285_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 1.075

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1105003070).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 43 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 43)

				if (43 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 43)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1105003071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1105003071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1105003072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.325

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1105003071).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 13 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 13)

				if (13 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 13)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1105003072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1105003072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1105003073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.575

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1105003072).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 23 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 23)

				if (23 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 23)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1105003073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1105003073
		arg_297_1.duration_ = 3.63

		local var_297_0 = {
			zh = 1.333,
			ja = 3.633
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1105003074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1050ui_story"]) and arg_297_1.var_.characterEffect1050ui_story == nil then
				arg_297_1.var_.characterEffect1050ui_story = arg_297_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1050ui_story"]) then
				if arg_297_1.var_.characterEffect1050ui_story and not isNil(arg_297_1.actors_["1050ui_story"]) then
					arg_297_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1050ui_story"]) and arg_297_1.var_.characterEffect1050ui_story then
				arg_297_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_300_2 = 0
			local var_300_3 = 0.1

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(1105003073)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 4 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 4)

				if (4 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 4)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003073", "story_v_side_new_1105003.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003073", "story_v_side_new_1105003.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_side_new_1105003", "1105003073", "story_v_side_new_1105003.awb")

						arg_297_1:RecordAudio("1105003073", var_300_9)
						arg_297_1:RecordAudio("1105003073", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003073", "story_v_side_new_1105003.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003073", "story_v_side_new_1105003.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1105003074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1105003074
		arg_301_1.duration_ = 9

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1105003075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if arg_301_1.bgs_.ST59 == nil then
				local var_304_0 = Object.Instantiate(arg_301_1.paintGo_)

				var_304_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST59")
				var_304_0.name = "ST59"
				var_304_0.transform.parent = arg_301_1.stage_.transform
				var_304_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.bgs_.ST59 = var_304_0
			end

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= 2 + arg_304_0 then
				local var_304_1 = arg_301_1.bgs_.ST59

				arg_301_1.bgs_.ST59.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_304_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_2 = var_304_1:GetComponent("SpriteRenderer")

				if var_304_2 and var_304_2.sprite then
					local var_304_3 = 2 * (var_304_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_304_1.transform.localScale = Vector3.New(var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "ST59" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_4 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_5 = 2

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_5 then
				local var_304_6 = Color.New(0, 0, 0)

				var_304_6.a = Mathf.Lerp(0, 1, (arg_301_1.time_ - var_304_4) / var_304_5)
				arg_301_1.mask_.color = var_304_6
			end

			if arg_301_1.time_ >= var_304_4 + var_304_5 and arg_301_1.time_ < var_304_4 + var_304_5 + arg_304_0 then
				local var_304_7 = Color.New(0, 0, 0)

				var_304_7.a = 1
				arg_301_1.mask_.color = var_304_7
			end

			local var_304_8 = 2

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_9 = 2

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 then
				local var_304_10 = Color.New(0, 0, 0)

				var_304_10.a = Mathf.Lerp(1, 0, (arg_301_1.time_ - var_304_8) / var_304_9)
				arg_301_1.mask_.color = var_304_10
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 then
				local var_304_11 = Color.New(0, 0, 0)

				arg_301_1.mask_.enabled = false
				var_304_11.a = 0
				arg_301_1.mask_.color = var_304_11
			end

			local var_304_12 = arg_301_1.actors_["1050ui_story"].transform

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= 2 + arg_304_0 then
				arg_301_1.var_.moveOldPos1050ui_story = var_304_12.localPosition
			end

			local var_304_13 = 0.001

			if 2 <= arg_301_1.time_ and arg_301_1.time_ < 2 + var_304_13 then
				var_304_12.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 2) / var_304_13)
				var_304_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_12.position).x, (manager.ui.mainCamera.transform.position - var_304_12.position).y, (manager.ui.mainCamera.transform.position - var_304_12.position).z)
				var_304_12.localEulerAngles.z = 0
				var_304_12.localEulerAngles.x = 0
				var_304_12.localEulerAngles = var_304_12.localEulerAngles
			end

			if arg_301_1.time_ >= 2 + var_304_13 and arg_301_1.time_ < 2 + var_304_13 + arg_304_0 then
				var_304_12.localPosition = Vector3.New(0, 100, 0)
				var_304_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_12.position).x, (manager.ui.mainCamera.transform.position - var_304_12.position).y, (manager.ui.mainCamera.transform.position - var_304_12.position).z)
				var_304_12.localEulerAngles.z = 0
				var_304_12.localEulerAngles.x = 0
				var_304_12.localEulerAngles = var_304_12.localEulerAngles
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_14 = 4
			local var_304_15 = 0.825

			if 4 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_16 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_16:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_17 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1105003074).content)

				arg_301_1.text_.text = var_304_17

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_19 = 33 <= 0 and var_304_15 or var_304_15 * (utf8.len(var_304_17) / 33)

				if (33 <= 0 and var_304_15 or var_304_15 * (utf8.len(var_304_17) / 33)) > 0 and var_304_15 < var_304_19 then
					arg_301_1.talkMaxDuration = var_304_19
					var_304_14 = var_304_14 + 0.3

					if var_304_19 + var_304_14 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_14
					end
				end

				arg_301_1.text_.text = var_304_17
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_20 = var_304_14 + 0.3
			local var_304_21 = math.max(var_304_15, arg_301_1.talkMaxDuration)

			if var_304_14 + 0.3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_20 + var_304_21 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_20) / var_304_21

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_20 + var_304_21 and arg_301_1.time_ < var_304_20 + var_304_21 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play1105003075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1105003075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1105003076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.325

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1105003075).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 13 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 13)

				if (13 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 13)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1105003076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1105003076
		arg_311_1.duration_ = 4.7

		local var_311_0 = {
			zh = 3.733,
			ja = 4.7
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1105003077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1055ui_story = arg_311_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1055ui_story"].transform.position).z)
				arg_311_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1055ui_story"].transform.localEulerAngles = arg_311_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_311_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1055ui_story"].transform.position).z)
				arg_311_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1055ui_story"].transform.localEulerAngles = arg_311_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1055ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1055ui_story == nil then
				arg_311_1.var_.characterEffect1055ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1055ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1055ui_story then
				arg_311_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				if arg_311_1.var_.characterEffect1055ui_story == nil then
					arg_311_1.var_.characterEffect1055ui_story = arg_311_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_311_1.var_.characterEffect1055ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				if arg_311_1.var_.characterEffect1055ui_story == nil then
					arg_311_1.var_.characterEffect1055ui_story = arg_311_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_314_5 = arg_311_1.var_.characterEffect1055ui_story

				arg_311_1.var_.characterEffect1055ui_story.imageEffect:turnOff()

				var_314_5.interferenceEffect.enabled = true
				var_314_5.interferenceEffect.noise = 0.001
				var_314_5.interferenceEffect.simTimeScale = 1
				var_314_5.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_314_6 = 0
			local var_314_7 = 0.5

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_8 = arg_311_1:GetWordFromCfg(1105003076)
				local var_314_9 = arg_311_1:FormatText(var_314_8.content)

				arg_311_1.text_.text = var_314_9

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 20 <= 0 and var_314_7 or var_314_7 * (utf8.len(var_314_9) / 20)

				if (20 <= 0 and var_314_7 or var_314_7 * (utf8.len(var_314_9) / 20)) > 0 and var_314_7 < var_314_11 then
					arg_311_1.talkMaxDuration = var_314_11

					if var_314_11 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_9
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003076", "story_v_side_new_1105003.awb") ~= 0 then
					local var_314_12 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003076", "story_v_side_new_1105003.awb") / 1000

					if var_314_12 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_12 + var_314_6
					end

					if var_314_8.prefab_name ~= "" and arg_311_1.actors_[var_314_8.prefab_name] ~= nil then
						local var_314_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_8.prefab_name].transform, "story_v_side_new_1105003", "1105003076", "story_v_side_new_1105003.awb")

						arg_311_1:RecordAudio("1105003076", var_314_13)
						arg_311_1:RecordAudio("1105003076", var_314_13)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003076", "story_v_side_new_1105003.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003076", "story_v_side_new_1105003.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_14 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_14 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_14

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_14 and arg_311_1.time_ < var_314_6 + var_314_14 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play1105003077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1105003077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1105003078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1055ui_story"]) and arg_315_1.var_.characterEffect1055ui_story == nil then
				arg_315_1.var_.characterEffect1055ui_story = arg_315_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1055ui_story"]) then
				if arg_315_1.var_.characterEffect1055ui_story and not isNil(arg_315_1.actors_["1055ui_story"]) then
					arg_315_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1055ui_story"]) and arg_315_1.var_.characterEffect1055ui_story then
				arg_315_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.55

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1105003077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 22 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 22)

				if (22 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 22)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1105003078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1105003078
		arg_319_1.duration_ = 12.97

		local var_319_0 = {
			zh = 10.733,
			ja = 12.966
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1105003079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1055ui_story = arg_319_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1055ui_story"].transform.position).z)
				arg_319_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1055ui_story"].transform.localEulerAngles = arg_319_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_319_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1055ui_story"].transform.position).z)
				arg_319_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1055ui_story"].transform.localEulerAngles = arg_319_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1055ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1055ui_story == nil then
				arg_319_1.var_.characterEffect1055ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1055ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1055ui_story then
				arg_319_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_322_4 = 0
			local var_322_5 = 1.4

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(1105003078)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 56 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 56)

				if (56 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 56)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003078", "story_v_side_new_1105003.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003078", "story_v_side_new_1105003.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_side_new_1105003", "1105003078", "story_v_side_new_1105003.awb")

						arg_319_1:RecordAudio("1105003078", var_322_11)
						arg_319_1:RecordAudio("1105003078", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003078", "story_v_side_new_1105003.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003078", "story_v_side_new_1105003.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play1105003079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1105003079
		arg_323_1.duration_ = 15.97

		local var_323_0 = {
			zh = 10.733,
			ja = 15.966
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1105003080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 1.15

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:GetWordFromCfg(1105003079)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 46 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 46)

				if (46 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 46)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003079", "story_v_side_new_1105003.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003079", "story_v_side_new_1105003.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_side_new_1105003", "1105003079", "story_v_side_new_1105003.awb")

						arg_323_1:RecordAudio("1105003079", var_326_6)
						arg_323_1:RecordAudio("1105003079", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003079", "story_v_side_new_1105003.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003079", "story_v_side_new_1105003.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1105003080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1105003080
		arg_327_1.duration_ = 10.63

		local var_327_0 = {
			zh = 7.9,
			ja = 10.633
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1105003081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.8

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(1105003080)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 32 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 32)

				if (32 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 32)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003080", "story_v_side_new_1105003.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003080", "story_v_side_new_1105003.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_side_new_1105003", "1105003080", "story_v_side_new_1105003.awb")

						arg_327_1:RecordAudio("1105003080", var_330_6)
						arg_327_1:RecordAudio("1105003080", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003080", "story_v_side_new_1105003.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003080", "story_v_side_new_1105003.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1105003081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1105003081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1105003082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1055ui_story"]) and arg_331_1.var_.characterEffect1055ui_story == nil then
				arg_331_1.var_.characterEffect1055ui_story = arg_331_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1055ui_story"]) then
				if arg_331_1.var_.characterEffect1055ui_story and not isNil(arg_331_1.actors_["1055ui_story"]) then
					arg_331_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1055ui_story"]) and arg_331_1.var_.characterEffect1055ui_story then
				arg_331_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.575

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1105003081).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 23 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 23)

				if (23 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 23)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1105003082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1105003082
		arg_335_1.duration_ = 9.37

		local var_335_0 = {
			zh = 4.1,
			ja = 9.366
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1105003083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1055ui_story = arg_335_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1055ui_story"].transform.position).z)
				arg_335_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1055ui_story"].transform.localEulerAngles = arg_335_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_335_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1055ui_story"].transform.position).z)
				arg_335_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1055ui_story"].transform.localEulerAngles = arg_335_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1055ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1055ui_story == nil then
				arg_335_1.var_.characterEffect1055ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1055ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1055ui_story then
				arg_335_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_338_4 = 0
			local var_338_5 = 0.475

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_6 = arg_335_1:GetWordFromCfg(1105003082)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 19 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 19)

				if (19 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 19)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003082", "story_v_side_new_1105003.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003082", "story_v_side_new_1105003.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_side_new_1105003", "1105003082", "story_v_side_new_1105003.awb")

						arg_335_1:RecordAudio("1105003082", var_338_11)
						arg_335_1:RecordAudio("1105003082", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003082", "story_v_side_new_1105003.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003082", "story_v_side_new_1105003.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play1105003083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1105003083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1105003084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1055ui_story"]) and arg_339_1.var_.characterEffect1055ui_story == nil then
				arg_339_1.var_.characterEffect1055ui_story = arg_339_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1055ui_story"]) then
				if arg_339_1.var_.characterEffect1055ui_story and not isNil(arg_339_1.actors_["1055ui_story"]) then
					arg_339_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1055ui_story"]) and arg_339_1.var_.characterEffect1055ui_story then
				arg_339_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.475

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1105003083).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 19 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 19)

				if (19 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 19)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1105003084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1105003084
		arg_343_1.duration_ = 14.8

		local var_343_0 = {
			zh = 11.9,
			ja = 14.8
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1105003085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1055ui_story = arg_343_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1055ui_story"].transform.position).z)
				arg_343_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1055ui_story"].transform.localEulerAngles = arg_343_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_343_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1055ui_story"].transform.position).z)
				arg_343_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1055ui_story"].transform.localEulerAngles = arg_343_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["1055ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1055ui_story == nil then
				arg_343_1.var_.characterEffect1055ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect1055ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1055ui_story then
				arg_343_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_346_4 = 0
			local var_346_5 = 1.1

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:GetWordFromCfg(1105003084)
				local var_346_7 = arg_343_1:FormatText(var_346_6.content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 44 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 44)

				if (44 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 44)) > 0 and var_346_5 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003084", "story_v_side_new_1105003.awb") ~= 0 then
					local var_346_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003084", "story_v_side_new_1105003.awb") / 1000

					if var_346_10 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_4
					end

					if var_346_6.prefab_name ~= "" and arg_343_1.actors_[var_346_6.prefab_name] ~= nil then
						local var_346_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_6.prefab_name].transform, "story_v_side_new_1105003", "1105003084", "story_v_side_new_1105003.awb")

						arg_343_1:RecordAudio("1105003084", var_346_11)
						arg_343_1:RecordAudio("1105003084", var_346_11)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003084", "story_v_side_new_1105003.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003084", "story_v_side_new_1105003.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_12 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_12 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_12

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_12 and arg_343_1.time_ < var_346_4 + var_346_12 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play1105003085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1105003085
		arg_347_1.duration_ = 8.1

		local var_347_0 = {
			zh = 8.1,
			ja = 6
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1105003086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.875

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(1105003085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 35 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 35)

				if (35 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 35)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003085", "story_v_side_new_1105003.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003085", "story_v_side_new_1105003.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_side_new_1105003", "1105003085", "story_v_side_new_1105003.awb")

						arg_347_1:RecordAudio("1105003085", var_350_6)
						arg_347_1:RecordAudio("1105003085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003085", "story_v_side_new_1105003.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003085", "story_v_side_new_1105003.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1105003086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1105003086
		arg_351_1.duration_ = 8.97

		local var_351_0 = {
			zh = 8.966,
			ja = 4.033
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1105003087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_2")
			end

			local var_354_0 = 0
			local var_354_1 = 0.95

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(1105003086)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 38 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_3) / 38)

				if (38 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_3) / 38)) > 0 and var_354_1 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003086", "story_v_side_new_1105003.awb") ~= 0 then
					local var_354_6 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003086", "story_v_side_new_1105003.awb") / 1000

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end

					if var_354_2.prefab_name ~= "" and arg_351_1.actors_[var_354_2.prefab_name] ~= nil then
						local var_354_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_2.prefab_name].transform, "story_v_side_new_1105003", "1105003086", "story_v_side_new_1105003.awb")

						arg_351_1:RecordAudio("1105003086", var_354_7)
						arg_351_1:RecordAudio("1105003086", var_354_7)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003086", "story_v_side_new_1105003.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003086", "story_v_side_new_1105003.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_8 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_8 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_8

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_8 and arg_351_1.time_ < var_354_0 + var_354_8 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1105003087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1105003087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1105003088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1055ui_story"]) and arg_355_1.var_.characterEffect1055ui_story == nil then
				arg_355_1.var_.characterEffect1055ui_story = arg_355_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1055ui_story"]) then
				if arg_355_1.var_.characterEffect1055ui_story and not isNil(arg_355_1.actors_["1055ui_story"]) then
					arg_355_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1055ui_story"]) and arg_355_1.var_.characterEffect1055ui_story then
				arg_355_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.2

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1105003087).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 8 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 8)

				if (8 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 8)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1105003088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1105003088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1105003089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				if arg_359_1.var_.characterEffect1055ui_story == nil then
					arg_359_1.var_.characterEffect1055ui_story = arg_359_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_362_0 = arg_359_1.var_.characterEffect1055ui_story

				arg_359_1.var_.characterEffect1055ui_story.imageEffect:turnOff()

				var_362_0.interferenceEffect.enabled = false
				var_362_0.interferenceEffect.noise = 0.001
				var_362_0.interferenceEffect.simTimeScale = 1
				var_362_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_362_1 = arg_359_1.actors_["1055ui_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1055ui_story = var_362_1.localPosition
			end

			local var_362_2 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 then
				var_362_1.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_2)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 then
				var_362_1.localPosition = Vector3.New(0, 100, 0)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			local var_362_3 = 0
			local var_362_4 = 1.125

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_3 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_5 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1105003088).content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 45 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 45)

				if (45 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 45)) > 0 and var_362_4 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_3 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_3
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_4, arg_359_1.talkMaxDuration)

			if var_362_3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_3 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_3) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_3 + var_362_8 and arg_359_1.time_ < var_362_3 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play1105003089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1105003089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1105003090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.25

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1105003089).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 50 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 50)

				if (50 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 50)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1105003090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1105003090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1105003091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.1

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1105003090).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 4 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 4)

				if (4 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 4)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1105003091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1105003091
		arg_371_1.duration_ = 12.13

		local var_371_0 = {
			zh = 9.1,
			ja = 12.133
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1105003092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1050ui_story = arg_371_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1050ui_story"].transform.position).z)
				arg_371_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1050ui_story"].transform.localEulerAngles = arg_371_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_371_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1050ui_story"].transform.position).z)
				arg_371_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1050ui_story"].transform.localEulerAngles = arg_371_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1050ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1050ui_story == nil then
				arg_371_1.var_.characterEffect1050ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1050ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1050ui_story then
				arg_371_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_374_4 = 0
			local var_374_5 = 1.05

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(1105003091)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 42 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 42)

				if (42 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 42)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003091", "story_v_side_new_1105003.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003091", "story_v_side_new_1105003.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_side_new_1105003", "1105003091", "story_v_side_new_1105003.awb")

						arg_371_1:RecordAudio("1105003091", var_374_11)
						arg_371_1:RecordAudio("1105003091", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003091", "story_v_side_new_1105003.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003091", "story_v_side_new_1105003.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play1105003092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1105003092
		arg_375_1.duration_ = 8.07

		local var_375_0 = {
			zh = 7.266,
			ja = 8.066
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1105003093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.825

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:GetWordFromCfg(1105003092)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 33 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 33)

				if (33 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 33)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003092", "story_v_side_new_1105003.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003092", "story_v_side_new_1105003.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_side_new_1105003", "1105003092", "story_v_side_new_1105003.awb")

						arg_375_1:RecordAudio("1105003092", var_378_6)
						arg_375_1:RecordAudio("1105003092", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003092", "story_v_side_new_1105003.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003092", "story_v_side_new_1105003.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1105003093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1105003093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1105003094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1050ui_story"]) and arg_379_1.var_.characterEffect1050ui_story == nil then
				arg_379_1.var_.characterEffect1050ui_story = arg_379_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1050ui_story"]) then
				if arg_379_1.var_.characterEffect1050ui_story and not isNil(arg_379_1.actors_["1050ui_story"]) then
					arg_379_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1050ui_story"]) and arg_379_1.var_.characterEffect1050ui_story then
				arg_379_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.225

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1105003093).content)

				arg_379_1.text_.text = var_382_3

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 9 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 9)

				if (9 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 9)) > 0 and var_382_2 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_3
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_6 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_6 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_6

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_6 and arg_379_1.time_ < var_382_1 + var_382_6 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1105003094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1105003094
		arg_383_1.duration_ = 3.67

		local var_383_0 = {
			zh = 3.666,
			ja = 3.333
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1105003095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1050ui_story = arg_383_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1050ui_story"].transform.position).z)
				arg_383_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1050ui_story"].transform.localEulerAngles = arg_383_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_383_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1050ui_story"].transform.position).z)
				arg_383_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1050ui_story"].transform.localEulerAngles = arg_383_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1050ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1050ui_story == nil then
				arg_383_1.var_.characterEffect1050ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1050ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1050ui_story then
				arg_383_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_386_4 = 0
			local var_386_5 = 0.45

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_6 = arg_383_1:GetWordFromCfg(1105003094)
				local var_386_7 = arg_383_1:FormatText(var_386_6.content)

				arg_383_1.text_.text = var_386_7

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 18 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 18)

				if (18 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 18)) > 0 and var_386_5 < var_386_9 then
					arg_383_1.talkMaxDuration = var_386_9

					if var_386_9 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_9 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_7
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003094", "story_v_side_new_1105003.awb") ~= 0 then
					local var_386_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003094", "story_v_side_new_1105003.awb") / 1000

					if var_386_10 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_4
					end

					if var_386_6.prefab_name ~= "" and arg_383_1.actors_[var_386_6.prefab_name] ~= nil then
						local var_386_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_6.prefab_name].transform, "story_v_side_new_1105003", "1105003094", "story_v_side_new_1105003.awb")

						arg_383_1:RecordAudio("1105003094", var_386_11)
						arg_383_1:RecordAudio("1105003094", var_386_11)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003094", "story_v_side_new_1105003.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003094", "story_v_side_new_1105003.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_12 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_12 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_12

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_12 and arg_383_1.time_ < var_386_4 + var_386_12 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play1105003095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1105003095
		arg_387_1.duration_ = 11.9

		local var_387_0 = {
			zh = 8.8,
			ja = 11.9
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1105003096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.375

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:GetWordFromCfg(1105003095)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 55 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 55)

				if (55 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 55)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003095", "story_v_side_new_1105003.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003095", "story_v_side_new_1105003.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_side_new_1105003", "1105003095", "story_v_side_new_1105003.awb")

						arg_387_1:RecordAudio("1105003095", var_390_6)
						arg_387_1:RecordAudio("1105003095", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003095", "story_v_side_new_1105003.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003095", "story_v_side_new_1105003.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1105003096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1105003096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1105003097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1050ui_story"]) and arg_391_1.var_.characterEffect1050ui_story == nil then
				arg_391_1.var_.characterEffect1050ui_story = arg_391_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1050ui_story"]) then
				if arg_391_1.var_.characterEffect1050ui_story and not isNil(arg_391_1.actors_["1050ui_story"]) then
					arg_391_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1050ui_story"]) and arg_391_1.var_.characterEffect1050ui_story then
				arg_391_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.675

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1105003096).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 27 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 27)

				if (27 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 27)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1105003097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1105003097
		arg_395_1.duration_ = 4.8

		local var_395_0 = {
			zh = 4.8,
			ja = 3.266
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1105003098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1050ui_story = arg_395_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1050ui_story"].transform.position).z)
				arg_395_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1050ui_story"].transform.localEulerAngles = arg_395_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_395_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1050ui_story"].transform.position).z)
				arg_395_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1050ui_story"].transform.localEulerAngles = arg_395_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1050ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1050ui_story == nil then
				arg_395_1.var_.characterEffect1050ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1050ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1050ui_story then
				arg_395_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.8

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(1105003097)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 32 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 32)

				if (32 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 32)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003097", "story_v_side_new_1105003.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003097", "story_v_side_new_1105003.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_side_new_1105003", "1105003097", "story_v_side_new_1105003.awb")

						arg_395_1:RecordAudio("1105003097", var_398_11)
						arg_395_1:RecordAudio("1105003097", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003097", "story_v_side_new_1105003.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003097", "story_v_side_new_1105003.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play1105003098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1105003098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1105003099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1050ui_story"]) and arg_399_1.var_.characterEffect1050ui_story == nil then
				arg_399_1.var_.characterEffect1050ui_story = arg_399_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1050ui_story"]) then
				if arg_399_1.var_.characterEffect1050ui_story and not isNil(arg_399_1.actors_["1050ui_story"]) then
					arg_399_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1050ui_story"]) and arg_399_1.var_.characterEffect1050ui_story then
				arg_399_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.175

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1105003098).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 7 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 7)

				if (7 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 7)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1105003099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1105003099
		arg_403_1.duration_ = 13.33

		local var_403_0 = {
			zh = 13.333,
			ja = 7.966
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1105003100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1050ui_story"]) and arg_403_1.var_.characterEffect1050ui_story == nil then
				arg_403_1.var_.characterEffect1050ui_story = arg_403_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1050ui_story"]) then
				if arg_403_1.var_.characterEffect1050ui_story and not isNil(arg_403_1.actors_["1050ui_story"]) then
					arg_403_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1050ui_story"]) and arg_403_1.var_.characterEffect1050ui_story then
				arg_403_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_406_2 = 0
			local var_406_3 = 1.55

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_4 = arg_403_1:GetWordFromCfg(1105003099)
				local var_406_5 = arg_403_1:FormatText(var_406_4.content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 62 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 62)

				if (62 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 62)) > 0 and var_406_3 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003099", "story_v_side_new_1105003.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003099", "story_v_side_new_1105003.awb") / 1000

					if var_406_8 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_2
					end

					if var_406_4.prefab_name ~= "" and arg_403_1.actors_[var_406_4.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_4.prefab_name].transform, "story_v_side_new_1105003", "1105003099", "story_v_side_new_1105003.awb")

						arg_403_1:RecordAudio("1105003099", var_406_9)
						arg_403_1:RecordAudio("1105003099", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003099", "story_v_side_new_1105003.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003099", "story_v_side_new_1105003.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_10 and arg_403_1.time_ < var_406_2 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1105003100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1105003100
		arg_407_1.duration_ = 4.27

		local var_407_0 = {
			zh = 2.7,
			ja = 4.266
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1105003101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.325

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:GetWordFromCfg(1105003100)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 13 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 13)

				if (13 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 13)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003100", "story_v_side_new_1105003.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003100", "story_v_side_new_1105003.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_side_new_1105003", "1105003100", "story_v_side_new_1105003.awb")

						arg_407_1:RecordAudio("1105003100", var_410_6)
						arg_407_1:RecordAudio("1105003100", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003100", "story_v_side_new_1105003.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003100", "story_v_side_new_1105003.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1105003101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1105003101
		arg_411_1.duration_ = 8.93

		local var_411_0 = {
			zh = 6.166,
			ja = 8.933
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1105003102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action454")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_0 = 0
			local var_414_1 = 0.8

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(1105003101)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 32 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 32)

				if (32 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 32)) > 0 and var_414_1 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003101", "story_v_side_new_1105003.awb") ~= 0 then
					local var_414_6 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003101", "story_v_side_new_1105003.awb") / 1000

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end

					if var_414_2.prefab_name ~= "" and arg_411_1.actors_[var_414_2.prefab_name] ~= nil then
						local var_414_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_2.prefab_name].transform, "story_v_side_new_1105003", "1105003101", "story_v_side_new_1105003.awb")

						arg_411_1:RecordAudio("1105003101", var_414_7)
						arg_411_1:RecordAudio("1105003101", var_414_7)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003101", "story_v_side_new_1105003.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003101", "story_v_side_new_1105003.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1105003102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1105003102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1105003103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1050ui_story"]) and arg_415_1.var_.characterEffect1050ui_story == nil then
				arg_415_1.var_.characterEffect1050ui_story = arg_415_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1050ui_story"]) then
				if arg_415_1.var_.characterEffect1050ui_story and not isNil(arg_415_1.actors_["1050ui_story"]) then
					arg_415_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1050ui_story"]) and arg_415_1.var_.characterEffect1050ui_story then
				arg_415_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 0.675

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1105003102).content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 27 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 27)

				if (27 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 27)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_6 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_6 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_6

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_6 and arg_415_1.time_ < var_418_1 + var_418_6 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1105003103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1105003103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1105003104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.425

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(1105003103).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 17 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 17)

				if (17 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 17)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1105003104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1105003104
		arg_423_1.duration_ = 3.2

		local var_423_0 = {
			zh = 3.2,
			ja = 2.966
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1105003105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1050ui_story = arg_423_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1050ui_story"].transform.position).z)
				arg_423_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1050ui_story"].transform.localEulerAngles = arg_423_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_423_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1050ui_story"].transform.position).z)
				arg_423_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1050ui_story"].transform.localEulerAngles = arg_423_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1050ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1050ui_story == nil then
				arg_423_1.var_.characterEffect1050ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1050ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1050ui_story then
				arg_423_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_426_4 = 0
			local var_426_5 = 0.6

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(1105003104)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 24 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 24)

				if (24 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 24)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003104", "story_v_side_new_1105003.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003104", "story_v_side_new_1105003.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_side_new_1105003", "1105003104", "story_v_side_new_1105003.awb")

						arg_423_1:RecordAudio("1105003104", var_426_11)
						arg_423_1:RecordAudio("1105003104", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003104", "story_v_side_new_1105003.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003104", "story_v_side_new_1105003.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1105003105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1105003105
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1105003106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1050ui_story"]) and arg_427_1.var_.characterEffect1050ui_story == nil then
				arg_427_1.var_.characterEffect1050ui_story = arg_427_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1050ui_story"]) then
				if arg_427_1.var_.characterEffect1050ui_story and not isNil(arg_427_1.actors_["1050ui_story"]) then
					arg_427_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1050ui_story"]) and arg_427_1.var_.characterEffect1050ui_story then
				arg_427_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_430_1 = 0
			local var_430_2 = 0.75

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1105003105).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 30 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 30)

				if (30 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 30)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1105003106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1105003106
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1105003107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.625

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1105003106).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 25 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 25)

				if (25 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 25)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1105003107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1105003107
		arg_435_1.duration_ = 8.3

		local var_435_0 = {
			zh = 5.5,
			ja = 8.3
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1105003108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1050ui_story = arg_435_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1050ui_story"].transform.position).z)
				arg_435_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1050ui_story"].transform.localEulerAngles = arg_435_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_435_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1050ui_story"].transform.position).z)
				arg_435_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1050ui_story"].transform.localEulerAngles = arg_435_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1050ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1050ui_story == nil then
				arg_435_1.var_.characterEffect1050ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1050ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1050ui_story then
				arg_435_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_1")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_438_4 = 0
			local var_438_5 = 0.825

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(1105003107)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 33 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 33)

				if (33 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 33)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003107", "story_v_side_new_1105003.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003107", "story_v_side_new_1105003.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_side_new_1105003", "1105003107", "story_v_side_new_1105003.awb")

						arg_435_1:RecordAudio("1105003107", var_438_11)
						arg_435_1:RecordAudio("1105003107", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003107", "story_v_side_new_1105003.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003107", "story_v_side_new_1105003.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play1105003108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1105003108
		arg_439_1.duration_ = 6.2

		local var_439_0 = {
			zh = 6.2,
			ja = 5.366
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1105003109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_442_0 = 0
			local var_442_1 = 1.075

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(1105003108)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 43 <= 0 and var_442_1 or var_442_1 * (utf8.len(var_442_3) / 43)

				if (43 <= 0 and var_442_1 or var_442_1 * (utf8.len(var_442_3) / 43)) > 0 and var_442_1 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003108", "story_v_side_new_1105003.awb") ~= 0 then
					local var_442_6 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003108", "story_v_side_new_1105003.awb") / 1000

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end

					if var_442_2.prefab_name ~= "" and arg_439_1.actors_[var_442_2.prefab_name] ~= nil then
						local var_442_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_2.prefab_name].transform, "story_v_side_new_1105003", "1105003108", "story_v_side_new_1105003.awb")

						arg_439_1:RecordAudio("1105003108", var_442_7)
						arg_439_1:RecordAudio("1105003108", var_442_7)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003108", "story_v_side_new_1105003.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003108", "story_v_side_new_1105003.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_8 and arg_439_1.time_ < var_442_0 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1105003109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1105003109
		arg_443_1.duration_ = 2.5

		local var_443_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1105003110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_0 = 0
			local var_446_1 = 0.4

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_2 = arg_443_1:GetWordFromCfg(1105003109)
				local var_446_3 = arg_443_1:FormatText(var_446_2.content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 16 <= 0 and var_446_1 or var_446_1 * (utf8.len(var_446_3) / 16)

				if (16 <= 0 and var_446_1 or var_446_1 * (utf8.len(var_446_3) / 16)) > 0 and var_446_1 < var_446_5 then
					arg_443_1.talkMaxDuration = var_446_5

					if var_446_5 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_3
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003109", "story_v_side_new_1105003.awb") ~= 0 then
					local var_446_6 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003109", "story_v_side_new_1105003.awb") / 1000

					if var_446_6 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_6 + var_446_0
					end

					if var_446_2.prefab_name ~= "" and arg_443_1.actors_[var_446_2.prefab_name] ~= nil then
						local var_446_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_2.prefab_name].transform, "story_v_side_new_1105003", "1105003109", "story_v_side_new_1105003.awb")

						arg_443_1:RecordAudio("1105003109", var_446_7)
						arg_443_1:RecordAudio("1105003109", var_446_7)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003109", "story_v_side_new_1105003.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003109", "story_v_side_new_1105003.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_8 and arg_443_1.time_ < var_446_0 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1105003110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1105003110
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1105003111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["1050ui_story"]) and arg_447_1.var_.characterEffect1050ui_story == nil then
				arg_447_1.var_.characterEffect1050ui_story = arg_447_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["1050ui_story"]) then
				if arg_447_1.var_.characterEffect1050ui_story and not isNil(arg_447_1.actors_["1050ui_story"]) then
					arg_447_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_0)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["1050ui_story"]) and arg_447_1.var_.characterEffect1050ui_story then
				arg_447_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_450_1 = 0
			local var_450_2 = 0.875

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1105003110).content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 35 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 35)

				if (35 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 35)) > 0 and var_450_2 < var_450_5 then
					arg_447_1.talkMaxDuration = var_450_5

					if var_450_5 + var_450_1 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + var_450_1
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_6 = math.max(var_450_2, arg_447_1.talkMaxDuration)

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_6 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_1) / var_450_6

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_1 + var_450_6 and arg_447_1.time_ < var_450_1 + var_450_6 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1105003111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1105003111
		arg_451_1.duration_ = 4.93

		local var_451_0 = {
			zh = 1.999999999999,
			ja = 4.933
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
			arg_451_1.auto_ = false
		end

		function arg_451_1.playNext_(arg_453_0)
			arg_451_1.onStoryFinished_()
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1050ui_story = arg_451_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1050ui_story"].transform.position).z)
				arg_451_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1050ui_story"].transform.localEulerAngles = arg_451_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_451_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1050ui_story"].transform.position).z)
				arg_451_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1050ui_story"].transform.localEulerAngles = arg_451_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["1050ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1050ui_story == nil then
				arg_451_1.var_.characterEffect1050ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect1050ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1050ui_story then
				arg_451_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_2")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_454_4 = 0
			local var_454_5 = 0.15

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_6 = arg_451_1:GetWordFromCfg(1105003111)
				local var_454_7 = arg_451_1:FormatText(var_454_6.content)

				arg_451_1.text_.text = var_454_7

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 6 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 6)

				if (6 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 6)) > 0 and var_454_5 < var_454_9 then
					arg_451_1.talkMaxDuration = var_454_9

					if var_454_9 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_7
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003111", "story_v_side_new_1105003.awb") ~= 0 then
					local var_454_10 = manager.audio:GetVoiceLength("story_v_side_new_1105003", "1105003111", "story_v_side_new_1105003.awb") / 1000

					if var_454_10 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_4
					end

					if var_454_6.prefab_name ~= "" and arg_451_1.actors_[var_454_6.prefab_name] ~= nil then
						local var_454_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_6.prefab_name].transform, "story_v_side_new_1105003", "1105003111", "story_v_side_new_1105003.awb")

						arg_451_1:RecordAudio("1105003111", var_454_11)
						arg_451_1:RecordAudio("1105003111", var_454_11)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1105003", "1105003111", "story_v_side_new_1105003.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1105003", "1105003111", "story_v_side_new_1105003.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_12 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_12 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_12

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_12 and arg_451_1.time_ < var_454_4 + var_454_12 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K03h",
		"TextureConfig/Background/K06f",
		"TextureConfig/Background/ST59"
	},
	voices = {
		"story_v_side_new_1105003.awb"
	}
}
