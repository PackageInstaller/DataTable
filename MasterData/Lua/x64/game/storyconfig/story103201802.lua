return {
	Play320182001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320182001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320182002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L02f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_4_0.name = "L02f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L02f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L02f

				arg_1_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L02f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_punch_hit", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.999999999999
			local var_4_17 = 0.175

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(320182001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 7 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 7)

				if (7 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 7)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320182002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320182002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320182003(arg_9_1)
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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(320182002).content)

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
	Play320182003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320182003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320182004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(320182003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 49 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 49)

				if (49 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 49)) > 0 and var_16_0 < var_16_3 then
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
	Play320182004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320182004
		arg_17_1.duration_ = 2.6

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 2.6
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320182005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1052ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1052ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1052ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1052ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1052ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1052ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1052ui_story = var_20_3.localPosition

				arg_17_1:ShowWeapon(arg_17_1.var_["1052ui_story" .. "Animator"].transform, false)
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1052ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1052ui_story == nil then
				arg_17_1.var_.characterEffect1052ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1052ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1052ui_story then
				arg_17_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action5_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_8 = 0
			local var_20_9 = 0.15

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(320182004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 6 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 6)

				if (6 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 6)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182004", "story_v_out_320182.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_320182", "320182004", "story_v_out_320182.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_320182", "320182004", "story_v_out_320182.awb")

						arg_17_1:RecordAudio("320182004", var_20_15)
						arg_17_1:RecordAudio("320182004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320182", "320182004", "story_v_out_320182.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320182", "320182004", "story_v_out_320182.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play320182005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320182005
		arg_21_1.duration_ = 4.7

		local var_21_0 = {
			zh = 4.633,
			ja = 4.7
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320182006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1052ui_story"]) and arg_21_1.var_.characterEffect1052ui_story == nil then
				arg_21_1.var_.characterEffect1052ui_story = arg_21_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1052ui_story"]) then
				if arg_21_1.var_.characterEffect1052ui_story and not isNil(arg_21_1.actors_["1052ui_story"]) then
					arg_21_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1052ui_story"]) and arg_21_1.var_.characterEffect1052ui_story then
				arg_21_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[589].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(320182005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 15 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 15)

				if (15 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 15)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182005", "story_v_out_320182.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182005", "story_v_out_320182.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_320182", "320182005", "story_v_out_320182.awb")

						arg_21_1:RecordAudio("320182005", var_24_8)
						arg_21_1:RecordAudio("320182005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320182", "320182005", "story_v_out_320182.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320182", "320182005", "story_v_out_320182.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320182006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320182006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320182007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1052ui_story = arg_25_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1052ui_story"].transform.position).z)
				arg_25_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1052ui_story"].transform.localEulerAngles = arg_25_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1052ui_story"].transform.position).z)
				arg_25_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1052ui_story"].transform.localEulerAngles = arg_25_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 1.125

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(320182006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 45 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 45)

				if (45 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 45)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
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
	Play320182007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320182007
		arg_29_1.duration_ = 12.9

		local var_29_0 = {
			zh = 12.9,
			ja = 9.266
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
				arg_29_0:Play320182008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.475

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[589].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(320182007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 59 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 59)

				if (59 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 59)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182007", "story_v_out_320182.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182007", "story_v_out_320182.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_320182", "320182007", "story_v_out_320182.awb")

						arg_29_1:RecordAudio("320182007", var_32_6)
						arg_29_1:RecordAudio("320182007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320182", "320182007", "story_v_out_320182.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320182", "320182007", "story_v_out_320182.awb")
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
	Play320182008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320182008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play320182009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.7

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(320182008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 28 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 28)

				if (28 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 28)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320182009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320182009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320182010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(320182009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 57 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 57)

				if (57 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 57)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320182010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320182010
		arg_41_1.duration_ = 8.97

		local var_41_0 = {
			zh = 3.8,
			ja = 8.966
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
				arg_41_0:Play320182011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1052ui_story = arg_41_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1052ui_story"].transform.position).z)
				arg_41_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1052ui_story"].transform.localEulerAngles = arg_41_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_41_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1052ui_story"].transform.position).z)
				arg_41_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1052ui_story"].transform.localEulerAngles = arg_41_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1052ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1052ui_story == nil then
				arg_41_1.var_.characterEffect1052ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1052ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1052ui_story then
				arg_41_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action5_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(320182010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 12 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 12)

				if (12 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 12)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182010", "story_v_out_320182.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182010", "story_v_out_320182.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_320182", "320182010", "story_v_out_320182.awb")

						arg_41_1:RecordAudio("320182010", var_44_11)
						arg_41_1:RecordAudio("320182010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320182", "320182010", "story_v_out_320182.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320182", "320182010", "story_v_out_320182.awb")
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
				actorName = "1052ui_story",
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
	Play320182011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320182011
		arg_45_1.duration_ = 10.23

		local var_45_0 = {
			zh = 6.8,
			ja = 10.233
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
				arg_45_0:Play320182012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1052ui_story"]) and arg_45_1.var_.characterEffect1052ui_story == nil then
				arg_45_1.var_.characterEffect1052ui_story = arg_45_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1052ui_story"]) then
				if arg_45_1.var_.characterEffect1052ui_story and not isNil(arg_45_1.actors_["1052ui_story"]) then
					arg_45_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1052ui_story"]) and arg_45_1.var_.characterEffect1052ui_story then
				arg_45_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.55

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[589].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(320182011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 22 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 22)

				if (22 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 22)) > 0 and var_48_2 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182011", "story_v_out_320182.awb") ~= 0 then
					local var_48_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182011", "story_v_out_320182.awb") / 1000

					if var_48_7 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_1
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_320182", "320182011", "story_v_out_320182.awb")

						arg_45_1:RecordAudio("320182011", var_48_8)
						arg_45_1:RecordAudio("320182011", var_48_8)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320182", "320182011", "story_v_out_320182.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320182", "320182011", "story_v_out_320182.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_9 and arg_45_1.time_ < var_48_1 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320182012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320182012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320182013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.85

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(320182012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 34 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 34)

				if (34 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 34)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320182013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320182013
		arg_53_1.duration_ = 6.57

		local var_53_0 = {
			zh = 6.033,
			ja = 6.566
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320182014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1052ui_story = arg_53_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1052ui_story"].transform.position).z)
				arg_53_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1052ui_story"].transform.localEulerAngles = arg_53_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_53_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1052ui_story"].transform.position).z)
				arg_53_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1052ui_story"].transform.localEulerAngles = arg_53_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1052ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1052ui_story == nil then
				arg_53_1.var_.characterEffect1052ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1052ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1052ui_story then
				arg_53_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_56_4 = 0
			local var_56_5 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(320182013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 25 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 25)

				if (25 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 25)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182013", "story_v_out_320182.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182013", "story_v_out_320182.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_320182", "320182013", "story_v_out_320182.awb")

						arg_53_1:RecordAudio("320182013", var_56_11)
						arg_53_1:RecordAudio("320182013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320182", "320182013", "story_v_out_320182.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320182", "320182013", "story_v_out_320182.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play320182014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320182014
		arg_57_1.duration_ = 4.73

		local var_57_0 = {
			zh = 2.533,
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
				arg_57_0:Play320182015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1052ui_story"]) and arg_57_1.var_.characterEffect1052ui_story == nil then
				arg_57_1.var_.characterEffect1052ui_story = arg_57_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1052ui_story"]) then
				if arg_57_1.var_.characterEffect1052ui_story and not isNil(arg_57_1.actors_["1052ui_story"]) then
					arg_57_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1052ui_story"]) and arg_57_1.var_.characterEffect1052ui_story then
				arg_57_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[589].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(320182014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 8 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 8)

				if (8 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 8)) > 0 and var_60_2 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182014", "story_v_out_320182.awb") ~= 0 then
					local var_60_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182014", "story_v_out_320182.awb") / 1000

					if var_60_7 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_1
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_320182", "320182014", "story_v_out_320182.awb")

						arg_57_1:RecordAudio("320182014", var_60_8)
						arg_57_1:RecordAudio("320182014", var_60_8)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320182", "320182014", "story_v_out_320182.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320182", "320182014", "story_v_out_320182.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_9 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_9 and arg_57_1.time_ < var_60_1 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320182015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320182015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play320182016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1052ui_story = arg_61_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1052ui_story"].transform.position).z)
				arg_61_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1052ui_story"].transform.localEulerAngles = arg_61_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1052ui_story"].transform.position).z)
				arg_61_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1052ui_story"].transform.localEulerAngles = arg_61_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_64_1 = 0
			local var_64_2 = 0.9

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

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(320182015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 36 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 36)

				if (36 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 36)) > 0 and var_64_2 < var_64_5 then
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play320182016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320182016
		arg_65_1.duration_ = 5.17

		local var_65_0 = {
			zh = 5.166,
			ja = 3.133
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
				arg_65_0:Play320182017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1058].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(320182016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 12 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 12)

				if (12 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 12)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182016", "story_v_out_320182.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182016", "story_v_out_320182.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_320182", "320182016", "story_v_out_320182.awb")

						arg_65_1:RecordAudio("320182016", var_68_6)
						arg_65_1:RecordAudio("320182016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320182", "320182016", "story_v_out_320182.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320182", "320182016", "story_v_out_320182.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320182017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320182017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320182018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_16", "se_story_16_drag_loop", "")
			end

			local var_72_1 = 0
			local var_72_2 = 1.55

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(320182017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 62 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 62)

				if (62 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 62)) > 0 and var_72_2 < var_72_5 then
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
	Play320182018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320182018
		arg_73_1.duration_ = 3.63

		local var_73_0 = {
			zh = 2.533,
			ja = 3.633
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play320182019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("stop", "music", "se_story_16", "se_story_16_drag_loop", "")

				local var_76_2 = manager.audio:GetAudioName("se_story_16", "se_story_16_drag_loop")

				if "" ~= "" then
					if arg_73_1.bgmTxt_.text ~= var_76_2 and arg_73_1.bgmTxt_.text ~= "" then
						if arg_73_1.bgmTxt2_.text ~= "" then
							arg_73_1.bgmTxt_.text = arg_73_1.bgmTxt2_.text
						end

						arg_73_1.bgmTxt2_.text = var_76_2

						arg_73_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_73_1.bgmTxt_.text = var_76_2
						arg_73_1.bgmTxt2_.text = var_76_2
					end

					if arg_73_1.bgmTimer then
						arg_73_1.bgmTimer:Stop()

						arg_73_1.bgmTimer = nil
					end

					if arg_73_1.settingData.show_music_name == 1 then
						arg_73_1.musicController:SetSelectedState("show")
						arg_73_1.musicAnimator_:Play("open", 0, 0)

						if arg_73_1.settingData.music_time ~= 0 then
							arg_73_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_73_1.settingData.music_time), function()
								if arg_73_1 == nil or isNil(arg_73_1.bgmTxt_) then
									return
								end

								arg_73_1.musicController:SetSelectedState("hide")
								arg_73_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_76_3 = 0
			local var_76_4 = 0.15

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1058].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_5 = arg_73_1:GetWordFromCfg(320182018)
				local var_76_6 = arg_73_1:FormatText(var_76_5.content)

				arg_73_1.text_.text = var_76_6

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 6 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 6)

				if (6 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 6)) > 0 and var_76_4 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_6
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182018", "story_v_out_320182.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_320182", "320182018", "story_v_out_320182.awb") / 1000

					if var_76_9 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_3
					end

					if var_76_5.prefab_name ~= "" and arg_73_1.actors_[var_76_5.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_5.prefab_name].transform, "story_v_out_320182", "320182018", "story_v_out_320182.awb")

						arg_73_1:RecordAudio("320182018", var_76_10)
						arg_73_1:RecordAudio("320182018", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320182", "320182018", "story_v_out_320182.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320182", "320182018", "story_v_out_320182.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_11 and arg_73_1.time_ < var_76_3 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play320182019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 320182019
		arg_78_1.duration_ = 7.23

		local var_78_0 = {
			zh = 7.233,
			ja = 5.9
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play320182020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.475

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1058].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(320182019)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 19 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 19)

				if (19 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 19)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182019", "story_v_out_320182.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182019", "story_v_out_320182.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_320182", "320182019", "story_v_out_320182.awb")

						arg_78_1:RecordAudio("320182019", var_81_6)
						arg_78_1:RecordAudio("320182019", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_320182", "320182019", "story_v_out_320182.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_320182", "320182019", "story_v_out_320182.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play320182020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 320182020
		arg_82_1.duration_ = 7.27

		local var_82_0 = {
			zh = 6.66666666666667,
			ja = 7.26666666666667
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play320182021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if arg_82_1.bgs_.ST61 == nil then
				local var_85_0 = Object.Instantiate(arg_82_1.paintGo_)

				var_85_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_85_0.name = "ST61"
				var_85_0.transform.parent = arg_82_1.stage_.transform
				var_85_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.bgs_.ST61 = var_85_0
			end

			if 1.63333333333333 < arg_82_1.time_ and arg_82_1.time_ <= 1.63333333333333 + arg_85_0 then
				local var_85_1 = arg_82_1.bgs_.ST61

				arg_82_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_85_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_85_2 = var_85_1:GetComponent("SpriteRenderer")

				if var_85_2 and var_85_2.sprite then
					local var_85_3 = 2 * (var_85_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_85_1.transform.localScale = Vector3.New(var_85_3 / var_85_2.sprite.bounds.size.y < var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x and var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x or var_85_3 / var_85_2.sprite.bounds.size.y, var_85_3 / var_85_2.sprite.bounds.size.y < var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x and var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x or var_85_3 / var_85_2.sprite.bounds.size.y, 0)
				end

				for iter_85_0, iter_85_1 in pairs(arg_82_1.bgs_) do
					if iter_85_0 ~= "ST61" then
						iter_85_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_85_4 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_4 + 0.3 and arg_82_1.time_ < var_85_4 + 0.3 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_5 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_6 = 1.63333333333333

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 then
				local var_85_7 = Color.New(0, 0, 0)

				var_85_7.a = Mathf.Lerp(0, 1, (arg_82_1.time_ - var_85_5) / var_85_6)
				arg_82_1.mask_.color = var_85_7
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 then
				local var_85_8 = Color.New(0, 0, 0)

				var_85_8.a = 1
				arg_82_1.mask_.color = var_85_8
			end

			local var_85_9 = 1.63333333333333

			if 1.63333333333333 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_10 = 1.63333333333333

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 then
				local var_85_11 = Color.New(0, 0, 0)

				var_85_11.a = Mathf.Lerp(1, 0, (arg_82_1.time_ - var_85_9) / var_85_10)
				arg_82_1.mask_.color = var_85_11
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 then
				local var_85_12 = Color.New(0, 0, 0)

				arg_82_1.mask_.enabled = false
				var_85_12.a = 0
				arg_82_1.mask_.color = var_85_12
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_85_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_82_1.bgmTxt_.text ~= var_85_15 and arg_82_1.bgmTxt_.text ~= "" then
						if arg_82_1.bgmTxt2_.text ~= "" then
							arg_82_1.bgmTxt_.text = arg_82_1.bgmTxt2_.text
						end

						arg_82_1.bgmTxt2_.text = var_85_15

						arg_82_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_82_1.bgmTxt_.text = var_85_15
						arg_82_1.bgmTxt2_.text = var_85_15
					end

					if arg_82_1.bgmTimer then
						arg_82_1.bgmTimer:Stop()

						arg_82_1.bgmTimer = nil
					end

					if arg_82_1.settingData.show_music_name == 1 then
						arg_82_1.musicController:SetSelectedState("show")
						arg_82_1.musicAnimator_:Play("open", 0, 0)

						if arg_82_1.settingData.music_time ~= 0 then
							arg_82_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_82_1.settingData.music_time), function()
								if arg_82_1 == nil or isNil(arg_82_1.bgmTxt_) then
									return
								end

								arg_82_1.musicController:SetSelectedState("hide")
								arg_82_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_82_1.time_ and arg_82_1.time_ <= 1 + arg_85_0 then
				arg_82_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_85_18 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_82_1.bgmTxt_.text ~= var_85_18 and arg_82_1.bgmTxt_.text ~= "" then
						if arg_82_1.bgmTxt2_.text ~= "" then
							arg_82_1.bgmTxt_.text = arg_82_1.bgmTxt2_.text
						end

						arg_82_1.bgmTxt2_.text = var_85_18

						arg_82_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_82_1.bgmTxt_.text = var_85_18
						arg_82_1.bgmTxt2_.text = var_85_18
					end

					if arg_82_1.bgmTimer then
						arg_82_1.bgmTimer:Stop()

						arg_82_1.bgmTimer = nil
					end

					if arg_82_1.settingData.show_music_name == 1 then
						arg_82_1.musicController:SetSelectedState("show")
						arg_82_1.musicAnimator_:Play("open", 0, 0)

						if arg_82_1.settingData.music_time ~= 0 then
							arg_82_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_82_1.settingData.music_time), function()
								if arg_82_1 == nil or isNil(arg_82_1.bgmTxt_) then
									return
								end

								arg_82_1.musicController:SetSelectedState("hide")
								arg_82_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_19 = 3.26666666666667
			local var_85_20 = 0.35

			if 3.26666666666667 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_21 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_21:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_82_1.dialogCg_.alpha = arg_88_0
				end))
				var_85_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_1")

				arg_82_1.callingController_:SetSelectedState("calling")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_22 = arg_82_1:GetWordFromCfg(320182020)
				local var_85_23 = arg_82_1:FormatText(var_85_22.content)

				arg_82_1.text_.text = var_85_23

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_25 = 14 <= 0 and var_85_20 or var_85_20 * (utf8.len(var_85_23) / 14)

				if (14 <= 0 and var_85_20 or var_85_20 * (utf8.len(var_85_23) / 14)) > 0 and var_85_20 < var_85_25 then
					arg_82_1.talkMaxDuration = var_85_25
					var_85_19 = var_85_19 + 0.3

					if var_85_25 + var_85_19 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_25 + var_85_19
					end
				end

				arg_82_1.text_.text = var_85_23
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182020", "story_v_out_320182.awb") ~= 0 then
					local var_85_26 = manager.audio:GetVoiceLength("story_v_out_320182", "320182020", "story_v_out_320182.awb") / 1000

					if var_85_26 + var_85_19 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_26 + var_85_19
					end

					if var_85_22.prefab_name ~= "" and arg_82_1.actors_[var_85_22.prefab_name] ~= nil then
						local var_85_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_22.prefab_name].transform, "story_v_out_320182", "320182020", "story_v_out_320182.awb")

						arg_82_1:RecordAudio("320182020", var_85_27)
						arg_82_1:RecordAudio("320182020", var_85_27)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_320182", "320182020", "story_v_out_320182.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_320182", "320182020", "story_v_out_320182.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_28 = var_85_19 + 0.3
			local var_85_29 = math.max(var_85_20, arg_82_1.talkMaxDuration)

			if var_85_19 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_28 + var_85_29 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_28) / var_85_29

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_28 + var_85_29 and arg_82_1.time_ < var_85_28 + var_85_29 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play320182021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 320182021
		arg_90_1.duration_ = 3.07

		local var_90_0 = {
			zh = 1.4,
			ja = 3.066
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play320182022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.15

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_1")

				arg_90_1.callingController_:SetSelectedState("calling")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(320182021)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 6 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 6)

				if (6 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 6)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182021", "story_v_out_320182.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182021", "story_v_out_320182.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_320182", "320182021", "story_v_out_320182.awb")

						arg_90_1:RecordAudio("320182021", var_93_6)
						arg_90_1:RecordAudio("320182021", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_320182", "320182021", "story_v_out_320182.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_320182", "320182021", "story_v_out_320182.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play320182022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 320182022
		arg_94_1.duration_ = 11.57

		local var_94_0 = {
			zh = 6.9,
			ja = 11.566
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play320182023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_97_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_94_1.stage_.transform)

				var_97_0.name = "1089ui_story"
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_["1089ui_story"] = var_97_0

				local var_97_1 = var_97_0:GetComponentInChildren(typeof(CharacterEffect))

				var_97_1.enabled = true

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end

				arg_94_1:ShowWeapon(var_97_1.transform, false)

				arg_94_1.var_["1089ui_story" .. "Animator"] = var_97_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_94_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_94_1.var_["1089ui_story" .. "LipSync"] = var_97_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_97_3 = arg_94_1.actors_["1089ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1089ui_story = var_97_3.localPosition
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_3.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_94_1.time_ - 0) / var_97_4)
				var_97_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_3.position).x, (manager.ui.mainCamera.transform.position - var_97_3.position).y, (manager.ui.mainCamera.transform.position - var_97_3.position).z)
				var_97_3.localEulerAngles.z = 0
				var_97_3.localEulerAngles.x = 0
				var_97_3.localEulerAngles = var_97_3.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_97_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_3.position).x, (manager.ui.mainCamera.transform.position - var_97_3.position).y, (manager.ui.mainCamera.transform.position - var_97_3.position).z)
				var_97_3.localEulerAngles.z = 0
				var_97_3.localEulerAngles.x = 0
				var_97_3.localEulerAngles = var_97_3.localEulerAngles
			end

			local var_97_5 = arg_94_1.actors_["1089ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1089ui_story == nil then
				arg_94_1.var_.characterEffect1089ui_story = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_6 and not isNil(var_97_5) then
				if arg_94_1.var_.characterEffect1089ui_story and not isNil(var_97_5) then
					arg_94_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_6 and arg_94_1.time_ < 0 + var_97_6 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1089ui_story then
				arg_94_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_97_8 = 0
			local var_97_9 = 0.625

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(320182022)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 25 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 25)

				if (25 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 25)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182022", "story_v_out_320182.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_320182", "320182022", "story_v_out_320182.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_320182", "320182022", "story_v_out_320182.awb")

						arg_94_1:RecordAudio("320182022", var_97_15)
						arg_94_1:RecordAudio("320182022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_320182", "320182022", "story_v_out_320182.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_320182", "320182022", "story_v_out_320182.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play320182023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 320182023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play320182024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1089ui_story"]) and arg_98_1.var_.characterEffect1089ui_story == nil then
				arg_98_1.var_.characterEffect1089ui_story = arg_98_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1089ui_story"]) then
				if arg_98_1.var_.characterEffect1089ui_story and not isNil(arg_98_1.actors_["1089ui_story"]) then
					arg_98_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1089ui_story"]) and arg_98_1.var_.characterEffect1089ui_story then
				arg_98_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_101_1 = arg_98_1.actors_["1089ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1089ui_story = var_101_1.localPosition
			end

			local var_101_2 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 then
				var_101_1.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_2)
				var_101_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_1.position).x, (manager.ui.mainCamera.transform.position - var_101_1.position).y, (manager.ui.mainCamera.transform.position - var_101_1.position).z)
				var_101_1.localEulerAngles.z = 0
				var_101_1.localEulerAngles.x = 0
				var_101_1.localEulerAngles = var_101_1.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 then
				var_101_1.localPosition = Vector3.New(0, 100, 0)
				var_101_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_1.position).x, (manager.ui.mainCamera.transform.position - var_101_1.position).y, (manager.ui.mainCamera.transform.position - var_101_1.position).z)
				var_101_1.localEulerAngles.z = 0
				var_101_1.localEulerAngles.x = 0
				var_101_1.localEulerAngles = var_101_1.localEulerAngles
			end

			local var_101_3 = 0
			local var_101_4 = 1.6

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_5 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(320182023).content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 64 <= 0 and var_101_4 or var_101_4 * (utf8.len(var_101_5) / 64)

				if (64 <= 0 and var_101_4 or var_101_4 * (utf8.len(var_101_5) / 64)) > 0 and var_101_4 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_3 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_3
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_4, arg_98_1.talkMaxDuration)

			if var_101_3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_3 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_3) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_3 + var_101_8 and arg_98_1.time_ < var_101_3 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play320182024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 320182024
		arg_102_1.duration_ = 3.63

		local var_102_0 = {
			zh = 2.3,
			ja = 3.633
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play320182025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1089ui_story = arg_102_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1089ui_story"].transform.position).z)
				arg_102_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1089ui_story"].transform.localEulerAngles = arg_102_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_102_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1089ui_story"].transform.position).z)
				arg_102_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1089ui_story"].transform.localEulerAngles = arg_102_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1089ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1089ui_story == nil then
				arg_102_1.var_.characterEffect1089ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1089ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1089ui_story then
				arg_102_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_105_4 = 0
			local var_105_5 = 0.25

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(320182024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 10 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 10)

				if (10 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 10)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182024", "story_v_out_320182.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182024", "story_v_out_320182.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_320182", "320182024", "story_v_out_320182.awb")

						arg_102_1:RecordAudio("320182024", var_105_11)
						arg_102_1:RecordAudio("320182024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_320182", "320182024", "story_v_out_320182.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_320182", "320182024", "story_v_out_320182.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play320182025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 320182025
		arg_106_1.duration_ = 4.87

		local var_106_0 = {
			zh = 2.966,
			ja = 4.866
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play320182026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1089ui_story"]) and arg_106_1.var_.characterEffect1089ui_story == nil then
				arg_106_1.var_.characterEffect1089ui_story = arg_106_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1089ui_story"]) then
				if arg_106_1.var_.characterEffect1089ui_story and not isNil(arg_106_1.actors_["1089ui_story"]) then
					arg_106_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1089ui_story"]) and arg_106_1.var_.characterEffect1089ui_story then
				arg_106_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(320182025)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_6 = 14 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_4) / 14)

				if (14 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_4) / 14)) > 0 and var_109_2 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182025", "story_v_out_320182.awb") ~= 0 then
					local var_109_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182025", "story_v_out_320182.awb") / 1000

					if var_109_7 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_1
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_320182", "320182025", "story_v_out_320182.awb")

						arg_106_1:RecordAudio("320182025", var_109_8)
						arg_106_1:RecordAudio("320182025", var_109_8)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_320182", "320182025", "story_v_out_320182.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_320182", "320182025", "story_v_out_320182.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_9 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_9 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_9

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_9 and arg_106_1.time_ < var_109_1 + var_109_9 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play320182026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 320182026
		arg_110_1.duration_ = 6.37

		local var_110_0 = {
			zh = 6.366,
			ja = 6.3
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play320182027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1089ui_story = arg_110_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1089ui_story"].transform.position).z)
				arg_110_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1089ui_story"].transform.localEulerAngles = arg_110_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_110_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1089ui_story"].transform.position).z)
				arg_110_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1089ui_story"].transform.localEulerAngles = arg_110_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["1089ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1089ui_story == nil then
				arg_110_1.var_.characterEffect1089ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect1089ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1089ui_story then
				arg_110_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_113_4 = 0
			local var_113_5 = 0.625

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(320182026)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 25 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 25)

				if (25 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 25)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182026", "story_v_out_320182.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182026", "story_v_out_320182.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_320182", "320182026", "story_v_out_320182.awb")

						arg_110_1:RecordAudio("320182026", var_113_11)
						arg_110_1:RecordAudio("320182026", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_320182", "320182026", "story_v_out_320182.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_320182", "320182026", "story_v_out_320182.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play320182027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 320182027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play320182028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1089ui_story"]) and arg_114_1.var_.characterEffect1089ui_story == nil then
				arg_114_1.var_.characterEffect1089ui_story = arg_114_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1089ui_story"]) then
				if arg_114_1.var_.characterEffect1089ui_story and not isNil(arg_114_1.actors_["1089ui_story"]) then
					arg_114_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1089ui_story"]) and arg_114_1.var_.characterEffect1089ui_story then
				arg_114_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_117_1 = 0
			local var_117_2 = 1.525

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(320182027).content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 61 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 61)

				if (61 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 61)) > 0 and var_117_2 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_6 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_6 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_6

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_6 and arg_114_1.time_ < var_117_1 + var_117_6 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play320182028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 320182028
		arg_118_1.duration_ = 10.53

		local var_118_0 = {
			zh = 7,
			ja = 10.533
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play320182029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.8

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:GetWordFromCfg(320182028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 32 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 32)

				if (32 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 32)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182028", "story_v_out_320182.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182028", "story_v_out_320182.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_320182", "320182028", "story_v_out_320182.awb")

						arg_118_1:RecordAudio("320182028", var_121_6)
						arg_118_1:RecordAudio("320182028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_320182", "320182028", "story_v_out_320182.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_320182", "320182028", "story_v_out_320182.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play320182029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 320182029
		arg_122_1.duration_ = 6.23

		local var_122_0 = {
			zh = 2.233,
			ja = 6.233
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play320182030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1089ui_story"]) and arg_122_1.var_.characterEffect1089ui_story == nil then
				arg_122_1.var_.characterEffect1089ui_story = arg_122_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1089ui_story"]) then
				if arg_122_1.var_.characterEffect1089ui_story and not isNil(arg_122_1.actors_["1089ui_story"]) then
					arg_122_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1089ui_story"]) and arg_122_1.var_.characterEffect1089ui_story then
				arg_122_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_125_2 = 0
			local var_125_3 = 0.25

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(320182029)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 10 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 10)

				if (10 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 10)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182029", "story_v_out_320182.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182029", "story_v_out_320182.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_320182", "320182029", "story_v_out_320182.awb")

						arg_122_1:RecordAudio("320182029", var_125_9)
						arg_122_1:RecordAudio("320182029", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_320182", "320182029", "story_v_out_320182.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_320182", "320182029", "story_v_out_320182.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play320182030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 320182030
		arg_126_1.duration_ = 6.07

		local var_126_0 = {
			zh = 6.066,
			ja = 4.6
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play320182031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1089ui_story"]) and arg_126_1.var_.characterEffect1089ui_story == nil then
				arg_126_1.var_.characterEffect1089ui_story = arg_126_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1089ui_story"]) then
				if arg_126_1.var_.characterEffect1089ui_story and not isNil(arg_126_1.actors_["1089ui_story"]) then
					arg_126_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1089ui_story"]) and arg_126_1.var_.characterEffect1089ui_story then
				arg_126_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.65

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(320182030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_6 = 26 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_4) / 26)

				if (26 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_4) / 26)) > 0 and var_129_2 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182030", "story_v_out_320182.awb") ~= 0 then
					local var_129_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182030", "story_v_out_320182.awb") / 1000

					if var_129_7 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_1
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_320182", "320182030", "story_v_out_320182.awb")

						arg_126_1:RecordAudio("320182030", var_129_8)
						arg_126_1:RecordAudio("320182030", var_129_8)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_320182", "320182030", "story_v_out_320182.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_320182", "320182030", "story_v_out_320182.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_9 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_9 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_9

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_9 and arg_126_1.time_ < var_129_1 + var_129_9 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play320182031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 320182031
		arg_130_1.duration_ = 6.37

		local var_130_0 = {
			zh = 5.966,
			ja = 6.366
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play320182032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.75

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:GetWordFromCfg(320182031)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 30 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 30)

				if (30 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 30)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182031", "story_v_out_320182.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182031", "story_v_out_320182.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_320182", "320182031", "story_v_out_320182.awb")

						arg_130_1:RecordAudio("320182031", var_133_6)
						arg_130_1:RecordAudio("320182031", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_320182", "320182031", "story_v_out_320182.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_320182", "320182031", "story_v_out_320182.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play320182032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 320182032
		arg_134_1.duration_ = 13.33

		local var_134_0 = {
			zh = 6.7,
			ja = 13.333
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play320182033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1089ui_story"]) and arg_134_1.var_.characterEffect1089ui_story == nil then
				arg_134_1.var_.characterEffect1089ui_story = arg_134_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1089ui_story"]) then
				if arg_134_1.var_.characterEffect1089ui_story and not isNil(arg_134_1.actors_["1089ui_story"]) then
					arg_134_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1089ui_story"]) and arg_134_1.var_.characterEffect1089ui_story then
				arg_134_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_137_2 = 0
			local var_137_3 = 0.75

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(320182032)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 30 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 30)

				if (30 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 30)) > 0 and var_137_3 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182032", "story_v_out_320182.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182032", "story_v_out_320182.awb") / 1000

					if var_137_8 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_2
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_320182", "320182032", "story_v_out_320182.awb")

						arg_134_1:RecordAudio("320182032", var_137_9)
						arg_134_1:RecordAudio("320182032", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_320182", "320182032", "story_v_out_320182.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_320182", "320182032", "story_v_out_320182.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_10 and arg_134_1.time_ < var_137_2 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play320182033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 320182033
		arg_138_1.duration_ = 14.6

		local var_138_0 = {
			zh = 10.366,
			ja = 14.6
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play320182034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1089ui_story"]) and arg_138_1.var_.characterEffect1089ui_story == nil then
				arg_138_1.var_.characterEffect1089ui_story = arg_138_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1089ui_story"]) then
				if arg_138_1.var_.characterEffect1089ui_story and not isNil(arg_138_1.actors_["1089ui_story"]) then
					arg_138_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1089ui_story"]) and arg_138_1.var_.characterEffect1089ui_story then
				arg_138_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 1.25

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(320182033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 50 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 50)

				if (50 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 50)) > 0 and var_141_2 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182033", "story_v_out_320182.awb") ~= 0 then
					local var_141_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182033", "story_v_out_320182.awb") / 1000

					if var_141_7 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_1
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_320182", "320182033", "story_v_out_320182.awb")

						arg_138_1:RecordAudio("320182033", var_141_8)
						arg_138_1:RecordAudio("320182033", var_141_8)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_320182", "320182033", "story_v_out_320182.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_320182", "320182033", "story_v_out_320182.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_9 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_9 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_9

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_9 and arg_138_1.time_ < var_141_1 + var_141_9 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play320182034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 320182034
		arg_142_1.duration_ = 7.8

		local var_142_0 = {
			zh = 6.833,
			ja = 7.8
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play320182035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1089ui_story"]) and arg_142_1.var_.characterEffect1089ui_story == nil then
				arg_142_1.var_.characterEffect1089ui_story = arg_142_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1089ui_story"]) then
				if arg_142_1.var_.characterEffect1089ui_story and not isNil(arg_142_1.actors_["1089ui_story"]) then
					arg_142_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1089ui_story"]) and arg_142_1.var_.characterEffect1089ui_story then
				arg_142_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_145_2 = 0
			local var_145_3 = 0.725

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(320182034)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 29 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 29)

				if (29 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 29)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182034", "story_v_out_320182.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182034", "story_v_out_320182.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_320182", "320182034", "story_v_out_320182.awb")

						arg_142_1:RecordAudio("320182034", var_145_9)
						arg_142_1:RecordAudio("320182034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_320182", "320182034", "story_v_out_320182.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_320182", "320182034", "story_v_out_320182.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play320182035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 320182035
		arg_146_1.duration_ = 6

		local var_146_0 = {
			zh = 4.866,
			ja = 6
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play320182036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1089ui_story"]) and arg_146_1.var_.characterEffect1089ui_story == nil then
				arg_146_1.var_.characterEffect1089ui_story = arg_146_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1089ui_story"]) then
				if arg_146_1.var_.characterEffect1089ui_story and not isNil(arg_146_1.actors_["1089ui_story"]) then
					arg_146_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_0)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1089ui_story"]) and arg_146_1.var_.characterEffect1089ui_story then
				arg_146_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_149_1 = 0
			local var_149_2 = 0.45

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(320182035)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_6 = 18 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_4) / 18)

				if (18 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_4) / 18)) > 0 and var_149_2 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182035", "story_v_out_320182.awb") ~= 0 then
					local var_149_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182035", "story_v_out_320182.awb") / 1000

					if var_149_7 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_1
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_320182", "320182035", "story_v_out_320182.awb")

						arg_146_1:RecordAudio("320182035", var_149_8)
						arg_146_1:RecordAudio("320182035", var_149_8)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_320182", "320182035", "story_v_out_320182.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_320182", "320182035", "story_v_out_320182.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_9 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_9 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_9

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_9 and arg_146_1.time_ < var_149_1 + var_149_9 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play320182036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 320182036
		arg_150_1.duration_ = 11.27

		local var_150_0 = {
			zh = 7.3,
			ja = 11.266
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play320182037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.825

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:GetWordFromCfg(320182036)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 33 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 33)

				if (33 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 33)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182036", "story_v_out_320182.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182036", "story_v_out_320182.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_320182", "320182036", "story_v_out_320182.awb")

						arg_150_1:RecordAudio("320182036", var_153_6)
						arg_150_1:RecordAudio("320182036", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_320182", "320182036", "story_v_out_320182.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_320182", "320182036", "story_v_out_320182.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play320182037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 320182037
		arg_154_1.duration_ = 13.07

		local var_154_0 = {
			zh = 9.733,
			ja = 13.066
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play320182038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.15

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:GetWordFromCfg(320182037)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 46 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 46)

				if (46 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 46)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182037", "story_v_out_320182.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182037", "story_v_out_320182.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_320182", "320182037", "story_v_out_320182.awb")

						arg_154_1:RecordAudio("320182037", var_157_6)
						arg_154_1:RecordAudio("320182037", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_320182", "320182037", "story_v_out_320182.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_320182", "320182037", "story_v_out_320182.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play320182038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 320182038
		arg_158_1.duration_ = 5.3

		local var_158_0 = {
			zh = 2.8,
			ja = 5.3
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play320182039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1089ui_story"]) and arg_158_1.var_.characterEffect1089ui_story == nil then
				arg_158_1.var_.characterEffect1089ui_story = arg_158_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1089ui_story"]) then
				if arg_158_1.var_.characterEffect1089ui_story and not isNil(arg_158_1.actors_["1089ui_story"]) then
					arg_158_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1089ui_story"]) and arg_158_1.var_.characterEffect1089ui_story then
				arg_158_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_161_2 = 0
			local var_161_3 = 0.275

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(320182038)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 11 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 11)

				if (11 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 11)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182038", "story_v_out_320182.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182038", "story_v_out_320182.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_out_320182", "320182038", "story_v_out_320182.awb")

						arg_158_1:RecordAudio("320182038", var_161_9)
						arg_158_1:RecordAudio("320182038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_320182", "320182038", "story_v_out_320182.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_320182", "320182038", "story_v_out_320182.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play320182039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 320182039
		arg_162_1.duration_ = 3.33

		local var_162_0 = {
			zh = 1.4,
			ja = 3.333
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play320182040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1089ui_story"]) and arg_162_1.var_.characterEffect1089ui_story == nil then
				arg_162_1.var_.characterEffect1089ui_story = arg_162_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1089ui_story"]) then
				if arg_162_1.var_.characterEffect1089ui_story and not isNil(arg_162_1.actors_["1089ui_story"]) then
					arg_162_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1089ui_story"]) and arg_162_1.var_.characterEffect1089ui_story then
				arg_162_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(320182039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 7 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 7)

				if (7 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 7)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182039", "story_v_out_320182.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182039", "story_v_out_320182.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_320182", "320182039", "story_v_out_320182.awb")

						arg_162_1:RecordAudio("320182039", var_165_8)
						arg_162_1:RecordAudio("320182039", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_320182", "320182039", "story_v_out_320182.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_320182", "320182039", "story_v_out_320182.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play320182040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 320182040
		arg_166_1.duration_ = 8.07

		local var_166_0 = {
			zh = 6.766,
			ja = 8.066
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play320182041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1089ui_story"]) and arg_166_1.var_.characterEffect1089ui_story == nil then
				arg_166_1.var_.characterEffect1089ui_story = arg_166_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1089ui_story"]) then
				if arg_166_1.var_.characterEffect1089ui_story and not isNil(arg_166_1.actors_["1089ui_story"]) then
					arg_166_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1089ui_story"]) and arg_166_1.var_.characterEffect1089ui_story then
				arg_166_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_169_2 = 0
			local var_169_3 = 0.825

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_4 = arg_166_1:GetWordFromCfg(320182040)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 33 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 33)

				if (33 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 33)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182040", "story_v_out_320182.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182040", "story_v_out_320182.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_out_320182", "320182040", "story_v_out_320182.awb")

						arg_166_1:RecordAudio("320182040", var_169_9)
						arg_166_1:RecordAudio("320182040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_320182", "320182040", "story_v_out_320182.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_320182", "320182040", "story_v_out_320182.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_10 and arg_166_1.time_ < var_169_2 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play320182041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 320182041
		arg_170_1.duration_ = 7

		local var_170_0 = {
			zh = 4.7,
			ja = 7
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play320182042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1089ui_story"]) and arg_170_1.var_.characterEffect1089ui_story == nil then
				arg_170_1.var_.characterEffect1089ui_story = arg_170_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1089ui_story"]) then
				if arg_170_1.var_.characterEffect1089ui_story and not isNil(arg_170_1.actors_["1089ui_story"]) then
					arg_170_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1089ui_story"]) and arg_170_1.var_.characterEffect1089ui_story then
				arg_170_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.375

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(320182041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_6 = 15 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_4) / 15)

				if (15 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_4) / 15)) > 0 and var_173_2 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182041", "story_v_out_320182.awb") ~= 0 then
					local var_173_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182041", "story_v_out_320182.awb") / 1000

					if var_173_7 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_1
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_320182", "320182041", "story_v_out_320182.awb")

						arg_170_1:RecordAudio("320182041", var_173_8)
						arg_170_1:RecordAudio("320182041", var_173_8)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_320182", "320182041", "story_v_out_320182.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_320182", "320182041", "story_v_out_320182.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_9 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_9 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_9

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_9 and arg_170_1.time_ < var_173_1 + var_173_9 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play320182042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 320182042
		arg_174_1.duration_ = 1.63

		local var_174_0 = {
			zh = 1.633,
			ja = 1.233
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play320182043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1089ui_story"]) and arg_174_1.var_.characterEffect1089ui_story == nil then
				arg_174_1.var_.characterEffect1089ui_story = arg_174_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1089ui_story"]) then
				if arg_174_1.var_.characterEffect1089ui_story and not isNil(arg_174_1.actors_["1089ui_story"]) then
					arg_174_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1089ui_story"]) and arg_174_1.var_.characterEffect1089ui_story then
				arg_174_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_177_2 = 0
			local var_177_3 = 0.125

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(320182042)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 5 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 5)

				if (5 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 5)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182042", "story_v_out_320182.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182042", "story_v_out_320182.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_320182", "320182042", "story_v_out_320182.awb")

						arg_174_1:RecordAudio("320182042", var_177_9)
						arg_174_1:RecordAudio("320182042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_320182", "320182042", "story_v_out_320182.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_320182", "320182042", "story_v_out_320182.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play320182043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 320182043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play320182044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1089ui_story"]) and arg_178_1.var_.characterEffect1089ui_story == nil then
				arg_178_1.var_.characterEffect1089ui_story = arg_178_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1089ui_story"]) then
				if arg_178_1.var_.characterEffect1089ui_story and not isNil(arg_178_1.actors_["1089ui_story"]) then
					arg_178_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1089ui_story"]) and arg_178_1.var_.characterEffect1089ui_story then
				arg_178_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 1.25

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(320182043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 50 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 50)

				if (50 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 50)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play320182044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 320182044
		arg_182_1.duration_ = 6.37

		local var_182_0 = {
			zh = 5.6,
			ja = 6.366
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play320182045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1089ui_story = arg_182_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1089ui_story"].transform.position).z)
				arg_182_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1089ui_story"].transform.localEulerAngles = arg_182_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_182_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1089ui_story"].transform.position).z)
				arg_182_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1089ui_story"].transform.localEulerAngles = arg_182_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1089ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1089ui_story == nil then
				arg_182_1.var_.characterEffect1089ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1089ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1089ui_story then
				arg_182_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_185_4 = 0
			local var_185_5 = 0.55

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(320182044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 22 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 22)

				if (22 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 22)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182044", "story_v_out_320182.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182044", "story_v_out_320182.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_320182", "320182044", "story_v_out_320182.awb")

						arg_182_1:RecordAudio("320182044", var_185_11)
						arg_182_1:RecordAudio("320182044", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_320182", "320182044", "story_v_out_320182.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_320182", "320182044", "story_v_out_320182.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play320182045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 320182045
		arg_186_1.duration_ = 7.4

		local var_186_0 = {
			zh = 3.933,
			ja = 7.4
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play320182046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1089ui_story"]) and arg_186_1.var_.characterEffect1089ui_story == nil then
				arg_186_1.var_.characterEffect1089ui_story = arg_186_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1089ui_story"]) then
				if arg_186_1.var_.characterEffect1089ui_story and not isNil(arg_186_1.actors_["1089ui_story"]) then
					arg_186_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1089ui_story"]) and arg_186_1.var_.characterEffect1089ui_story then
				arg_186_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.55

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(320182045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 22 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 22)

				if (22 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 22)) > 0 and var_189_2 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182045", "story_v_out_320182.awb") ~= 0 then
					local var_189_7 = manager.audio:GetVoiceLength("story_v_out_320182", "320182045", "story_v_out_320182.awb") / 1000

					if var_189_7 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_1
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_320182", "320182045", "story_v_out_320182.awb")

						arg_186_1:RecordAudio("320182045", var_189_8)
						arg_186_1:RecordAudio("320182045", var_189_8)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_320182", "320182045", "story_v_out_320182.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_320182", "320182045", "story_v_out_320182.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_9 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_9 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_9

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_9 and arg_186_1.time_ < var_189_1 + var_189_9 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play320182046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 320182046
		arg_190_1.duration_ = 2.9

		local var_190_0 = {
			zh = 1.766,
			ja = 2.9
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play320182047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.125

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:GetWordFromCfg(320182046)
				local var_193_2 = arg_190_1:FormatText(var_193_1.content)

				arg_190_1.text_.text = var_193_2

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 5 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 5)

				if (5 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 5)) > 0 and var_193_0 < var_193_4 then
					arg_190_1.talkMaxDuration = var_193_4

					if var_193_4 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_4 + 0
					end
				end

				arg_190_1.text_.text = var_193_2
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182046", "story_v_out_320182.awb") ~= 0 then
					local var_193_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182046", "story_v_out_320182.awb") / 1000

					if var_193_5 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + 0
					end

					if var_193_1.prefab_name ~= "" and arg_190_1.actors_[var_193_1.prefab_name] ~= nil then
						local var_193_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_1.prefab_name].transform, "story_v_out_320182", "320182046", "story_v_out_320182.awb")

						arg_190_1:RecordAudio("320182046", var_193_6)
						arg_190_1:RecordAudio("320182046", var_193_6)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_320182", "320182046", "story_v_out_320182.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_320182", "320182046", "story_v_out_320182.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play320182047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 320182047
		arg_194_1.duration_ = 11.97

		local var_194_0 = {
			zh = 11.966,
			ja = 9.1
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play320182048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if arg_194_1.bgs_.XS0201 == nil then
				local var_197_0 = Object.Instantiate(arg_194_1.paintGo_)

				var_197_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XS0201")
				var_197_0.name = "XS0201"
				var_197_0.transform.parent = arg_194_1.stage_.transform
				var_197_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.bgs_.XS0201 = var_197_0
			end

			if 1.06666666666667 < arg_194_1.time_ and arg_194_1.time_ <= 1.06666666666667 + arg_197_0 then
				local var_197_1 = arg_194_1.bgs_.XS0201

				arg_194_1.bgs_.XS0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_197_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_2 = var_197_1:GetComponent("SpriteRenderer")

				if var_197_2 and var_197_2.sprite then
					local var_197_3 = 2 * (var_197_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_197_1.transform.localScale = Vector3.New(var_197_3 / var_197_2.sprite.bounds.size.y < var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x and var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x or var_197_3 / var_197_2.sprite.bounds.size.y, var_197_3 / var_197_2.sprite.bounds.size.y < var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x and var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x or var_197_3 / var_197_2.sprite.bounds.size.y, 0)
				end

				for iter_197_0, iter_197_1 in pairs(arg_194_1.bgs_) do
					if iter_197_0 ~= "XS0201" then
						iter_197_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_197_4 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= var_197_4 + 0.3 and arg_194_1.time_ < var_197_4 + 0.3 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			local var_197_5 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_6 = 1.1

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_6 then
				local var_197_7 = Color.New(0, 0, 0)

				var_197_7.a = Mathf.Lerp(0, 1, (arg_194_1.time_ - var_197_5) / var_197_6)
				arg_194_1.mask_.color = var_197_7
			end

			if arg_194_1.time_ >= var_197_5 + var_197_6 and arg_194_1.time_ < var_197_5 + var_197_6 + arg_197_0 then
				local var_197_8 = Color.New(0, 0, 0)

				var_197_8.a = 1
				arg_194_1.mask_.color = var_197_8
			end

			local var_197_9 = 1.1

			if 1.1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_10 = 1.06666666666667

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_10 then
				local var_197_11 = Color.New(0, 0, 0)

				var_197_11.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_9) / var_197_10)
				arg_194_1.mask_.color = var_197_11
			end

			if arg_194_1.time_ >= var_197_9 + var_197_10 and arg_194_1.time_ < var_197_9 + var_197_10 + arg_197_0 then
				local var_197_12 = Color.New(0, 0, 0)

				arg_194_1.mask_.enabled = false
				var_197_12.a = 0
				arg_194_1.mask_.color = var_197_12
			end

			local var_197_13 = arg_194_1.actors_["1089ui_story"].transform

			if 1.06666666666667 < arg_194_1.time_ and arg_194_1.time_ <= 1.06666666666667 + arg_197_0 then
				arg_194_1.var_.moveOldPos1089ui_story = var_197_13.localPosition
			end

			local var_197_14 = 0.001

			if 1.06666666666667 <= arg_194_1.time_ and arg_194_1.time_ < 1.06666666666667 + var_197_14 then
				var_197_13.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 1.06666666666667) / var_197_14)
				var_197_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_13.position).x, (manager.ui.mainCamera.transform.position - var_197_13.position).y, (manager.ui.mainCamera.transform.position - var_197_13.position).z)
				var_197_13.localEulerAngles.z = 0
				var_197_13.localEulerAngles.x = 0
				var_197_13.localEulerAngles = var_197_13.localEulerAngles
			end

			if arg_194_1.time_ >= 1.06666666666667 + var_197_14 and arg_194_1.time_ < 1.06666666666667 + var_197_14 + arg_197_0 then
				var_197_13.localPosition = Vector3.New(0, 100, 0)
				var_197_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_13.position).x, (manager.ui.mainCamera.transform.position - var_197_13.position).y, (manager.ui.mainCamera.transform.position - var_197_13.position).z)
				var_197_13.localEulerAngles.z = 0
				var_197_13.localEulerAngles.x = 0
				var_197_13.localEulerAngles = var_197_13.localEulerAngles
			end

			local var_197_15 = arg_194_1.actors_["1089ui_story"]

			if 1.06666666666667 < arg_194_1.time_ and arg_194_1.time_ <= 1.06666666666667 + arg_197_0 and not isNil(var_197_15) and arg_194_1.var_.characterEffect1089ui_story == nil then
				arg_194_1.var_.characterEffect1089ui_story = var_197_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_16 = 0.200000002980232

			if 1.06666666666667 <= arg_194_1.time_ and arg_194_1.time_ < 1.06666666666667 + var_197_16 and not isNil(var_197_15) then
				if arg_194_1.var_.characterEffect1089ui_story and not isNil(var_197_15) then
					arg_194_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 1.06666666666667) / var_197_16)
				end
			end

			if arg_194_1.time_ >= 1.06666666666667 + var_197_16 and arg_194_1.time_ < 1.06666666666667 + var_197_16 + arg_197_0 and not isNil(var_197_15) and arg_194_1.var_.characterEffect1089ui_story then
				arg_194_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_197_17 = arg_194_1.bgs_.XS0201.transform

			if 1.10066666851441 < arg_194_1.time_ and arg_194_1.time_ <= 1.10066666851441 + arg_197_0 then
				arg_194_1.var_.moveOldPosXS0201 = var_197_17.localPosition
			end

			local var_197_18 = 0.001

			if 1.10066666851441 <= arg_194_1.time_ and arg_194_1.time_ < 1.10066666851441 + var_197_18 then
				var_197_17.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPosXS0201, Vector3.New(-3.45, 0.93, 2.45), (arg_194_1.time_ - 1.10066666851441) / var_197_18)
			end

			if arg_194_1.time_ >= 1.10066666851441 + var_197_18 and arg_194_1.time_ < 1.10066666851441 + var_197_18 + arg_197_0 then
				var_197_17.localPosition = Vector3.New(-3.45, 0.93, 2.45)
			end

			local var_197_19 = arg_194_1.bgs_.XS0201.transform

			if 1.13400000184774 < arg_194_1.time_ and arg_194_1.time_ <= 1.13400000184774 + arg_197_0 then
				arg_194_1.var_.moveOldPosXS0201 = var_197_19.localPosition
			end

			local var_197_20 = 3.2

			if 1.13400000184774 <= arg_194_1.time_ and arg_194_1.time_ < 1.13400000184774 + var_197_20 then
				var_197_19.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPosXS0201, Vector3.New(-3.47, -0.15, 2.67), (arg_194_1.time_ - 1.13400000184774) / var_197_20)
			end

			if arg_194_1.time_ >= 1.13400000184774 + var_197_20 and arg_194_1.time_ < 1.13400000184774 + var_197_20 + arg_197_0 then
				var_197_19.localPosition = Vector3.New(-3.47, -0.15, 2.67)
			end

			local var_197_21 = 1.1

			if 1.1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= var_197_21 + 2.35 and arg_194_1.time_ < var_197_21 + 2.35 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_197_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_194_1.bgmTxt_.text ~= var_197_24 and arg_194_1.bgmTxt_.text ~= "" then
						if arg_194_1.bgmTxt2_.text ~= "" then
							arg_194_1.bgmTxt_.text = arg_194_1.bgmTxt2_.text
						end

						arg_194_1.bgmTxt2_.text = var_197_24

						arg_194_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_194_1.bgmTxt_.text = var_197_24
						arg_194_1.bgmTxt2_.text = var_197_24
					end

					if arg_194_1.bgmTimer then
						arg_194_1.bgmTimer:Stop()

						arg_194_1.bgmTimer = nil
					end

					if arg_194_1.settingData.show_music_name == 1 then
						arg_194_1.musicController:SetSelectedState("show")
						arg_194_1.musicAnimator_:Play("open", 0, 0)

						if arg_194_1.settingData.music_time ~= 0 then
							arg_194_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_194_1.settingData.music_time), function()
								if arg_194_1 == nil or isNil(arg_194_1.bgmTxt_) then
									return
								end

								arg_194_1.musicController:SetSelectedState("hide")
								arg_194_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.733333333333333 < arg_194_1.time_ and arg_194_1.time_ <= 0.733333333333333 + arg_197_0 then
				arg_194_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_197_27 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_194_1.bgmTxt_.text ~= var_197_27 and arg_194_1.bgmTxt_.text ~= "" then
						if arg_194_1.bgmTxt2_.text ~= "" then
							arg_194_1.bgmTxt_.text = arg_194_1.bgmTxt2_.text
						end

						arg_194_1.bgmTxt2_.text = var_197_27

						arg_194_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_194_1.bgmTxt_.text = var_197_27
						arg_194_1.bgmTxt2_.text = var_197_27
					end

					if arg_194_1.bgmTimer then
						arg_194_1.bgmTimer:Stop()

						arg_194_1.bgmTimer = nil
					end

					if arg_194_1.settingData.show_music_name == 1 then
						arg_194_1.musicController:SetSelectedState("show")
						arg_194_1.musicAnimator_:Play("open", 0, 0)

						if arg_194_1.settingData.music_time ~= 0 then
							arg_194_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_194_1.settingData.music_time), function()
								if arg_194_1 == nil or isNil(arg_194_1.bgmTxt_) then
									return
								end

								arg_194_1.musicController:SetSelectedState("hide")
								arg_194_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_28 = 2.8
			local var_197_29 = 0.65

			if 2.8 < arg_194_1.time_ and arg_194_1.time_ <= var_197_28 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_30 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_30:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_194_1.dialogCg_.alpha = arg_200_0
				end))
				var_197_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_31 = arg_194_1:GetWordFromCfg(320182047)
				local var_197_32 = arg_194_1:FormatText(var_197_31.content)

				arg_194_1.text_.text = var_197_32

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_34 = 26 <= 0 and var_197_29 or var_197_29 * (utf8.len(var_197_32) / 26)

				if (26 <= 0 and var_197_29 or var_197_29 * (utf8.len(var_197_32) / 26)) > 0 and var_197_29 < var_197_34 then
					arg_194_1.talkMaxDuration = var_197_34
					var_197_28 = var_197_28 + 0.3

					if var_197_34 + var_197_28 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_34 + var_197_28
					end
				end

				arg_194_1.text_.text = var_197_32
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182047", "story_v_out_320182.awb") ~= 0 then
					local var_197_35 = manager.audio:GetVoiceLength("story_v_out_320182", "320182047", "story_v_out_320182.awb") / 1000

					if var_197_35 + var_197_28 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_35 + var_197_28
					end

					if var_197_31.prefab_name ~= "" and arg_194_1.actors_[var_197_31.prefab_name] ~= nil then
						local var_197_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_31.prefab_name].transform, "story_v_out_320182", "320182047", "story_v_out_320182.awb")

						arg_194_1:RecordAudio("320182047", var_197_36)
						arg_194_1:RecordAudio("320182047", var_197_36)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_320182", "320182047", "story_v_out_320182.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_320182", "320182047", "story_v_out_320182.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_37 = var_197_28 + 0.3
			local var_197_38 = math.max(var_197_29, arg_194_1.talkMaxDuration)

			if var_197_28 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_37 + var_197_38 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_37) / var_197_38

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_37 + var_197_38 and arg_194_1.time_ < var_197_37 + var_197_38 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XS0201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.10066666851441,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.2,
				className = "StoryMoveNode",
				startTime = 1.13400000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play320182048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 320182048
		arg_202_1.duration_ = 9.47

		local var_202_0 = {
			zh = 7.966,
			ja = 9.466
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play320182049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.725

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:GetWordFromCfg(320182048)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 29 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 29)

				if (29 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 29)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182048", "story_v_out_320182.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182048", "story_v_out_320182.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_320182", "320182048", "story_v_out_320182.awb")

						arg_202_1:RecordAudio("320182048", var_205_6)
						arg_202_1:RecordAudio("320182048", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_320182", "320182048", "story_v_out_320182.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_320182", "320182048", "story_v_out_320182.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play320182049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 320182049
		arg_206_1.duration_ = 3.8

		local var_206_0 = {
			zh = 3.233,
			ja = 3.8
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play320182050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.375

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:GetWordFromCfg(320182049)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 15 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 15)

				if (15 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 15)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182049", "story_v_out_320182.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182049", "story_v_out_320182.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_320182", "320182049", "story_v_out_320182.awb")

						arg_206_1:RecordAudio("320182049", var_209_6)
						arg_206_1:RecordAudio("320182049", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_320182", "320182049", "story_v_out_320182.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_320182", "320182049", "story_v_out_320182.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play320182050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 320182050
		arg_210_1.duration_ = 5.53

		local var_210_0 = {
			zh = 5.533,
			ja = 2.966
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play320182051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.275

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(320182050)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 11 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 11)

				if (11 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 11)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182050", "story_v_out_320182.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182050", "story_v_out_320182.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_320182", "320182050", "story_v_out_320182.awb")

						arg_210_1:RecordAudio("320182050", var_213_6)
						arg_210_1:RecordAudio("320182050", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_320182", "320182050", "story_v_out_320182.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_320182", "320182050", "story_v_out_320182.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play320182051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 320182051
		arg_214_1.duration_ = 6.77

		local var_214_0 = {
			zh = 6.766,
			ja = 3.7
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play320182052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.575

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:GetWordFromCfg(320182051)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 23 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 23)

				if (23 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 23)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182051", "story_v_out_320182.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182051", "story_v_out_320182.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_320182", "320182051", "story_v_out_320182.awb")

						arg_214_1:RecordAudio("320182051", var_217_6)
						arg_214_1:RecordAudio("320182051", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_320182", "320182051", "story_v_out_320182.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_320182", "320182051", "story_v_out_320182.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play320182052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 320182052
		arg_218_1.duration_ = 6.97

		local var_218_0 = {
			zh = 5.233,
			ja = 6.966
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play320182053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.525

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:GetWordFromCfg(320182052)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 21 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 21)

				if (21 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 21)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182052", "story_v_out_320182.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182052", "story_v_out_320182.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_320182", "320182052", "story_v_out_320182.awb")

						arg_218_1:RecordAudio("320182052", var_221_6)
						arg_218_1:RecordAudio("320182052", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_320182", "320182052", "story_v_out_320182.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_320182", "320182052", "story_v_out_320182.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play320182053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 320182053
		arg_222_1.duration_ = 15.57

		local var_222_0 = {
			zh = 15.566,
			ja = 13.333
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play320182054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_0 = 1.9

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				local var_225_1 = Color.New(0, 0, 0)

				var_225_1.a = Mathf.Lerp(1, 0, (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.mask_.color = var_225_1
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				local var_225_2 = Color.New(0, 0, 0)

				arg_222_1.mask_.enabled = false
				var_225_2.a = 0
				arg_222_1.mask_.color = var_225_2
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				local var_225_3 = arg_222_1.bgs_.XS0201

				arg_222_1.bgs_.XS0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_225_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_4 = var_225_3:GetComponent("SpriteRenderer")

				if var_225_4 and var_225_4.sprite then
					local var_225_5 = 2 * (var_225_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_225_3.transform.localScale = Vector3.New(var_225_5 / var_225_4.sprite.bounds.size.y < var_225_5 * manager.ui.mainCameraCom_.aspect / var_225_4.sprite.bounds.size.x and var_225_5 * manager.ui.mainCameraCom_.aspect / var_225_4.sprite.bounds.size.x or var_225_5 / var_225_4.sprite.bounds.size.y, var_225_5 / var_225_4.sprite.bounds.size.y < var_225_5 * manager.ui.mainCameraCom_.aspect / var_225_4.sprite.bounds.size.x and var_225_5 * manager.ui.mainCameraCom_.aspect / var_225_4.sprite.bounds.size.x or var_225_5 / var_225_4.sprite.bounds.size.y, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "XS0201" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_6 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= var_225_6 + 1.63333333333333 and arg_222_1.time_ < var_225_6 + 1.63333333333333 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_7 = 1.8
			local var_225_8 = 1.25

			if 1.8 < arg_222_1.time_ and arg_222_1.time_ <= var_225_7 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_9 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_9:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_10 = arg_222_1:GetWordFromCfg(320182053)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 50 <= 0 and var_225_8 or var_225_8 * (utf8.len(var_225_11) / 50)

				if (50 <= 0 and var_225_8 or var_225_8 * (utf8.len(var_225_11) / 50)) > 0 and var_225_8 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13
					var_225_7 = var_225_7 + 0.3

					if var_225_13 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_7
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182053", "story_v_out_320182.awb") ~= 0 then
					local var_225_14 = manager.audio:GetVoiceLength("story_v_out_320182", "320182053", "story_v_out_320182.awb") / 1000

					if var_225_14 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_7
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_320182", "320182053", "story_v_out_320182.awb")

						arg_222_1:RecordAudio("320182053", var_225_15)
						arg_222_1:RecordAudio("320182053", var_225_15)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_320182", "320182053", "story_v_out_320182.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_320182", "320182053", "story_v_out_320182.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = var_225_7 + 0.3
			local var_225_17 = math.max(var_225_8, arg_222_1.talkMaxDuration)

			if var_225_7 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_17 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_16) / var_225_17

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_16 + var_225_17 and arg_222_1.time_ < var_225_16 + var_225_17 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play320182054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 320182054
		arg_228_1.duration_ = 6.4

		local var_228_0 = {
			zh = 4.766,
			ja = 6.4
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play320182055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.45

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:GetWordFromCfg(320182054)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 18 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 18)

				if (18 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 18)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182054", "story_v_out_320182.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182054", "story_v_out_320182.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_320182", "320182054", "story_v_out_320182.awb")

						arg_228_1:RecordAudio("320182054", var_231_6)
						arg_228_1:RecordAudio("320182054", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_320182", "320182054", "story_v_out_320182.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_320182", "320182054", "story_v_out_320182.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play320182055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 320182055
		arg_232_1.duration_ = 1

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"

			SetActive(arg_232_1.choicesGo_, true)

			for iter_233_0, iter_233_1 in ipairs(arg_232_1.choices_) do
				SetActive(iter_233_1.go, iter_233_0 <= 1)
			end

			arg_232_1.choices_[1].txt.text = arg_232_1:FormatText(StoryChoiceCfg[1042].name)
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play320182056(arg_232_1)
			end

			arg_232_1:RecordChoiceLog(320182055, 1042)
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			return
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play320182056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 320182056
		arg_236_1.duration_ = 13.47

		local var_236_0 = {
			zh = 8.033,
			ja = 13.466
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play320182057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 1.025

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:GetWordFromCfg(320182056)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 41 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 41)

				if (41 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 41)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182056", "story_v_out_320182.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182056", "story_v_out_320182.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_320182", "320182056", "story_v_out_320182.awb")

						arg_236_1:RecordAudio("320182056", var_239_6)
						arg_236_1:RecordAudio("320182056", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_320182", "320182056", "story_v_out_320182.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_320182", "320182056", "story_v_out_320182.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play320182057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 320182057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play320182058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.825

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(320182057).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 33 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 33)

				if (33 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 33)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play320182058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 320182058
		arg_244_1.duration_ = 12.43

		local var_244_0 = {
			zh = 9.966,
			ja = 12.433
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play320182059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 1.15

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:GetWordFromCfg(320182058)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 46 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 46)

				if (46 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 46)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182058", "story_v_out_320182.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182058", "story_v_out_320182.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_320182", "320182058", "story_v_out_320182.awb")

						arg_244_1:RecordAudio("320182058", var_247_6)
						arg_244_1:RecordAudio("320182058", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_320182", "320182058", "story_v_out_320182.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_320182", "320182058", "story_v_out_320182.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play320182059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 320182059
		arg_248_1.duration_ = 11.67

		local var_248_0 = {
			zh = 7.5,
			ja = 11.666
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play320182060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:GetWordFromCfg(320182059)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 40 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 40)

				if (40 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 40)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182059", "story_v_out_320182.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182059", "story_v_out_320182.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_320182", "320182059", "story_v_out_320182.awb")

						arg_248_1:RecordAudio("320182059", var_251_6)
						arg_248_1:RecordAudio("320182059", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_320182", "320182059", "story_v_out_320182.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_320182", "320182059", "story_v_out_320182.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play320182060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 320182060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play320182061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.6

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(320182060).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 24 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 24)

				if (24 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 24)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play320182061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 320182061
		arg_256_1.duration_ = 12.8

		local var_256_0 = {
			zh = 7.466,
			ja = 12.8
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play320182062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.725

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:GetWordFromCfg(320182061)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 29 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 29)

				if (29 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 29)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182061", "story_v_out_320182.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182061", "story_v_out_320182.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_320182", "320182061", "story_v_out_320182.awb")

						arg_256_1:RecordAudio("320182061", var_259_6)
						arg_256_1:RecordAudio("320182061", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_320182", "320182061", "story_v_out_320182.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_320182", "320182061", "story_v_out_320182.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play320182062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 320182062
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play320182063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.375

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(320182062).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 15 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 15)

				if (15 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 15)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play320182063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 320182063
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play320182064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 1.325

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(320182063).content)

				arg_264_1.text_.text = var_267_1

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_3 = 53 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 53)

				if (53 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 53)) > 0 and var_267_0 < var_267_3 then
					arg_264_1.talkMaxDuration = var_267_3

					if var_267_3 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_3 + 0
					end
				end

				arg_264_1.text_.text = var_267_1
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_4 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_4

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play320182064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 320182064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play320182065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1.075

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(320182064).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 43 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 43)

				if (43 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 43)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play320182065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 320182065
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play320182066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.175

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(320182065).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 7 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 7)

				if (7 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 7)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play320182066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 320182066
		arg_276_1.duration_ = 10.53

		local var_276_0 = {
			zh = 7.39933333333333,
			ja = 10.5333333333333
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play320182067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if arg_276_1.bgs_.ST0503 == nil then
				local var_279_0 = Object.Instantiate(arg_276_1.paintGo_)

				var_279_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0503")
				var_279_0.name = "ST0503"
				var_279_0.transform.parent = arg_276_1.stage_.transform
				var_279_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_276_1.bgs_.ST0503 = var_279_0
			end

			if 2 < arg_276_1.time_ and arg_276_1.time_ <= 2 + arg_279_0 then
				local var_279_1 = arg_276_1.bgs_.ST0503

				arg_276_1.bgs_.ST0503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_279_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_2 = var_279_1:GetComponent("SpriteRenderer")

				if var_279_2 and var_279_2.sprite then
					local var_279_3 = 2 * (var_279_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_279_1.transform.localScale = Vector3.New(var_279_3 / var_279_2.sprite.bounds.size.y < var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x and var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x or var_279_3 / var_279_2.sprite.bounds.size.y, var_279_3 / var_279_2.sprite.bounds.size.y < var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x and var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x or var_279_3 / var_279_2.sprite.bounds.size.y, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "ST0503" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_279_4 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.allBtn_.enabled = false
			end

			if arg_276_1.time_ >= var_279_4 + 0.3 and arg_276_1.time_ < var_279_4 + 0.3 + arg_279_0 then
				arg_276_1.allBtn_.enabled = true
			end

			local var_279_5 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_6 = 2

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_6 then
				local var_279_7 = Color.New(0, 0, 0)

				var_279_7.a = Mathf.Lerp(0, 1, (arg_276_1.time_ - var_279_5) / var_279_6)
				arg_276_1.mask_.color = var_279_7
			end

			if arg_276_1.time_ >= var_279_5 + var_279_6 and arg_276_1.time_ < var_279_5 + var_279_6 + arg_279_0 then
				local var_279_8 = Color.New(0, 0, 0)

				var_279_8.a = 1
				arg_276_1.mask_.color = var_279_8
			end

			local var_279_9 = 2

			if 2 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_10 = 2

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_10 then
				local var_279_11 = Color.New(0, 0, 0)

				var_279_11.a = Mathf.Lerp(1, 0, (arg_276_1.time_ - var_279_9) / var_279_10)
				arg_276_1.mask_.color = var_279_11
			end

			if arg_276_1.time_ >= var_279_9 + var_279_10 and arg_276_1.time_ < var_279_9 + var_279_10 + arg_279_0 then
				local var_279_12 = Color.New(0, 0, 0)

				arg_276_1.mask_.enabled = false
				var_279_12.a = 0
				arg_276_1.mask_.color = var_279_12
			end

			local var_279_13 = "10100ui_story"

			if arg_276_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_279_14 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_276_1.stage_.transform)

				var_279_14.name = var_279_13
				var_279_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_276_1.actors_[var_279_13] = var_279_14

				local var_279_15 = var_279_14:GetComponentInChildren(typeof(CharacterEffect))

				var_279_15.enabled = true

				local var_279_16 = GameObjectTools.GetOrAddComponent(var_279_14, typeof(DynamicBoneHelper))

				if var_279_16 then
					var_279_16:EnableDynamicBone(false)
				end

				arg_276_1:ShowWeapon(var_279_15.transform, false)

				arg_276_1.var_[var_279_13 .. "Animator"] = var_279_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_276_1.var_[var_279_13 .. "Animator"].applyRootMotion = true
				arg_276_1.var_[var_279_13 .. "LipSync"] = var_279_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_279_17 = arg_276_1.actors_["10100ui_story"].transform

			if 3.83333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 3.83333333333333 + arg_279_0 then
				arg_276_1.var_.moveOldPos10100ui_story = var_279_17.localPosition
			end

			local var_279_18 = 0.001

			if 3.83333333333333 <= arg_276_1.time_ and arg_276_1.time_ < 3.83333333333333 + var_279_18 then
				var_279_17.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_276_1.time_ - 3.83333333333333) / var_279_18)
				var_279_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_279_17.position).x, (manager.ui.mainCamera.transform.position - var_279_17.position).y, (manager.ui.mainCamera.transform.position - var_279_17.position).z)
				var_279_17.localEulerAngles.z = 0
				var_279_17.localEulerAngles.x = 0
				var_279_17.localEulerAngles = var_279_17.localEulerAngles
			end

			if arg_276_1.time_ >= 3.83333333333333 + var_279_18 and arg_276_1.time_ < 3.83333333333333 + var_279_18 + arg_279_0 then
				var_279_17.localPosition = Vector3.New(0, -1.16, -6.25)
				var_279_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_279_17.position).x, (manager.ui.mainCamera.transform.position - var_279_17.position).y, (manager.ui.mainCamera.transform.position - var_279_17.position).z)
				var_279_17.localEulerAngles.z = 0
				var_279_17.localEulerAngles.x = 0
				var_279_17.localEulerAngles = var_279_17.localEulerAngles
			end

			local var_279_19 = arg_276_1.actors_["10100ui_story"]

			if 3.83333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 3.83333333333333 + arg_279_0 and not isNil(var_279_19) and arg_276_1.var_.characterEffect10100ui_story == nil then
				arg_276_1.var_.characterEffect10100ui_story = var_279_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_20 = 0.200000002980232

			if 3.83333333333333 <= arg_276_1.time_ and arg_276_1.time_ < 3.83333333333333 + var_279_20 and not isNil(var_279_19) then
				if arg_276_1.var_.characterEffect10100ui_story and not isNil(var_279_19) then
					arg_276_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 3.83333333333333 + var_279_20 and arg_276_1.time_ < 3.83333333333333 + var_279_20 + arg_279_0 and not isNil(var_279_19) and arg_276_1.var_.characterEffect10100ui_story then
				arg_276_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 3.83333333333333 + arg_279_0 then
				arg_276_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action2_1")
			end

			if 3.83333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 3.83333333333333 + arg_279_0 then
				arg_276_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_22 = 3.83333333333333
			local var_279_23 = 0.425

			if 3.83333333333333 < arg_276_1.time_ and arg_276_1.time_ <= var_279_22 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_24 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_24:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_25 = arg_276_1:GetWordFromCfg(320182066)
				local var_279_26 = arg_276_1:FormatText(var_279_25.content)

				arg_276_1.text_.text = var_279_26

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_28 = 17 <= 0 and var_279_23 or var_279_23 * (utf8.len(var_279_26) / 17)

				if (17 <= 0 and var_279_23 or var_279_23 * (utf8.len(var_279_26) / 17)) > 0 and var_279_23 < var_279_28 then
					arg_276_1.talkMaxDuration = var_279_28
					var_279_22 = var_279_22 + 0.3

					if var_279_28 + var_279_22 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_28 + var_279_22
					end
				end

				arg_276_1.text_.text = var_279_26
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182066", "story_v_out_320182.awb") ~= 0 then
					local var_279_29 = manager.audio:GetVoiceLength("story_v_out_320182", "320182066", "story_v_out_320182.awb") / 1000

					if var_279_29 + var_279_22 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_29 + var_279_22
					end

					if var_279_25.prefab_name ~= "" and arg_276_1.actors_[var_279_25.prefab_name] ~= nil then
						local var_279_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_25.prefab_name].transform, "story_v_out_320182", "320182066", "story_v_out_320182.awb")

						arg_276_1:RecordAudio("320182066", var_279_30)
						arg_276_1:RecordAudio("320182066", var_279_30)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_320182", "320182066", "story_v_out_320182.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_320182", "320182066", "story_v_out_320182.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_31 = var_279_22 + 0.3
			local var_279_32 = math.max(var_279_23, arg_276_1.talkMaxDuration)

			if var_279_22 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_31 + var_279_32 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_31) / var_279_32

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_31 + var_279_32 and arg_276_1.time_ < var_279_31 + var_279_32 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play320182067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 320182067
		arg_282_1.duration_ = 8.4

		local var_282_0 = {
			zh = 6.733,
			ja = 8.4
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play320182068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10100ui_story = arg_282_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10100ui_story"].transform.position).z)
				arg_282_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["10100ui_story"].transform.localEulerAngles = arg_282_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10100ui_story"].transform.position).z)
				arg_282_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["10100ui_story"].transform.localEulerAngles = arg_282_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_285_1 = "10102ui_story"

			if arg_282_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_285_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_282_1.stage_.transform)

				var_285_2.name = var_285_1
				var_285_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.actors_[var_285_1] = var_285_2

				local var_285_3 = var_285_2:GetComponentInChildren(typeof(CharacterEffect))

				var_285_3.enabled = true

				local var_285_4 = GameObjectTools.GetOrAddComponent(var_285_2, typeof(DynamicBoneHelper))

				if var_285_4 then
					var_285_4:EnableDynamicBone(false)
				end

				arg_282_1:ShowWeapon(var_285_3.transform, false)

				arg_282_1.var_[var_285_1 .. "Animator"] = var_285_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_282_1.var_[var_285_1 .. "Animator"].applyRootMotion = true
				arg_282_1.var_[var_285_1 .. "LipSync"] = var_285_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_285_5 = arg_282_1.actors_["10102ui_story"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10102ui_story = var_285_5.localPosition
			end

			local var_285_6 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_6 then
				var_285_5.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_282_1.time_ - 0) / var_285_6)
				var_285_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_5.position).x, (manager.ui.mainCamera.transform.position - var_285_5.position).y, (manager.ui.mainCamera.transform.position - var_285_5.position).z)
				var_285_5.localEulerAngles.z = 0
				var_285_5.localEulerAngles.x = 0
				var_285_5.localEulerAngles = var_285_5.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_6 and arg_282_1.time_ < 0 + var_285_6 + arg_285_0 then
				var_285_5.localPosition = Vector3.New(0, -0.985, -6.275)
				var_285_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_5.position).x, (manager.ui.mainCamera.transform.position - var_285_5.position).y, (manager.ui.mainCamera.transform.position - var_285_5.position).z)
				var_285_5.localEulerAngles.z = 0
				var_285_5.localEulerAngles.x = 0
				var_285_5.localEulerAngles = var_285_5.localEulerAngles
			end

			local var_285_7 = arg_282_1.actors_["10102ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.characterEffect10102ui_story == nil then
				arg_282_1.var_.characterEffect10102ui_story = var_285_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_8 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_8 and not isNil(var_285_7) then
				if arg_282_1.var_.characterEffect10102ui_story and not isNil(var_285_7) then
					arg_282_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_8 and arg_282_1.time_ < 0 + var_285_8 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.characterEffect10102ui_story then
				arg_282_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action9_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_285_10 = 0
			local var_285_11 = 0.525

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_12 = arg_282_1:GetWordFromCfg(320182067)
				local var_285_13 = arg_282_1:FormatText(var_285_12.content)

				arg_282_1.text_.text = var_285_13

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_15 = 21 <= 0 and var_285_11 or var_285_11 * (utf8.len(var_285_13) / 21)

				if (21 <= 0 and var_285_11 or var_285_11 * (utf8.len(var_285_13) / 21)) > 0 and var_285_11 < var_285_15 then
					arg_282_1.talkMaxDuration = var_285_15

					if var_285_15 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_15 + var_285_10
					end
				end

				arg_282_1.text_.text = var_285_13
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182067", "story_v_out_320182.awb") ~= 0 then
					local var_285_16 = manager.audio:GetVoiceLength("story_v_out_320182", "320182067", "story_v_out_320182.awb") / 1000

					if var_285_16 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_16 + var_285_10
					end

					if var_285_12.prefab_name ~= "" and arg_282_1.actors_[var_285_12.prefab_name] ~= nil then
						local var_285_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_12.prefab_name].transform, "story_v_out_320182", "320182067", "story_v_out_320182.awb")

						arg_282_1:RecordAudio("320182067", var_285_17)
						arg_282_1:RecordAudio("320182067", var_285_17)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_320182", "320182067", "story_v_out_320182.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_320182", "320182067", "story_v_out_320182.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_18 = math.max(var_285_11, arg_282_1.talkMaxDuration)

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_18 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_10) / var_285_18

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_10 + var_285_18 and arg_282_1.time_ < var_285_10 + var_285_18 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play320182068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 320182068
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play320182069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["10102ui_story"]) and arg_286_1.var_.characterEffect10102ui_story == nil then
				arg_286_1.var_.characterEffect10102ui_story = arg_286_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["10102ui_story"]) then
				if arg_286_1.var_.characterEffect10102ui_story and not isNil(arg_286_1.actors_["10102ui_story"]) then
					arg_286_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["10102ui_story"]) and arg_286_1.var_.characterEffect10102ui_story then
				arg_286_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 0.95

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(320182068).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 38 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 38)

				if (38 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 38)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play320182069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 320182069
		arg_290_1.duration_ = 4.8

		local var_290_0 = {
			zh = 2.5,
			ja = 4.8
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play320182070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["10102ui_story"]) and arg_290_1.var_.characterEffect10102ui_story == nil then
				arg_290_1.var_.characterEffect10102ui_story = arg_290_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["10102ui_story"]) then
				if arg_290_1.var_.characterEffect10102ui_story and not isNil(arg_290_1.actors_["10102ui_story"]) then
					arg_290_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["10102ui_story"]) and arg_290_1.var_.characterEffect10102ui_story then
				arg_290_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action9_2")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_293_2 = 0
			local var_293_3 = 0.3

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_4 = arg_290_1:GetWordFromCfg(320182069)
				local var_293_5 = arg_290_1:FormatText(var_293_4.content)

				arg_290_1.text_.text = var_293_5

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 12 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 12)

				if (12 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 12)) > 0 and var_293_3 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_5
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182069", "story_v_out_320182.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_320182", "320182069", "story_v_out_320182.awb") / 1000

					if var_293_8 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_2
					end

					if var_293_4.prefab_name ~= "" and arg_290_1.actors_[var_293_4.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_4.prefab_name].transform, "story_v_out_320182", "320182069", "story_v_out_320182.awb")

						arg_290_1:RecordAudio("320182069", var_293_9)
						arg_290_1:RecordAudio("320182069", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_320182", "320182069", "story_v_out_320182.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_320182", "320182069", "story_v_out_320182.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_10 and arg_290_1.time_ < var_293_2 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play320182070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 320182070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play320182071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos10102ui_story = arg_294_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10102ui_story"].transform.position).z)
				arg_294_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["10102ui_story"].transform.localEulerAngles = arg_294_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10102ui_story"].transform.position).z)
				arg_294_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["10102ui_story"].transform.localEulerAngles = arg_294_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_297_1 = 0
			local var_297_2 = 1.175

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(320182070).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 47 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 47)

				if (47 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 47)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play320182071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 320182071
		arg_298_1.duration_ = 7.43

		local var_298_0 = {
			zh = 6.333,
			ja = 7.433
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play320182072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.875

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:GetWordFromCfg(320182071)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 35 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 35)

				if (35 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 35)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182071", "story_v_out_320182.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182071", "story_v_out_320182.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_out_320182", "320182071", "story_v_out_320182.awb")

						arg_298_1:RecordAudio("320182071", var_301_6)
						arg_298_1:RecordAudio("320182071", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_320182", "320182071", "story_v_out_320182.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_320182", "320182071", "story_v_out_320182.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play320182072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 320182072
		arg_302_1.duration_ = 15.07

		local var_302_0 = {
			zh = 9.033,
			ja = 15.066
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play320182073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 1.15

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:GetWordFromCfg(320182072)
				local var_305_2 = arg_302_1:FormatText(var_305_1.content)

				arg_302_1.text_.text = var_305_2

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_4 = 46 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 46)

				if (46 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 46)) > 0 and var_305_0 < var_305_4 then
					arg_302_1.talkMaxDuration = var_305_4

					if var_305_4 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_4 + 0
					end
				end

				arg_302_1.text_.text = var_305_2
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182072", "story_v_out_320182.awb") ~= 0 then
					local var_305_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182072", "story_v_out_320182.awb") / 1000

					if var_305_5 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + 0
					end

					if var_305_1.prefab_name ~= "" and arg_302_1.actors_[var_305_1.prefab_name] ~= nil then
						local var_305_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_1.prefab_name].transform, "story_v_out_320182", "320182072", "story_v_out_320182.awb")

						arg_302_1:RecordAudio("320182072", var_305_6)
						arg_302_1:RecordAudio("320182072", var_305_6)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_320182", "320182072", "story_v_out_320182.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_320182", "320182072", "story_v_out_320182.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play320182073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 320182073
		arg_306_1.duration_ = 10.57

		local var_306_0 = {
			zh = 9.6,
			ja = 10.566
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play320182074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.175

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:GetWordFromCfg(320182073)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 47 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 47)

				if (47 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 47)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182073", "story_v_out_320182.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182073", "story_v_out_320182.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_320182", "320182073", "story_v_out_320182.awb")

						arg_306_1:RecordAudio("320182073", var_309_6)
						arg_306_1:RecordAudio("320182073", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_320182", "320182073", "story_v_out_320182.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_320182", "320182073", "story_v_out_320182.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play320182074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 320182074
		arg_310_1.duration_ = 6.63

		local var_310_0 = {
			zh = 6.633,
			ja = 5.4
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play320182075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10102ui_story = arg_310_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["10102ui_story"].transform.position).z)
				arg_310_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["10102ui_story"].transform.localEulerAngles = arg_310_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_310_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["10102ui_story"].transform.position).z)
				arg_310_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["10102ui_story"].transform.localEulerAngles = arg_310_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_313_1 = arg_310_1.actors_["10102ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect10102ui_story == nil then
				arg_310_1.var_.characterEffect10102ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_2 and not isNil(var_313_1) then
				if arg_310_1.var_.characterEffect10102ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_2 and arg_310_1.time_ < 0 + var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect10102ui_story then
				arg_310_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_313_4 = 0
			local var_313_5 = 0.775

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_6 = arg_310_1:GetWordFromCfg(320182074)
				local var_313_7 = arg_310_1:FormatText(var_313_6.content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 31 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 31)

				if (31 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 31)) > 0 and var_313_5 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182074", "story_v_out_320182.awb") ~= 0 then
					local var_313_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182074", "story_v_out_320182.awb") / 1000

					if var_313_10 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_4
					end

					if var_313_6.prefab_name ~= "" and arg_310_1.actors_[var_313_6.prefab_name] ~= nil then
						local var_313_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_6.prefab_name].transform, "story_v_out_320182", "320182074", "story_v_out_320182.awb")

						arg_310_1:RecordAudio("320182074", var_313_11)
						arg_310_1:RecordAudio("320182074", var_313_11)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_320182", "320182074", "story_v_out_320182.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_320182", "320182074", "story_v_out_320182.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_12 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_12 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_12

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_12 and arg_310_1.time_ < var_313_4 + var_313_12 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play320182075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 320182075
		arg_314_1.duration_ = 9

		local var_314_0 = {
			zh = 8.2,
			ja = 9
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play320182076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10102ui_story = arg_314_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_317_0 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 then
				arg_314_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_314_1.time_ - 0) / var_317_0)
				arg_314_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10102ui_story"].transform.position).z)
				arg_314_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10102ui_story"].transform.localEulerAngles = arg_314_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_314_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10102ui_story"].transform.position).z)
				arg_314_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10102ui_story"].transform.localEulerAngles = arg_314_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_317_1 = arg_314_1.actors_["10102ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect10102ui_story == nil then
				arg_314_1.var_.characterEffect10102ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_2 and not isNil(var_317_1) then
				if arg_314_1.var_.characterEffect10102ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_314_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_2)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_2 and arg_314_1.time_ < 0 + var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect10102ui_story then
				arg_314_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_314_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_317_3 = arg_314_1.actors_["10100ui_story"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10100ui_story = var_317_3.localPosition
			end

			local var_317_4 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				var_317_3.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_314_1.time_ - 0) / var_317_4)
				var_317_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_3.position).x, (manager.ui.mainCamera.transform.position - var_317_3.position).y, (manager.ui.mainCamera.transform.position - var_317_3.position).z)
				var_317_3.localEulerAngles.z = 0
				var_317_3.localEulerAngles.x = 0
				var_317_3.localEulerAngles = var_317_3.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				var_317_3.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				var_317_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_3.position).x, (manager.ui.mainCamera.transform.position - var_317_3.position).y, (manager.ui.mainCamera.transform.position - var_317_3.position).z)
				var_317_3.localEulerAngles.z = 0
				var_317_3.localEulerAngles.x = 0
				var_317_3.localEulerAngles = var_317_3.localEulerAngles
			end

			local var_317_5 = arg_314_1.actors_["10100ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_5) and arg_314_1.var_.characterEffect10100ui_story == nil then
				arg_314_1.var_.characterEffect10100ui_story = var_317_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_6 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_6 and not isNil(var_317_5) then
				if arg_314_1.var_.characterEffect10100ui_story and not isNil(var_317_5) then
					arg_314_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_6 and arg_314_1.time_ < 0 + var_317_6 + arg_317_0 and not isNil(var_317_5) and arg_314_1.var_.characterEffect10100ui_story then
				arg_314_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action2_2")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_317_8 = 0
			local var_317_9 = 1.175

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_8 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_10 = arg_314_1:GetWordFromCfg(320182075)
				local var_317_11 = arg_314_1:FormatText(var_317_10.content)

				arg_314_1.text_.text = var_317_11

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_13 = 47 <= 0 and var_317_9 or var_317_9 * (utf8.len(var_317_11) / 47)

				if (47 <= 0 and var_317_9 or var_317_9 * (utf8.len(var_317_11) / 47)) > 0 and var_317_9 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_8
					end
				end

				arg_314_1.text_.text = var_317_11
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182075", "story_v_out_320182.awb") ~= 0 then
					local var_317_14 = manager.audio:GetVoiceLength("story_v_out_320182", "320182075", "story_v_out_320182.awb") / 1000

					if var_317_14 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_8
					end

					if var_317_10.prefab_name ~= "" and arg_314_1.actors_[var_317_10.prefab_name] ~= nil then
						local var_317_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_10.prefab_name].transform, "story_v_out_320182", "320182075", "story_v_out_320182.awb")

						arg_314_1:RecordAudio("320182075", var_317_15)
						arg_314_1:RecordAudio("320182075", var_317_15)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_320182", "320182075", "story_v_out_320182.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_320182", "320182075", "story_v_out_320182.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_9, arg_314_1.talkMaxDuration)

			if var_317_8 <= arg_314_1.time_ and arg_314_1.time_ < var_317_8 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_8) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_8 + var_317_16 and arg_314_1.time_ < var_317_8 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play320182076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 320182076
		arg_318_1.duration_ = 8.6

		local var_318_0 = {
			zh = 8.6,
			ja = 7.666
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play320182077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["10100ui_story"]) and arg_318_1.var_.characterEffect10100ui_story == nil then
				arg_318_1.var_.characterEffect10100ui_story = arg_318_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["10100ui_story"]) then
				if arg_318_1.var_.characterEffect10100ui_story and not isNil(arg_318_1.actors_["10100ui_story"]) then
					arg_318_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_0)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["10100ui_story"]) and arg_318_1.var_.characterEffect10100ui_story then
				arg_318_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_321_1 = arg_318_1.actors_["10102ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect10102ui_story == nil then
				arg_318_1.var_.characterEffect10102ui_story = var_321_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_2 and not isNil(var_321_1) then
				if arg_318_1.var_.characterEffect10102ui_story and not isNil(var_321_1) then
					arg_318_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_2 and arg_318_1.time_ < 0 + var_321_2 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect10102ui_story then
				arg_318_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_321_4 = 0
			local var_321_5 = 0.825

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_6 = arg_318_1:GetWordFromCfg(320182076)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 33 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 33)

				if (33 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 33)) > 0 and var_321_5 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182076", "story_v_out_320182.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182076", "story_v_out_320182.awb") / 1000

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end

					if var_321_6.prefab_name ~= "" and arg_318_1.actors_[var_321_6.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_6.prefab_name].transform, "story_v_out_320182", "320182076", "story_v_out_320182.awb")

						arg_318_1:RecordAudio("320182076", var_321_11)
						arg_318_1:RecordAudio("320182076", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_320182", "320182076", "story_v_out_320182.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_320182", "320182076", "story_v_out_320182.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_12 and arg_318_1.time_ < var_321_4 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play320182077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 320182077
		arg_322_1.duration_ = 14.87

		local var_322_0 = {
			zh = 7.5,
			ja = 14.866
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play320182078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10100ui_story"]) and arg_322_1.var_.characterEffect10100ui_story == nil then
				arg_322_1.var_.characterEffect10100ui_story = arg_322_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10100ui_story"]) then
				if arg_322_1.var_.characterEffect10100ui_story and not isNil(arg_322_1.actors_["10100ui_story"]) then
					arg_322_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10100ui_story"]) and arg_322_1.var_.characterEffect10100ui_story then
				arg_322_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_325_2 = arg_322_1.actors_["10102ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.characterEffect10102ui_story == nil then
				arg_322_1.var_.characterEffect10102ui_story = var_325_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_3 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 and not isNil(var_325_2) then
				if arg_322_1.var_.characterEffect10102ui_story and not isNil(var_325_2) then
					arg_322_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_322_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_3)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.characterEffect10102ui_story then
				arg_322_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_322_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_325_4 = 0
			local var_325_5 = 1.125

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_6 = arg_322_1:GetWordFromCfg(320182077)
				local var_325_7 = arg_322_1:FormatText(var_325_6.content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 45 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 45)

				if (45 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 45)) > 0 and var_325_5 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182077", "story_v_out_320182.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182077", "story_v_out_320182.awb") / 1000

					if var_325_10 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_4
					end

					if var_325_6.prefab_name ~= "" and arg_322_1.actors_[var_325_6.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_6.prefab_name].transform, "story_v_out_320182", "320182077", "story_v_out_320182.awb")

						arg_322_1:RecordAudio("320182077", var_325_11)
						arg_322_1:RecordAudio("320182077", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_320182", "320182077", "story_v_out_320182.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_320182", "320182077", "story_v_out_320182.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_12 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 <= arg_322_1.time_ and arg_322_1.time_ < var_325_4 + var_325_12 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_4) / var_325_12

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_4 + var_325_12 and arg_322_1.time_ < var_325_4 + var_325_12 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play320182078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 320182078
		arg_326_1.duration_ = 16.1

		local var_326_0 = {
			zh = 7.633,
			ja = 16.1
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play320182079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 1.05

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:GetWordFromCfg(320182078)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 42 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 42)

				if (42 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 42)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182078", "story_v_out_320182.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182078", "story_v_out_320182.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_320182", "320182078", "story_v_out_320182.awb")

						arg_326_1:RecordAudio("320182078", var_329_6)
						arg_326_1:RecordAudio("320182078", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_320182", "320182078", "story_v_out_320182.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_320182", "320182078", "story_v_out_320182.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play320182079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 320182079
		arg_330_1.duration_ = 6.33

		local var_330_0 = {
			zh = 4.933,
			ja = 6.333
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play320182080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10100ui_story = arg_330_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10100ui_story"].transform.position).z)
				arg_330_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["10100ui_story"].transform.localEulerAngles = arg_330_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				arg_330_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10100ui_story"].transform.position).z)
				arg_330_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["10100ui_story"].transform.localEulerAngles = arg_330_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["10100ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect10100ui_story == nil then
				arg_330_1.var_.characterEffect10100ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect10100ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect10100ui_story then
				arg_330_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_333_4 = 0
			local var_333_5 = 0.75

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_6 = arg_330_1:GetWordFromCfg(320182079)
				local var_333_7 = arg_330_1:FormatText(var_333_6.content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 30 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 30)

				if (30 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 30)) > 0 and var_333_5 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182079", "story_v_out_320182.awb") ~= 0 then
					local var_333_10 = manager.audio:GetVoiceLength("story_v_out_320182", "320182079", "story_v_out_320182.awb") / 1000

					if var_333_10 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_4
					end

					if var_333_6.prefab_name ~= "" and arg_330_1.actors_[var_333_6.prefab_name] ~= nil then
						local var_333_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_6.prefab_name].transform, "story_v_out_320182", "320182079", "story_v_out_320182.awb")

						arg_330_1:RecordAudio("320182079", var_333_11)
						arg_330_1:RecordAudio("320182079", var_333_11)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_320182", "320182079", "story_v_out_320182.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_320182", "320182079", "story_v_out_320182.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_12 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_12 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_12

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_12 and arg_330_1.time_ < var_333_4 + var_333_12 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play320182080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 320182080
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play320182081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10100ui_story"]) and arg_334_1.var_.characterEffect10100ui_story == nil then
				arg_334_1.var_.characterEffect10100ui_story = arg_334_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10100ui_story"]) then
				if arg_334_1.var_.characterEffect10100ui_story and not isNil(arg_334_1.actors_["10100ui_story"]) then
					arg_334_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_334_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10100ui_story"]) and arg_334_1.var_.characterEffect10100ui_story then
				arg_334_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_334_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 0.6

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(320182080).content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 24 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 24)

				if (24 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 24)) > 0 and var_337_2 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_6 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_6 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_6

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_6 and arg_334_1.time_ < var_337_1 + var_337_6 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play320182081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 320182081
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play320182082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.7

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(320182081).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 28 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 28)

				if (28 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 28)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play320182082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 320182082
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play320182083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.1

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(320182082).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 4 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 4)

				if (4 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 4)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play320182083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 320182083
		arg_346_1.duration_ = 9.33

		local var_346_0 = {
			zh = 8.533,
			ja = 9.333
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play320182084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10100ui_story = arg_346_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10100ui_story"].transform.position).z)
				arg_346_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["10100ui_story"].transform.localEulerAngles = arg_346_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10100ui_story"].transform.position).z)
				arg_346_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["10100ui_story"].transform.localEulerAngles = arg_346_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["10102ui_story"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10102ui_story = var_349_1.localPosition
			end

			local var_349_2 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 then
				var_349_1.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_346_1.time_ - 0) / var_349_2)
				var_349_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_1.position).x, (manager.ui.mainCamera.transform.position - var_349_1.position).y, (manager.ui.mainCamera.transform.position - var_349_1.position).z)
				var_349_1.localEulerAngles.z = 0
				var_349_1.localEulerAngles.x = 0
				var_349_1.localEulerAngles = var_349_1.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 then
				var_349_1.localPosition = Vector3.New(0, 100, 0)
				var_349_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_1.position).x, (manager.ui.mainCamera.transform.position - var_349_1.position).y, (manager.ui.mainCamera.transform.position - var_349_1.position).z)
				var_349_1.localEulerAngles.z = 0
				var_349_1.localEulerAngles.x = 0
				var_349_1.localEulerAngles = var_349_1.localEulerAngles
			end

			local var_349_3 = "1011ui_story"

			if arg_346_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_349_4 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_346_1.stage_.transform)

				var_349_4.name = var_349_3
				var_349_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.actors_[var_349_3] = var_349_4

				local var_349_5 = var_349_4:GetComponentInChildren(typeof(CharacterEffect))

				var_349_5.enabled = true

				local var_349_6 = GameObjectTools.GetOrAddComponent(var_349_4, typeof(DynamicBoneHelper))

				if var_349_6 then
					var_349_6:EnableDynamicBone(false)
				end

				arg_346_1:ShowWeapon(var_349_5.transform, false)

				arg_346_1.var_[var_349_3 .. "Animator"] = var_349_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_346_1.var_[var_349_3 .. "Animator"].applyRootMotion = true
				arg_346_1.var_[var_349_3 .. "LipSync"] = var_349_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_349_7 = arg_346_1.actors_["1011ui_story"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1011ui_story = var_349_7.localPosition
			end

			local var_349_8 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_8 then
				var_349_7.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_346_1.time_ - 0) / var_349_8)
				var_349_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_7.position).x, (manager.ui.mainCamera.transform.position - var_349_7.position).y, (manager.ui.mainCamera.transform.position - var_349_7.position).z)
				var_349_7.localEulerAngles.z = 0
				var_349_7.localEulerAngles.x = 0
				var_349_7.localEulerAngles = var_349_7.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_8 and arg_346_1.time_ < 0 + var_349_8 + arg_349_0 then
				var_349_7.localPosition = Vector3.New(0, -0.71, -6)
				var_349_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_7.position).x, (manager.ui.mainCamera.transform.position - var_349_7.position).y, (manager.ui.mainCamera.transform.position - var_349_7.position).z)
				var_349_7.localEulerAngles.z = 0
				var_349_7.localEulerAngles.x = 0
				var_349_7.localEulerAngles = var_349_7.localEulerAngles
			end

			local var_349_9 = arg_346_1.actors_["1011ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_9) and arg_346_1.var_.characterEffect1011ui_story == nil then
				arg_346_1.var_.characterEffect1011ui_story = var_349_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_10 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_10 and not isNil(var_349_9) then
				if arg_346_1.var_.characterEffect1011ui_story and not isNil(var_349_9) then
					arg_346_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_10 and arg_346_1.time_ < 0 + var_349_10 + arg_349_0 and not isNil(var_349_9) and arg_346_1.var_.characterEffect1011ui_story then
				arg_346_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_349_12 = 0
			local var_349_13 = 0.575

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_12 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_14 = arg_346_1:GetWordFromCfg(320182083)
				local var_349_15 = arg_346_1:FormatText(var_349_14.content)

				arg_346_1.text_.text = var_349_15

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_17 = 23 <= 0 and var_349_13 or var_349_13 * (utf8.len(var_349_15) / 23)

				if (23 <= 0 and var_349_13 or var_349_13 * (utf8.len(var_349_15) / 23)) > 0 and var_349_13 < var_349_17 then
					arg_346_1.talkMaxDuration = var_349_17

					if var_349_17 + var_349_12 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_17 + var_349_12
					end
				end

				arg_346_1.text_.text = var_349_15
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182083", "story_v_out_320182.awb") ~= 0 then
					local var_349_18 = manager.audio:GetVoiceLength("story_v_out_320182", "320182083", "story_v_out_320182.awb") / 1000

					if var_349_18 + var_349_12 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_18 + var_349_12
					end

					if var_349_14.prefab_name ~= "" and arg_346_1.actors_[var_349_14.prefab_name] ~= nil then
						local var_349_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_14.prefab_name].transform, "story_v_out_320182", "320182083", "story_v_out_320182.awb")

						arg_346_1:RecordAudio("320182083", var_349_19)
						arg_346_1:RecordAudio("320182083", var_349_19)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_320182", "320182083", "story_v_out_320182.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_320182", "320182083", "story_v_out_320182.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_20 = math.max(var_349_13, arg_346_1.talkMaxDuration)

			if var_349_12 <= arg_346_1.time_ and arg_346_1.time_ < var_349_12 + var_349_20 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_12) / var_349_20

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_12 + var_349_20 and arg_346_1.time_ < var_349_12 + var_349_20 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play320182084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 320182084
		arg_350_1.duration_ = 1

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"

			SetActive(arg_350_1.choicesGo_, true)

			for iter_351_0, iter_351_1 in ipairs(arg_350_1.choices_) do
				SetActive(iter_351_1.go, iter_351_0 <= 3)
			end

			arg_350_1.choices_[1].txt.text = arg_350_1:FormatText(StoryChoiceCfg[1043].name)
			arg_350_1.choices_[2].txt.text = arg_350_1:FormatText(StoryChoiceCfg[1044].name)
			arg_350_1.choices_[3].txt.text = arg_350_1:FormatText(StoryChoiceCfg[1045].name)
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play320182085(arg_350_1)
			end

			if arg_352_0 == 2 then
				arg_350_0:Play320182085(arg_350_1)
			end

			if arg_352_0 == 3 then
				arg_350_0:Play320182085(arg_350_1)
			end

			arg_350_1:RecordChoiceLog(320182084, 1043, 1044, 1045)
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1011ui_story"]) and arg_350_1.var_.characterEffect1011ui_story == nil then
				arg_350_1.var_.characterEffect1011ui_story = arg_350_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1011ui_story"]) then
				if arg_350_1.var_.characterEffect1011ui_story and not isNil(arg_350_1.actors_["1011ui_story"]) then
					arg_350_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_0)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1011ui_story"]) and arg_350_1.var_.characterEffect1011ui_story then
				arg_350_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play320182085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 320182085
		arg_354_1.duration_ = 2

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play320182086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1011ui_story = arg_354_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1011ui_story"].transform.position).z)
				arg_354_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1011ui_story"].transform.localEulerAngles = arg_354_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_354_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1011ui_story"].transform.position).z)
				arg_354_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1011ui_story"].transform.localEulerAngles = arg_354_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["1011ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1011ui_story == nil then
				arg_354_1.var_.characterEffect1011ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect1011ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1011ui_story then
				arg_354_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_357_4 = "1011ui_story"

			if arg_354_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_357_5 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_354_1.stage_.transform)

				var_357_5.name = var_357_4
				var_357_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.actors_[var_357_4] = var_357_5

				local var_357_6 = var_357_5:GetComponentInChildren(typeof(CharacterEffect))

				var_357_6.enabled = true

				local var_357_7 = GameObjectTools.GetOrAddComponent(var_357_5, typeof(DynamicBoneHelper))

				if var_357_7 then
					var_357_7:EnableDynamicBone(false)
				end

				arg_354_1:ShowWeapon(var_357_6.transform, false)

				arg_354_1.var_[var_357_4 .. "Animator"] = var_357_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_354_1.var_[var_357_4 .. "Animator"].applyRootMotion = true
				arg_354_1.var_[var_357_4 .. "LipSync"] = var_357_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action438")
			end

			local var_357_8 = 0
			local var_357_9 = 0.1

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_10 = arg_354_1:GetWordFromCfg(320182085)
				local var_357_11 = arg_354_1:FormatText(var_357_10.content)

				arg_354_1.text_.text = var_357_11

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_13 = 4 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 4)

				if (4 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 4)) > 0 and var_357_9 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_11
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182085", "story_v_out_320182.awb") ~= 0 then
					local var_357_14 = manager.audio:GetVoiceLength("story_v_out_320182", "320182085", "story_v_out_320182.awb") / 1000

					if var_357_14 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_8
					end

					if var_357_10.prefab_name ~= "" and arg_354_1.actors_[var_357_10.prefab_name] ~= nil then
						local var_357_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_10.prefab_name].transform, "story_v_out_320182", "320182085", "story_v_out_320182.awb")

						arg_354_1:RecordAudio("320182085", var_357_15)
						arg_354_1:RecordAudio("320182085", var_357_15)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_320182", "320182085", "story_v_out_320182.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_320182", "320182085", "story_v_out_320182.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_16 and arg_354_1.time_ < var_357_8 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play320182086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 320182086
		arg_358_1.duration_ = 10.83

		local var_358_0 = {
			zh = 7.366,
			ja = 10.833
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play320182087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1011ui_story = arg_358_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1011ui_story"].transform.position).z)
				arg_358_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1011ui_story"].transform.localEulerAngles = arg_358_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1011ui_story"].transform.position).z)
				arg_358_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1011ui_story"].transform.localEulerAngles = arg_358_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["1011ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1011ui_story == nil then
				arg_358_1.var_.characterEffect1011ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect1011ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_2)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1011ui_story then
				arg_358_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_361_3 = arg_358_1.actors_["10100ui_story"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10100ui_story = var_361_3.localPosition
			end

			local var_361_4 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				var_361_3.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_358_1.time_ - 0) / var_361_4)
				var_361_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_361_3.position).x, (manager.ui.mainCamera.transform.position - var_361_3.position).y, (manager.ui.mainCamera.transform.position - var_361_3.position).z)
				var_361_3.localEulerAngles.z = 0
				var_361_3.localEulerAngles.x = 0
				var_361_3.localEulerAngles = var_361_3.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				var_361_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_361_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_361_3.position).x, (manager.ui.mainCamera.transform.position - var_361_3.position).y, (manager.ui.mainCamera.transform.position - var_361_3.position).z)
				var_361_3.localEulerAngles.z = 0
				var_361_3.localEulerAngles.x = 0
				var_361_3.localEulerAngles = var_361_3.localEulerAngles
			end

			local var_361_5 = arg_358_1.actors_["10100ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_5) and arg_358_1.var_.characterEffect10100ui_story == nil then
				arg_358_1.var_.characterEffect10100ui_story = var_361_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_6 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_6 and not isNil(var_361_5) then
				if arg_358_1.var_.characterEffect10100ui_story and not isNil(var_361_5) then
					arg_358_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_6 and arg_358_1.time_ < 0 + var_361_6 + arg_361_0 and not isNil(var_361_5) and arg_358_1.var_.characterEffect10100ui_story then
				arg_358_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_361_8 = 0
			local var_361_9 = 1.2

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_8 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_10 = arg_358_1:GetWordFromCfg(320182086)
				local var_361_11 = arg_358_1:FormatText(var_361_10.content)

				arg_358_1.text_.text = var_361_11

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_13 = 48 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 48)

				if (48 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 48)) > 0 and var_361_9 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_8
					end
				end

				arg_358_1.text_.text = var_361_11
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182086", "story_v_out_320182.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_320182", "320182086", "story_v_out_320182.awb") / 1000

					if var_361_14 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_8
					end

					if var_361_10.prefab_name ~= "" and arg_358_1.actors_[var_361_10.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_10.prefab_name].transform, "story_v_out_320182", "320182086", "story_v_out_320182.awb")

						arg_358_1:RecordAudio("320182086", var_361_15)
						arg_358_1:RecordAudio("320182086", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_320182", "320182086", "story_v_out_320182.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_320182", "320182086", "story_v_out_320182.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_9, arg_358_1.talkMaxDuration)

			if var_361_8 <= arg_358_1.time_ and arg_358_1.time_ < var_361_8 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_8) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_8 + var_361_16 and arg_358_1.time_ < var_361_8 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play320182087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 320182087
		arg_362_1.duration_ = 11.13

		local var_362_0 = {
			zh = 7.066,
			ja = 11.133
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play320182088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 1.075

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(320182087)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 43 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 43)

				if (43 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 43)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182087", "story_v_out_320182.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182087", "story_v_out_320182.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_320182", "320182087", "story_v_out_320182.awb")

						arg_362_1:RecordAudio("320182087", var_365_6)
						arg_362_1:RecordAudio("320182087", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_320182", "320182087", "story_v_out_320182.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_320182", "320182087", "story_v_out_320182.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play320182088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 320182088
		arg_366_1.duration_ = 6.53

		local var_366_0 = {
			zh = 6.533,
			ja = 6.033
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play320182089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10102ui_story = arg_366_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10102ui_story"].transform.position).z)
				arg_366_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["10102ui_story"].transform.localEulerAngles = arg_366_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_366_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10102ui_story"].transform.position).z)
				arg_366_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["10102ui_story"].transform.localEulerAngles = arg_366_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_369_1 = arg_366_1.actors_["10102ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect10102ui_story == nil then
				arg_366_1.var_.characterEffect10102ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect10102ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect10102ui_story then
				arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_369_4 = arg_366_1.actors_["10100ui_story"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10100ui_story = var_369_4.localPosition
			end

			local var_369_5 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_5 then
				var_369_4.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_366_1.time_ - 0) / var_369_5)
				var_369_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_369_4.position).x, (manager.ui.mainCamera.transform.position - var_369_4.position).y, (manager.ui.mainCamera.transform.position - var_369_4.position).z)
				var_369_4.localEulerAngles.z = 0
				var_369_4.localEulerAngles.x = 0
				var_369_4.localEulerAngles = var_369_4.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_5 and arg_366_1.time_ < 0 + var_369_5 + arg_369_0 then
				var_369_4.localPosition = Vector3.New(0, 100, 0)
				var_369_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_369_4.position).x, (manager.ui.mainCamera.transform.position - var_369_4.position).y, (manager.ui.mainCamera.transform.position - var_369_4.position).z)
				var_369_4.localEulerAngles.z = 0
				var_369_4.localEulerAngles.x = 0
				var_369_4.localEulerAngles = var_369_4.localEulerAngles
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_369_6 = 0
			local var_369_7 = 0.875

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_8 = arg_366_1:GetWordFromCfg(320182088)
				local var_369_9 = arg_366_1:FormatText(var_369_8.content)

				arg_366_1.text_.text = var_369_9

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 35 <= 0 and var_369_7 or var_369_7 * (utf8.len(var_369_9) / 35)

				if (35 <= 0 and var_369_7 or var_369_7 * (utf8.len(var_369_9) / 35)) > 0 and var_369_7 < var_369_11 then
					arg_366_1.talkMaxDuration = var_369_11

					if var_369_11 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_11 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_9
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182088", "story_v_out_320182.awb") ~= 0 then
					local var_369_12 = manager.audio:GetVoiceLength("story_v_out_320182", "320182088", "story_v_out_320182.awb") / 1000

					if var_369_12 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_12 + var_369_6
					end

					if var_369_8.prefab_name ~= "" and arg_366_1.actors_[var_369_8.prefab_name] ~= nil then
						local var_369_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_8.prefab_name].transform, "story_v_out_320182", "320182088", "story_v_out_320182.awb")

						arg_366_1:RecordAudio("320182088", var_369_13)
						arg_366_1:RecordAudio("320182088", var_369_13)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_320182", "320182088", "story_v_out_320182.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_320182", "320182088", "story_v_out_320182.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_14 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_14 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_14

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_14 and arg_366_1.time_ < var_369_6 + var_369_14 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play320182089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 320182089
		arg_370_1.duration_ = 5.93

		local var_370_0 = {
			zh = 5.933,
			ja = 4.833
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play320182090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.8

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:GetWordFromCfg(320182089)
				local var_373_2 = arg_370_1:FormatText(var_373_1.content)

				arg_370_1.text_.text = var_373_2

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 32 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 32)

				if (32 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 32)) > 0 and var_373_0 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end

				arg_370_1.text_.text = var_373_2
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320182", "320182089", "story_v_out_320182.awb") ~= 0 then
					local var_373_5 = manager.audio:GetVoiceLength("story_v_out_320182", "320182089", "story_v_out_320182.awb") / 1000

					if var_373_5 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + 0
					end

					if var_373_1.prefab_name ~= "" and arg_370_1.actors_[var_373_1.prefab_name] ~= nil then
						local var_373_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_1.prefab_name].transform, "story_v_out_320182", "320182089", "story_v_out_320182.awb")

						arg_370_1:RecordAudio("320182089", var_373_6)
						arg_370_1:RecordAudio("320182089", var_373_6)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_320182", "320182089", "story_v_out_320182.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_320182", "320182089", "story_v_out_320182.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play320182090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 320182090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play320182091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10102ui_story"]) and arg_374_1.var_.characterEffect10102ui_story == nil then
				arg_374_1.var_.characterEffect10102ui_story = arg_374_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10102ui_story"]) then
				if arg_374_1.var_.characterEffect10102ui_story and not isNil(arg_374_1.actors_["10102ui_story"]) then
					arg_374_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_374_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_0)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10102ui_story"]) and arg_374_1.var_.characterEffect10102ui_story then
				arg_374_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_374_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_377_1 = 0
			local var_377_2 = 0.6

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(320182090).content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 24 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_3) / 24)

				if (24 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_3) / 24)) > 0 and var_377_2 < var_377_5 then
					arg_374_1.talkMaxDuration = var_377_5

					if var_377_5 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + var_377_1
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_6 = math.max(var_377_2, arg_374_1.talkMaxDuration)

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_6 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_1) / var_377_6

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_1 + var_377_6 and arg_374_1.time_ < var_377_1 + var_377_6 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play320182091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 320182091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play320182092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos10102ui_story = arg_378_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["10102ui_story"].transform.position).z)
				arg_378_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["10102ui_story"].transform.localEulerAngles = arg_378_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_378_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["10102ui_story"].transform.position).z)
				arg_378_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["10102ui_story"].transform.localEulerAngles = arg_378_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_381_1 = 0
			local var_381_2 = 1.675

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(320182091).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 67 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 67)

				if (67 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 67)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play320182092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 320182092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play320182093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 1.025

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(320182092).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 41 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 41)

				if (41 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 41)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play320182093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 320182093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play320182094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.55

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(320182093).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 22 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 22)

				if (22 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 22)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play320182094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 320182094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
			arg_390_1.auto_ = false
		end

		function arg_390_1.playNext_(arg_392_0)
			arg_390_1.onStoryFinished_()
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.85

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(320182094).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 34 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 34)

				if (34 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 34)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L02f",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/XS0201",
		"TextureConfig/Background/ST0503"
	},
	voices = {
		"story_v_out_320182.awb"
	}
}
