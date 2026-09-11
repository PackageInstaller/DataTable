return {
	Play119906001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 119906001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play119906002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST16 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST16")
				var_4_0.name = "ST16"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST16 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST16

				arg_1_1.bgs_.ST16.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST16" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(119906001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 5 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 5)

				if (5 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 5)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play119906002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 119906002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play119906003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.725

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(119906002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 29 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 29)

				if (29 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 29)) > 0 and var_12_0 < var_12_3 then
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
	Play119906003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 119906003
		arg_13_1.duration_ = 9.07

		local var_13_0 = {
			zh = 7.1,
			ja = 9.066
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play119906004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1099ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1099ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1099ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1099ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1099ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1099ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1099ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1099ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1099ui_story == nil then
				arg_13_1.var_.characterEffect1099ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1099ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1099ui_story then
				arg_13_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(119906003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 31 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 31)

				if (31 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 31)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906003", "story_v_side_old_119906.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906003", "story_v_side_old_119906.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_side_old_119906", "119906003", "story_v_side_old_119906.awb")

						arg_13_1:RecordAudio("119906003", var_16_15)
						arg_13_1:RecordAudio("119906003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906003", "story_v_side_old_119906.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906003", "story_v_side_old_119906.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play119906004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 119906004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play119906005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1099ui_story"]) and arg_17_1.var_.characterEffect1099ui_story == nil then
				arg_17_1.var_.characterEffect1099ui_story = arg_17_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1099ui_story"]) then
				if arg_17_1.var_.characterEffect1099ui_story and not isNil(arg_17_1.actors_["1099ui_story"]) then
					arg_17_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1099ui_story"]) and arg_17_1.var_.characterEffect1099ui_story then
				arg_17_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
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

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(119906004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 18 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 18)

				if (18 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 18)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play119906005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 119906005
		arg_21_1.duration_ = 4.9

		local var_21_0 = {
			zh = 3,
			ja = 4.9
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
				arg_21_0:Play119906006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1099ui_story"]) and arg_21_1.var_.characterEffect1099ui_story == nil then
				arg_21_1.var_.characterEffect1099ui_story = arg_21_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1099ui_story"]) then
				if arg_21_1.var_.characterEffect1099ui_story and not isNil(arg_21_1.actors_["1099ui_story"]) then
					arg_21_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1099ui_story"]) and arg_21_1.var_.characterEffect1099ui_story then
				arg_21_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(119906005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 15 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 15)

				if (15 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 15)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906005", "story_v_side_old_119906.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906005", "story_v_side_old_119906.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_side_old_119906", "119906005", "story_v_side_old_119906.awb")

						arg_21_1:RecordAudio("119906005", var_24_9)
						arg_21_1:RecordAudio("119906005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906005", "story_v_side_old_119906.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906005", "story_v_side_old_119906.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play119906006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 119906006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play119906007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1099ui_story"]) and arg_25_1.var_.characterEffect1099ui_story == nil then
				arg_25_1.var_.characterEffect1099ui_story = arg_25_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1099ui_story"]) then
				if arg_25_1.var_.characterEffect1099ui_story and not isNil(arg_25_1.actors_["1099ui_story"]) then
					arg_25_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1099ui_story"]) and arg_25_1.var_.characterEffect1099ui_story then
				arg_25_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.725

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(119906006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 29 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 29)

				if (29 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 29)) > 0 and var_28_2 < var_28_5 then
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play119906007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 119906007
		arg_29_1.duration_ = 9.33

		local var_29_0 = {
			zh = 8.866,
			ja = 9.333
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
				arg_29_0:Play119906008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1099ui_story"]) and arg_29_1.var_.characterEffect1099ui_story == nil then
				arg_29_1.var_.characterEffect1099ui_story = arg_29_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1099ui_story"]) then
				if arg_29_1.var_.characterEffect1099ui_story and not isNil(arg_29_1.actors_["1099ui_story"]) then
					arg_29_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1099ui_story"]) and arg_29_1.var_.characterEffect1099ui_story then
				arg_29_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action436")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = 0
			local var_32_3 = 0.7

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(119906007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 28 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 28)

				if (28 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 28)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906007", "story_v_side_old_119906.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906007", "story_v_side_old_119906.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_old_119906", "119906007", "story_v_side_old_119906.awb")

						arg_29_1:RecordAudio("119906007", var_32_9)
						arg_29_1:RecordAudio("119906007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906007", "story_v_side_old_119906.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906007", "story_v_side_old_119906.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play119906008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 119906008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play119906009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1099ui_story = arg_33_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1099ui_story"].transform.position).z)
				arg_33_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1099ui_story"].transform.localEulerAngles = arg_33_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1099ui_story"].transform.position).z)
				arg_33_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1099ui_story"].transform.localEulerAngles = arg_33_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1099ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1099ui_story == nil then
				arg_33_1.var_.characterEffect1099ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1099ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1099ui_story then
				arg_33_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_36_3 = 0
			local var_36_4 = 0.85

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(119906008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 34 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 34)

				if (34 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 34)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play119906009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 119906009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play119906010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(119906009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 17 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 17)

				if (17 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 17)) > 0 and var_40_0 < var_40_3 then
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
	Play119906010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 119906010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play119906011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_44_0 = 0.6

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				local var_44_1, var_44_2 = math.modf((arg_41_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_44_2 * 0.13, var_44_2 * 0.13, var_44_2 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				manager.ui.mainCamera.transform.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_3 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_3 + 0.6 and arg_41_1.time_ < var_44_3 + 0.6 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_4 = 0
			local var_44_5 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_6 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(119906010).content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 5 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_6) / 5)

				if (5 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_6) / 5)) > 0 and var_44_5 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_9 and arg_41_1.time_ < var_44_4 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play119906011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 119906011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play119906012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(119906011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 21)

				if (21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 21)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play119906012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 119906012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play119906013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.325

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

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(119906012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 53 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 53)

				if (53 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 53)) > 0 and var_52_0 < var_52_3 then
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
	Play119906013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 119906013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play119906014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_56_0 = 0.6

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				local var_56_1, var_56_2 = math.modf((arg_53_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_56_2 * 0.13, var_56_2 * 0.13, var_56_2 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				manager.ui.mainCamera.transform.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_3 = manager.ui.mainCamera.transform

			if 0.866666666666667 < arg_53_1.time_ and arg_53_1.time_ <= 0.866666666666667 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_3.localPosition
			end

			local var_56_4 = 0.6

			if 0.866666666666667 <= arg_53_1.time_ and arg_53_1.time_ < 0.866666666666667 + var_56_4 then
				local var_56_5, var_56_6 = math.modf((arg_53_1.time_ - 0.866666666666667) / 0.066)

				var_56_3.localPosition = Vector3.New(var_56_6 * 0.13, var_56_6 * 0.13, var_56_6 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0.866666666666667 + var_56_4 and arg_53_1.time_ < 0.866666666666667 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_7 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_7 + 1.46666666666667 and arg_53_1.time_ < var_56_7 + 1.46666666666667 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_side_1199", "se_story_1199_break", "")
			end

			local var_56_9 = 0
			local var_56_10 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_11 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(119906013).content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 12 <= 0 and var_56_10 or var_56_10 * (utf8.len(var_56_11) / 12)

				if (12 <= 0 and var_56_10 or var_56_10 * (utf8.len(var_56_11) / 12)) > 0 and var_56_10 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_9 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_9
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_10, arg_53_1.talkMaxDuration)

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_9) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_9 + var_56_14 and arg_53_1.time_ < var_56_9 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play119906014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 119906014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play119906015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.075

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(119906014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 3 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 3)

				if (3 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 3)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play119906015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 119906015
		arg_61_1.duration_ = 1.5

		local var_61_0 = {
			zh = 1,
			ja = 1.5
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play119906016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(119906015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 4 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 4)

				if (4 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 4)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906015", "story_v_side_old_119906.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906015", "story_v_side_old_119906.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_side_old_119906", "119906015", "story_v_side_old_119906.awb")

						arg_61_1:RecordAudio("119906015", var_64_6)
						arg_61_1:RecordAudio("119906015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906015", "story_v_side_old_119906.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906015", "story_v_side_old_119906.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play119906016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 119906016
		arg_65_1.duration_ = 8.83

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play119906017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_68_0 = 1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				local var_68_1, var_68_2 = math.modf((arg_65_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_68_2 * 0.13, var_68_2 * 0.13, var_68_2 * 0.13) + arg_65_1.var_.shakeOldPos
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				manager.ui.mainCamera.transform.localPosition = arg_65_1.var_.shakeOldPos
			end

			local var_68_3 = "ST16_blur"

			if arg_65_1.bgs_.ST16_blur == nil then
				local var_68_4 = Object.Instantiate(arg_65_1.blurPaintGo_)

				var_68_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_3)
				var_68_4.name = var_68_3
				var_68_4.transform.parent = arg_65_1.stage_.transform
				var_68_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_3] = var_68_4
			end

			local var_68_5 = 0.7
			local var_68_6 = arg_65_1.bgs_[var_68_3]

			if 0.7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				var_68_6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_7 = var_68_6:GetComponent("SpriteRenderer")

				if var_68_7 and var_68_7.sprite then
					local var_68_8 = 2 * (var_68_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_6.transform.localScale = Vector3.New(var_68_8 / var_68_7.sprite.bounds.size.y < var_68_8 * manager.ui.mainCameraCom_.aspect / var_68_7.sprite.bounds.size.x and var_68_8 * manager.ui.mainCameraCom_.aspect / var_68_7.sprite.bounds.size.x or var_68_8 / var_68_7.sprite.bounds.size.y, var_68_8 / var_68_7.sprite.bounds.size.y < var_68_8 * manager.ui.mainCameraCom_.aspect / var_68_7.sprite.bounds.size.x and var_68_8 * manager.ui.mainCameraCom_.aspect / var_68_7.sprite.bounds.size.x or var_68_8 / var_68_7.sprite.bounds.size.y, 0)
				end
			end

			local var_68_9 = 2

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_9 then
				local var_68_10 = Color.New(1, 1, 1)

				var_68_10.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_5) / var_68_9)

				var_68_6:GetComponent("SpriteRenderer").material:SetColor("_Color", var_68_10)
			end

			local var_68_11 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_11 + 1.83333333333333 and arg_65_1.time_ < var_68_11 + 1.83333333333333 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_12 = 1.83333333333333

			if 1.83333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_13 = 2

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 then
				local var_68_14 = Color.New(0, 0, 0)

				var_68_14.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_12) / var_68_13)
				arg_65_1.mask_.color = var_68_14
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 then
				local var_68_15 = Color.New(0, 0, 0)

				var_68_15.a = 1
				arg_65_1.mask_.color = var_68_15
			end

			local var_68_16 = 3.83333333333333

			if 3.83333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_17 = 2

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = Color.New(0, 0, 0)

				var_68_18.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_16) / var_68_17)
				arg_65_1.mask_.color = var_68_18
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				local var_68_19 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_19.a = 0
				arg_65_1.mask_.color = var_68_19
			end

			local var_68_20 = "STblack"

			if arg_65_1.bgs_.STblack == nil then
				local var_68_21 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_20)
				var_68_21.name = var_68_20
				var_68_21.transform.parent = arg_65_1.stage_.transform
				var_68_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_20] = var_68_21
			end

			if 3.83333333333333 < arg_65_1.time_ and arg_65_1.time_ <= 3.83333333333333 + arg_68_0 then
				local var_68_22 = arg_65_1.bgs_.STblack

				arg_65_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_23 = var_68_22:GetComponent("SpriteRenderer")

				if var_68_23 and var_68_23.sprite then
					local var_68_24 = 2 * (var_68_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_22.transform.localScale = Vector3.New(var_68_24 / var_68_23.sprite.bounds.size.y < var_68_24 * manager.ui.mainCameraCom_.aspect / var_68_23.sprite.bounds.size.x and var_68_24 * manager.ui.mainCameraCom_.aspect / var_68_23.sprite.bounds.size.x or var_68_24 / var_68_23.sprite.bounds.size.y, var_68_24 / var_68_23.sprite.bounds.size.y < var_68_24 * manager.ui.mainCameraCom_.aspect / var_68_23.sprite.bounds.size.x and var_68_24 * manager.ui.mainCameraCom_.aspect / var_68_23.sprite.bounds.size.x or var_68_24 / var_68_23.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "STblack" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_25 = 3.83333333333333
			local var_68_26 = 1.275

			if 3.83333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_25 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_27 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_27:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_28 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(119906016).content)

				arg_65_1.text_.text = var_68_28

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_30 = 51 <= 0 and var_68_26 or var_68_26 * (utf8.len(var_68_28) / 51)

				if (51 <= 0 and var_68_26 or var_68_26 * (utf8.len(var_68_28) / 51)) > 0 and var_68_26 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30
					var_68_25 = var_68_25 + 0.3

					if var_68_30 + var_68_25 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_25
					end
				end

				arg_65_1.text_.text = var_68_28
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = var_68_25 + 0.3
			local var_68_32 = math.max(var_68_26, arg_65_1.talkMaxDuration)

			if var_68_25 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_31 + var_68_32 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_31) / var_68_32

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_31 + var_68_32 and arg_65_1.time_ < var_68_31 + var_68_32 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play119906017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 119906017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play119906018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(119906017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 16)

				if (16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 16)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play119906018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 119906018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play119906019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.15

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(119906018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 46 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 46)

				if (46 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 46)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play119906019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 119906019
		arg_79_1.duration_ = 4.3

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play119906020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1099ui_story = arg_79_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1099ui_story"].transform.position).z)
				arg_79_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1099ui_story"].transform.localEulerAngles = arg_79_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_79_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1099ui_story"].transform.position).z)
				arg_79_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1099ui_story"].transform.localEulerAngles = arg_79_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1099ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1099ui_story == nil then
				arg_79_1.var_.characterEffect1099ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1099ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1099ui_story then
				arg_79_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_82_4 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_5 = 2

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_5 then
				local var_82_6 = Color.New(0, 0, 0)

				var_82_6.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_4) / var_82_5)
				arg_79_1.mask_.color = var_82_6
			end

			if arg_79_1.time_ >= var_82_4 + var_82_5 and arg_79_1.time_ < var_82_4 + var_82_5 + arg_82_0 then
				local var_82_7 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_7.a = 0
				arg_79_1.mask_.color = var_82_7
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_8 = arg_79_1.bgs_.ST16

				arg_79_1.bgs_.ST16.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_9 = var_82_8:GetComponent("SpriteRenderer")

				if var_82_9 and var_82_9.sprite then
					local var_82_10 = 2 * (var_82_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_8.transform.localScale = Vector3.New(var_82_10 / var_82_9.sprite.bounds.size.y < var_82_10 * manager.ui.mainCameraCom_.aspect / var_82_9.sprite.bounds.size.x and var_82_10 * manager.ui.mainCameraCom_.aspect / var_82_9.sprite.bounds.size.x or var_82_10 / var_82_9.sprite.bounds.size.y, var_82_10 / var_82_9.sprite.bounds.size.y < var_82_10 * manager.ui.mainCameraCom_.aspect / var_82_9.sprite.bounds.size.x and var_82_10 * manager.ui.mainCameraCom_.aspect / var_82_9.sprite.bounds.size.x or var_82_10 / var_82_9.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "ST16" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_11 = 2
			local var_82_12 = 0.05

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_13 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_13:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[519].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_14 = arg_79_1:GetWordFromCfg(119906019)
				local var_82_15 = arg_79_1:FormatText(var_82_14.content)

				arg_79_1.text_.text = var_82_15

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 2 <= 0 and var_82_12 or var_82_12 * (utf8.len(var_82_15) / 2)

				if (2 <= 0 and var_82_12 or var_82_12 * (utf8.len(var_82_15) / 2)) > 0 and var_82_12 < var_82_17 then
					arg_79_1.talkMaxDuration = var_82_17
					var_82_11 = var_82_11 + 0.3

					if var_82_17 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_11
					end
				end

				arg_79_1.text_.text = var_82_15
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906019", "story_v_side_old_119906.awb") ~= 0 then
					local var_82_18 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906019", "story_v_side_old_119906.awb") / 1000

					if var_82_18 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_18 + var_82_11
					end

					if var_82_14.prefab_name ~= "" and arg_79_1.actors_[var_82_14.prefab_name] ~= nil then
						local var_82_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_14.prefab_name].transform, "story_v_side_old_119906", "119906019", "story_v_side_old_119906.awb")

						arg_79_1:RecordAudio("119906019", var_82_19)
						arg_79_1:RecordAudio("119906019", var_82_19)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906019", "story_v_side_old_119906.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906019", "story_v_side_old_119906.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_20 = var_82_11 + 0.3
			local var_82_21 = math.max(var_82_12, arg_79_1.talkMaxDuration)

			if var_82_11 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_20 + var_82_21 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_20) / var_82_21

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_20 + var_82_21 and arg_79_1.time_ < var_82_20 + var_82_21 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play119906020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 119906020
		arg_85_1.duration_ = 2.63

		local var_85_0 = {
			zh = 2.6,
			ja = 2.633
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play119906021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_88_0 = 0
			local var_88_1 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(119906020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 9 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 9)

				if (9 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 9)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906020", "story_v_side_old_119906.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906020", "story_v_side_old_119906.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_side_old_119906", "119906020", "story_v_side_old_119906.awb")

						arg_85_1:RecordAudio("119906020", var_88_7)
						arg_85_1:RecordAudio("119906020", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906020", "story_v_side_old_119906.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906020", "story_v_side_old_119906.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play119906021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 119906021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play119906022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1099ui_story"]) and arg_89_1.var_.characterEffect1099ui_story == nil then
				arg_89_1.var_.characterEffect1099ui_story = arg_89_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1099ui_story"]) then
				if arg_89_1.var_.characterEffect1099ui_story and not isNil(arg_89_1.actors_["1099ui_story"]) then
					arg_89_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1099ui_story"]) and arg_89_1.var_.characterEffect1099ui_story then
				arg_89_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(119906021).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 12 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 12)

				if (12 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 12)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play119906022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 119906022
		arg_93_1.duration_ = 7.43

		local var_93_0 = {
			zh = 7.433,
			ja = 6
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play119906023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1099ui_story"]) and arg_93_1.var_.characterEffect1099ui_story == nil then
				arg_93_1.var_.characterEffect1099ui_story = arg_93_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1099ui_story"]) then
				if arg_93_1.var_.characterEffect1099ui_story and not isNil(arg_93_1.actors_["1099ui_story"]) then
					arg_93_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1099ui_story"]) and arg_93_1.var_.characterEffect1099ui_story then
				arg_93_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.8

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(119906022)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 32 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 32)

				if (32 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 32)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906022", "story_v_side_old_119906.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906022", "story_v_side_old_119906.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_side_old_119906", "119906022", "story_v_side_old_119906.awb")

						arg_93_1:RecordAudio("119906022", var_96_9)
						arg_93_1:RecordAudio("119906022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906022", "story_v_side_old_119906.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906022", "story_v_side_old_119906.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play119906023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 119906023
		arg_97_1.duration_ = 0.5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"

			SetActive(arg_97_1.choicesGo_, true)

			for iter_98_0, iter_98_1 in ipairs(arg_97_1.choices_) do
				SetActive(iter_98_1.go, iter_98_0 <= 1)
			end

			arg_97_1.choices_[1].txt.text = arg_97_1:FormatText(StoryChoiceCfg[484].name)
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play119906024(arg_97_1)
			end

			arg_97_1:RecordChoiceLog(119906023, 484)
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1099ui_story"]) and arg_97_1.var_.characterEffect1099ui_story == nil then
				arg_97_1.var_.characterEffect1099ui_story = arg_97_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1099ui_story"]) then
				if arg_97_1.var_.characterEffect1099ui_story and not isNil(arg_97_1.actors_["1099ui_story"]) then
					arg_97_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1099ui_story"]) and arg_97_1.var_.characterEffect1099ui_story then
				arg_97_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			if arg_97_1.time_ >= var_100_1 + 0.5 and arg_97_1.time_ < var_100_1 + 0.5 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play119906024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 119906024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play119906025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(119906024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 51 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 51)

				if (51 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 51)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play119906025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 119906025
		arg_105_1.duration_ = 8.37

		local var_105_0 = {
			zh = 7.266,
			ja = 8.366
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play119906026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1099ui_story"]) and arg_105_1.var_.characterEffect1099ui_story == nil then
				arg_105_1.var_.characterEffect1099ui_story = arg_105_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1099ui_story"]) then
				if arg_105_1.var_.characterEffect1099ui_story and not isNil(arg_105_1.actors_["1099ui_story"]) then
					arg_105_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1099ui_story"]) and arg_105_1.var_.characterEffect1099ui_story then
				arg_105_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action2_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_2 = 0
			local var_108_3 = 0.875

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(119906025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 35 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 35)

				if (35 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 35)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906025", "story_v_side_old_119906.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906025", "story_v_side_old_119906.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_old_119906", "119906025", "story_v_side_old_119906.awb")

						arg_105_1:RecordAudio("119906025", var_108_9)
						arg_105_1:RecordAudio("119906025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906025", "story_v_side_old_119906.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906025", "story_v_side_old_119906.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play119906026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 119906026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play119906027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1099ui_story"]) and arg_109_1.var_.characterEffect1099ui_story == nil then
				arg_109_1.var_.characterEffect1099ui_story = arg_109_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1099ui_story"]) then
				if arg_109_1.var_.characterEffect1099ui_story and not isNil(arg_109_1.actors_["1099ui_story"]) then
					arg_109_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1099ui_story"]) and arg_109_1.var_.characterEffect1099ui_story then
				arg_109_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(119906026).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 14 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 14)

				if (14 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 14)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play119906027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 119906027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play119906028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.2

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

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(119906027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 48 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 48)

				if (48 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 48)) > 0 and var_116_0 < var_116_3 then
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
	Play119906028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 119906028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play119906029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.575

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

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(119906028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)

				if (23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)) > 0 and var_120_0 < var_120_3 then
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
	Play119906029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 119906029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play119906030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1099ui_story = arg_121_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1099ui_story"].transform.position).z)
				arg_121_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1099ui_story"].transform.localEulerAngles = arg_121_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1099ui_story"].transform.position).z)
				arg_121_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1099ui_story"].transform.localEulerAngles = arg_121_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1099ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1099ui_story == nil then
				arg_121_1.var_.characterEffect1099ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1099ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1099ui_story then
				arg_121_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_124_3 = 0
			local var_124_4 = 1.65

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(119906029).content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 66 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 66)

				if (66 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 66)) > 0 and var_124_4 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_8 and arg_121_1.time_ < var_124_3 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play119906030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 119906030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play119906031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(119906030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 43 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 43)

				if (43 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 43)) > 0 and var_128_0 < var_128_3 then
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
	Play119906031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 119906031
		arg_129_1.duration_ = 4.83

		local var_129_0 = {
			zh = 4.833,
			ja = 4.8
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play119906032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1099ui_story = arg_129_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1099ui_story"].transform.position).z)
				arg_129_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1099ui_story"].transform.localEulerAngles = arg_129_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_129_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1099ui_story"].transform.position).z)
				arg_129_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1099ui_story"].transform.localEulerAngles = arg_129_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1099ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1099ui_story == nil then
				arg_129_1.var_.characterEffect1099ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1099ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1099ui_story then
				arg_129_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.5

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(119906031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 20 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 20)

				if (20 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 20)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906031", "story_v_side_old_119906.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906031", "story_v_side_old_119906.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_old_119906", "119906031", "story_v_side_old_119906.awb")

						arg_129_1:RecordAudio("119906031", var_132_11)
						arg_129_1:RecordAudio("119906031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906031", "story_v_side_old_119906.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906031", "story_v_side_old_119906.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play119906032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 119906032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play119906033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1099ui_story"]) and arg_133_1.var_.characterEffect1099ui_story == nil then
				arg_133_1.var_.characterEffect1099ui_story = arg_133_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1099ui_story"]) then
				if arg_133_1.var_.characterEffect1099ui_story and not isNil(arg_133_1.actors_["1099ui_story"]) then
					arg_133_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1099ui_story"]) and arg_133_1.var_.characterEffect1099ui_story then
				arg_133_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.175

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(119906032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 7 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 7)

				if (7 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 7)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play119906033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 119906033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play119906034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.65

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(119906033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 26 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 26)

				if (26 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 26)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play119906034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 119906034
		arg_141_1.duration_ = 8.57

		local var_141_0 = {
			zh = 6.733,
			ja = 8.566
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play119906035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1099ui_story"]) and arg_141_1.var_.characterEffect1099ui_story == nil then
				arg_141_1.var_.characterEffect1099ui_story = arg_141_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1099ui_story"]) then
				if arg_141_1.var_.characterEffect1099ui_story and not isNil(arg_141_1.actors_["1099ui_story"]) then
					arg_141_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1099ui_story"]) and arg_141_1.var_.characterEffect1099ui_story then
				arg_141_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = 0
			local var_144_3 = 0.8

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(119906034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 32 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 32)

				if (32 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 32)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906034", "story_v_side_old_119906.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906034", "story_v_side_old_119906.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_side_old_119906", "119906034", "story_v_side_old_119906.awb")

						arg_141_1:RecordAudio("119906034", var_144_9)
						arg_141_1:RecordAudio("119906034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906034", "story_v_side_old_119906.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906034", "story_v_side_old_119906.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play119906035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 119906035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play119906036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1099ui_story"]) and arg_145_1.var_.characterEffect1099ui_story == nil then
				arg_145_1.var_.characterEffect1099ui_story = arg_145_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1099ui_story"]) then
				if arg_145_1.var_.characterEffect1099ui_story and not isNil(arg_145_1.actors_["1099ui_story"]) then
					arg_145_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1099ui_story"]) and arg_145_1.var_.characterEffect1099ui_story then
				arg_145_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(119906035).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 4 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 4)

				if (4 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 4)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play119906036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 119906036
		arg_149_1.duration_ = 12

		local var_149_0 = {
			zh = 12.0000000029802,
			ja = 9.86600000298023
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
				arg_149_0:Play119906037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.ST11a == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST11a")
				var_152_0.name = "ST11a"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.ST11a = var_152_0
			end

			if 2.00000000298023 < arg_149_1.time_ and arg_149_1.time_ <= 2.00000000298023 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.ST11a

				arg_149_1.bgs_.ST11a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "ST11a" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_5 = 2

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_5 then
				local var_152_6 = Color.New(0, 0, 0)

				var_152_6.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - var_152_4) / var_152_5)
				arg_149_1.mask_.color = var_152_6
			end

			if arg_149_1.time_ >= var_152_4 + var_152_5 and arg_149_1.time_ < var_152_4 + var_152_5 + arg_152_0 then
				local var_152_7 = Color.New(0, 0, 0)

				var_152_7.a = 1
				arg_149_1.mask_.color = var_152_7
			end

			local var_152_8 = 2.00000000298023

			if 2.00000000298023 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_9 = 2

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_9 then
				local var_152_10 = Color.New(0, 0, 0)

				var_152_10.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_8) / var_152_9)
				arg_149_1.mask_.color = var_152_10
			end

			if arg_149_1.time_ >= var_152_8 + var_152_9 and arg_149_1.time_ < var_152_8 + var_152_9 + arg_152_0 then
				local var_152_11 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_11.a = 0
				arg_149_1.mask_.color = var_152_11
			end

			local var_152_12 = arg_149_1.actors_["1099ui_story"].transform

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1.var_.moveOldPos1099ui_story = var_152_12.localPosition
			end

			local var_152_13 = 0.001

			if 3.8 <= arg_149_1.time_ and arg_149_1.time_ < 3.8 + var_152_13 then
				var_152_12.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_149_1.time_ - 3.8) / var_152_13)
				var_152_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_12.position).x, (manager.ui.mainCamera.transform.position - var_152_12.position).y, (manager.ui.mainCamera.transform.position - var_152_12.position).z)
				var_152_12.localEulerAngles.z = 0
				var_152_12.localEulerAngles.x = 0
				var_152_12.localEulerAngles = var_152_12.localEulerAngles
			end

			if arg_149_1.time_ >= 3.8 + var_152_13 and arg_149_1.time_ < 3.8 + var_152_13 + arg_152_0 then
				var_152_12.localPosition = Vector3.New(0, -1.08, -5.9)
				var_152_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_12.position).x, (manager.ui.mainCamera.transform.position - var_152_12.position).y, (manager.ui.mainCamera.transform.position - var_152_12.position).z)
				var_152_12.localEulerAngles.z = 0
				var_152_12.localEulerAngles.x = 0
				var_152_12.localEulerAngles = var_152_12.localEulerAngles
			end

			local var_152_14 = arg_149_1.actors_["1099ui_story"]

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.characterEffect1099ui_story == nil then
				arg_149_1.var_.characterEffect1099ui_story = var_152_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_15 = 0.200000002980232

			if 3.8 <= arg_149_1.time_ and arg_149_1.time_ < 3.8 + var_152_15 and not isNil(var_152_14) then
				if arg_149_1.var_.characterEffect1099ui_story and not isNil(var_152_14) then
					arg_149_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 3.8 + var_152_15 and arg_149_1.time_ < 3.8 + var_152_15 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.characterEffect1099ui_story then
				arg_149_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_17 = arg_149_1.actors_["1099ui_story"].transform

			if 1.96599999815226 < arg_149_1.time_ and arg_149_1.time_ <= 1.96599999815226 + arg_152_0 then
				arg_149_1.var_.moveOldPos1099ui_story = var_152_17.localPosition
			end

			local var_152_18 = 0.001

			if 1.96599999815226 <= arg_149_1.time_ and arg_149_1.time_ < 1.96599999815226 + var_152_18 then
				var_152_17.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 1.96599999815226) / var_152_18)
				var_152_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_17.position).x, (manager.ui.mainCamera.transform.position - var_152_17.position).y, (manager.ui.mainCamera.transform.position - var_152_17.position).z)
				var_152_17.localEulerAngles.z = 0
				var_152_17.localEulerAngles.x = 0
				var_152_17.localEulerAngles = var_152_17.localEulerAngles
			end

			if arg_149_1.time_ >= 1.96599999815226 + var_152_18 and arg_149_1.time_ < 1.96599999815226 + var_152_18 + arg_152_0 then
				var_152_17.localPosition = Vector3.New(0, 100, 0)
				var_152_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_17.position).x, (manager.ui.mainCamera.transform.position - var_152_17.position).y, (manager.ui.mainCamera.transform.position - var_152_17.position).z)
				var_152_17.localEulerAngles.z = 0
				var_152_17.localEulerAngles.x = 0
				var_152_17.localEulerAngles = var_152_17.localEulerAngles
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_19 = 4.00000000298023
			local var_152_20 = 1.025

			if 4.00000000298023 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_21 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_21:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_22 = arg_149_1:GetWordFromCfg(119906036)
				local var_152_23 = arg_149_1:FormatText(var_152_22.content)

				arg_149_1.text_.text = var_152_23

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_25 = 41 <= 0 and var_152_20 or var_152_20 * (utf8.len(var_152_23) / 41)

				if (41 <= 0 and var_152_20 or var_152_20 * (utf8.len(var_152_23) / 41)) > 0 and var_152_20 < var_152_25 then
					arg_149_1.talkMaxDuration = var_152_25
					var_152_19 = var_152_19 + 0.3

					if var_152_25 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_25 + var_152_19
					end
				end

				arg_149_1.text_.text = var_152_23
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906036", "story_v_side_old_119906.awb") ~= 0 then
					local var_152_26 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906036", "story_v_side_old_119906.awb") / 1000

					if var_152_26 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_26 + var_152_19
					end

					if var_152_22.prefab_name ~= "" and arg_149_1.actors_[var_152_22.prefab_name] ~= nil then
						local var_152_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_22.prefab_name].transform, "story_v_side_old_119906", "119906036", "story_v_side_old_119906.awb")

						arg_149_1:RecordAudio("119906036", var_152_27)
						arg_149_1:RecordAudio("119906036", var_152_27)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906036", "story_v_side_old_119906.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906036", "story_v_side_old_119906.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_28 = var_152_19 + 0.3
			local var_152_29 = math.max(var_152_20, arg_149_1.talkMaxDuration)

			if var_152_19 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_28 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_28) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_28 + var_152_29 and arg_149_1.time_ < var_152_28 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play119906037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 119906037
		arg_155_1.duration_ = 9.3

		local var_155_0 = {
			zh = 7.066,
			ja = 9.3
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play119906038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.9

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(119906037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 36 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 36)

				if (36 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 36)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906037", "story_v_side_old_119906.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906037", "story_v_side_old_119906.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_side_old_119906", "119906037", "story_v_side_old_119906.awb")

						arg_155_1:RecordAudio("119906037", var_158_6)
						arg_155_1:RecordAudio("119906037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906037", "story_v_side_old_119906.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906037", "story_v_side_old_119906.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play119906038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 119906038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play119906039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1099ui_story"]) and arg_159_1.var_.characterEffect1099ui_story == nil then
				arg_159_1.var_.characterEffect1099ui_story = arg_159_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1099ui_story"]) then
				if arg_159_1.var_.characterEffect1099ui_story and not isNil(arg_159_1.actors_["1099ui_story"]) then
					arg_159_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1099ui_story"]) and arg_159_1.var_.characterEffect1099ui_story then
				arg_159_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.975

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(119906038).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 39 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 39)

				if (39 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 39)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play119906039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 119906039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play119906040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1099ui_story = arg_163_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1099ui_story"].transform.position).z)
				arg_163_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1099ui_story"].transform.localEulerAngles = arg_163_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1099ui_story"].transform.position).z)
				arg_163_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1099ui_story"].transform.localEulerAngles = arg_163_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1099ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1099ui_story == nil then
				arg_163_1.var_.characterEffect1099ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1099ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_2)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1099ui_story then
				arg_163_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_166_3 = 0
			local var_166_4 = 1.55

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_5 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(119906039).content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 62 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 62)

				if (62 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 62)) > 0 and var_166_4 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_3) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_3 + var_166_8 and arg_163_1.time_ < var_166_3 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play119906040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 119906040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play119906041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(119906040).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 14 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 14)

				if (14 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 14)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play119906041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 119906041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play119906042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.425

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(119906041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 17 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 17)

				if (17 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 17)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play119906042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 119906042
		arg_175_1.duration_ = 9.03

		local var_175_0 = {
			zh = 8.433,
			ja = 9.033
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play119906043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1099ui_story = arg_175_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1099ui_story"].transform.position).z)
				arg_175_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1099ui_story"].transform.localEulerAngles = arg_175_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_175_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1099ui_story"].transform.position).z)
				arg_175_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1099ui_story"].transform.localEulerAngles = arg_175_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1099ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1099ui_story == nil then
				arg_175_1.var_.characterEffect1099ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1099ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1099ui_story then
				arg_175_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action434")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_4 = 0
			local var_178_5 = 0.975

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(119906042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 38 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 38)

				if (38 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 38)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906042", "story_v_side_old_119906.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906042", "story_v_side_old_119906.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_side_old_119906", "119906042", "story_v_side_old_119906.awb")

						arg_175_1:RecordAudio("119906042", var_178_11)
						arg_175_1:RecordAudio("119906042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906042", "story_v_side_old_119906.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906042", "story_v_side_old_119906.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play119906043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 119906043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play119906044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1099ui_story"]) and arg_179_1.var_.characterEffect1099ui_story == nil then
				arg_179_1.var_.characterEffect1099ui_story = arg_179_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1099ui_story"]) then
				if arg_179_1.var_.characterEffect1099ui_story and not isNil(arg_179_1.actors_["1099ui_story"]) then
					arg_179_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1099ui_story"]) and arg_179_1.var_.characterEffect1099ui_story then
				arg_179_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.35

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(119906043).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 14 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 14)

				if (14 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 14)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play119906044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 119906044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play119906045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1099ui_story = arg_183_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1099ui_story"].transform.position).z)
				arg_183_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1099ui_story"].transform.localEulerAngles = arg_183_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1099ui_story"].transform.position).z)
				arg_183_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1099ui_story"].transform.localEulerAngles = arg_183_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1099ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1099ui_story == nil then
				arg_183_1.var_.characterEffect1099ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1099ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_2)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1099ui_story then
				arg_183_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_186_3 = 0
			local var_186_4 = 1.1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(119906044).content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 44 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 44)

				if (44 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 44)) > 0 and var_186_4 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_8 and arg_183_1.time_ < var_186_3 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play119906045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 119906045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play119906046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.2

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(119906045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 8 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 8)

				if (8 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 8)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play119906046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 119906046
		arg_191_1.duration_ = 6.37

		local var_191_0 = {
			zh = 6.366,
			ja = 5.333
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play119906047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1099ui_story = arg_191_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1099ui_story"].transform.position).z)
				arg_191_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1099ui_story"].transform.localEulerAngles = arg_191_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_191_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1099ui_story"].transform.position).z)
				arg_191_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1099ui_story"].transform.localEulerAngles = arg_191_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1099ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1099ui_story == nil then
				arg_191_1.var_.characterEffect1099ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1099ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1099ui_story then
				arg_191_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.75

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(119906046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 30 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 30)

				if (30 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 30)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906046", "story_v_side_old_119906.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906046", "story_v_side_old_119906.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_side_old_119906", "119906046", "story_v_side_old_119906.awb")

						arg_191_1:RecordAudio("119906046", var_194_11)
						arg_191_1:RecordAudio("119906046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906046", "story_v_side_old_119906.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906046", "story_v_side_old_119906.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play119906047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 119906047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play119906048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1099ui_story"]) and arg_195_1.var_.characterEffect1099ui_story == nil then
				arg_195_1.var_.characterEffect1099ui_story = arg_195_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1099ui_story"]) then
				if arg_195_1.var_.characterEffect1099ui_story and not isNil(arg_195_1.actors_["1099ui_story"]) then
					arg_195_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1099ui_story"]) and arg_195_1.var_.characterEffect1099ui_story then
				arg_195_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.1

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(119906047).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 4 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 4)

				if (4 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 4)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play119906048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 119906048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play119906049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.475

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(119906048).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 19 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 19)

				if (19 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 19)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play119906049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 119906049
		arg_203_1.duration_ = 5.03

		local var_203_0 = {
			zh = 5.033,
			ja = 3.3
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play119906050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1099ui_story"]) and arg_203_1.var_.characterEffect1099ui_story == nil then
				arg_203_1.var_.characterEffect1099ui_story = arg_203_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1099ui_story"]) then
				if arg_203_1.var_.characterEffect1099ui_story and not isNil(arg_203_1.actors_["1099ui_story"]) then
					arg_203_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1099ui_story"]) and arg_203_1.var_.characterEffect1099ui_story then
				arg_203_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_2 = 0
			local var_206_3 = 0.375

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(119906049)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 15 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 15)

				if (15 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 15)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906049", "story_v_side_old_119906.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906049", "story_v_side_old_119906.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_old_119906", "119906049", "story_v_side_old_119906.awb")

						arg_203_1:RecordAudio("119906049", var_206_9)
						arg_203_1:RecordAudio("119906049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906049", "story_v_side_old_119906.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906049", "story_v_side_old_119906.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play119906050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 119906050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play119906051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1099ui_story"]) and arg_207_1.var_.characterEffect1099ui_story == nil then
				arg_207_1.var_.characterEffect1099ui_story = arg_207_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1099ui_story"]) then
				if arg_207_1.var_.characterEffect1099ui_story and not isNil(arg_207_1.actors_["1099ui_story"]) then
					arg_207_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1099ui_story"]) and arg_207_1.var_.characterEffect1099ui_story then
				arg_207_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.075

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(119906050).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 3 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 3)

				if (3 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 3)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play119906051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 119906051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play119906052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1099ui_story = arg_211_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1099ui_story"].transform.position).z)
				arg_211_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1099ui_story"].transform.localEulerAngles = arg_211_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1099ui_story"].transform.position).z)
				arg_211_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1099ui_story"].transform.localEulerAngles = arg_211_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1099ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1099ui_story == nil then
				arg_211_1.var_.characterEffect1099ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1099ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1099ui_story then
				arg_211_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_214_3 = 0
			local var_214_4 = 1.175

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(119906051).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 47 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 47)

				if (47 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 47)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play119906052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 119906052
		arg_215_1.duration_ = 8.67

		local var_215_0 = {
			zh = 5.633,
			ja = 8.666
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play119906053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1099ui_story = arg_215_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1099ui_story"].transform.position).z)
				arg_215_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1099ui_story"].transform.localEulerAngles = arg_215_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_215_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1099ui_story"].transform.position).z)
				arg_215_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1099ui_story"].transform.localEulerAngles = arg_215_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1099ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1099ui_story == nil then
				arg_215_1.var_.characterEffect1099ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1099ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1099ui_story then
				arg_215_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(119906052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 26 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 26)

				if (26 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 26)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906052", "story_v_side_old_119906.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906052", "story_v_side_old_119906.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_side_old_119906", "119906052", "story_v_side_old_119906.awb")

						arg_215_1:RecordAudio("119906052", var_218_11)
						arg_215_1:RecordAudio("119906052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906052", "story_v_side_old_119906.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906052", "story_v_side_old_119906.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play119906053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 119906053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play119906054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1099ui_story"]) and arg_219_1.var_.characterEffect1099ui_story == nil then
				arg_219_1.var_.characterEffect1099ui_story = arg_219_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1099ui_story"]) then
				if arg_219_1.var_.characterEffect1099ui_story and not isNil(arg_219_1.actors_["1099ui_story"]) then
					arg_219_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1099ui_story"]) and arg_219_1.var_.characterEffect1099ui_story then
				arg_219_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 1.075

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(119906053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 43 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 43)

				if (43 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 43)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play119906054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 119906054
		arg_223_1.duration_ = 8.97

		local var_223_0 = {
			zh = 6.4,
			ja = 8.966
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play119906055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1099ui_story"]) and arg_223_1.var_.characterEffect1099ui_story == nil then
				arg_223_1.var_.characterEffect1099ui_story = arg_223_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1099ui_story"]) then
				if arg_223_1.var_.characterEffect1099ui_story and not isNil(arg_223_1.actors_["1099ui_story"]) then
					arg_223_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1099ui_story"]) and arg_223_1.var_.characterEffect1099ui_story then
				arg_223_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_2 = 0
			local var_226_3 = 0.9

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:GetWordFromCfg(119906054)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 36 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 36)

				if (36 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 36)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906054", "story_v_side_old_119906.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906054", "story_v_side_old_119906.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_side_old_119906", "119906054", "story_v_side_old_119906.awb")

						arg_223_1:RecordAudio("119906054", var_226_9)
						arg_223_1:RecordAudio("119906054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906054", "story_v_side_old_119906.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906054", "story_v_side_old_119906.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play119906055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 119906055
		arg_227_1.duration_ = 8.67

		local var_227_0 = {
			zh = 4.466,
			ja = 8.666
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play119906056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.55

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(119906055)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 22 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 22)

				if (22 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 22)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906055", "story_v_side_old_119906.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906055", "story_v_side_old_119906.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_side_old_119906", "119906055", "story_v_side_old_119906.awb")

						arg_227_1:RecordAudio("119906055", var_230_6)
						arg_227_1:RecordAudio("119906055", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906055", "story_v_side_old_119906.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906055", "story_v_side_old_119906.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play119906056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 119906056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play119906057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1099ui_story"]) and arg_231_1.var_.characterEffect1099ui_story == nil then
				arg_231_1.var_.characterEffect1099ui_story = arg_231_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1099ui_story"]) then
				if arg_231_1.var_.characterEffect1099ui_story and not isNil(arg_231_1.actors_["1099ui_story"]) then
					arg_231_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1099ui_story"]) and arg_231_1.var_.characterEffect1099ui_story then
				arg_231_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 1.3

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(119906056).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 52 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 52)

				if (52 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 52)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play119906057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 119906057
		arg_235_1.duration_ = 3.8

		local var_235_0 = {
			zh = 3.8,
			ja = 2.566
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play119906058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1099ui_story"]) and arg_235_1.var_.characterEffect1099ui_story == nil then
				arg_235_1.var_.characterEffect1099ui_story = arg_235_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1099ui_story"]) then
				if arg_235_1.var_.characterEffect1099ui_story and not isNil(arg_235_1.actors_["1099ui_story"]) then
					arg_235_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1099ui_story"]) and arg_235_1.var_.characterEffect1099ui_story then
				arg_235_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_2 = 0
			local var_238_3 = 0.4

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(119906057)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 16 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 16)

				if (16 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 16)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906057", "story_v_side_old_119906.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906057", "story_v_side_old_119906.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_side_old_119906", "119906057", "story_v_side_old_119906.awb")

						arg_235_1:RecordAudio("119906057", var_238_9)
						arg_235_1:RecordAudio("119906057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906057", "story_v_side_old_119906.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906057", "story_v_side_old_119906.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play119906058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 119906058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play119906059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1099ui_story"]) and arg_239_1.var_.characterEffect1099ui_story == nil then
				arg_239_1.var_.characterEffect1099ui_story = arg_239_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1099ui_story"]) then
				if arg_239_1.var_.characterEffect1099ui_story and not isNil(arg_239_1.actors_["1099ui_story"]) then
					arg_239_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1099ui_story"]) and arg_239_1.var_.characterEffect1099ui_story then
				arg_239_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.5

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(119906058).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 20 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 20)

				if (20 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 20)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play119906059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 119906059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play119906060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.625

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(119906059).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 25 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 25)

				if (25 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 25)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play119906060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 119906060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play119906061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.25

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(119906060).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 50 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 50)

				if (50 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 50)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play119906061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 119906061
		arg_251_1.duration_ = 2

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play119906062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1099ui_story"]) and arg_251_1.var_.characterEffect1099ui_story == nil then
				arg_251_1.var_.characterEffect1099ui_story = arg_251_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1099ui_story"]) then
				if arg_251_1.var_.characterEffect1099ui_story and not isNil(arg_251_1.actors_["1099ui_story"]) then
					arg_251_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1099ui_story"]) and arg_251_1.var_.characterEffect1099ui_story then
				arg_251_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_2")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_2 = 0
			local var_254_3 = 0.125

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:GetWordFromCfg(119906061)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 5 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 5)

				if (5 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 5)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906061", "story_v_side_old_119906.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906061", "story_v_side_old_119906.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_side_old_119906", "119906061", "story_v_side_old_119906.awb")

						arg_251_1:RecordAudio("119906061", var_254_9)
						arg_251_1:RecordAudio("119906061", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906061", "story_v_side_old_119906.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906061", "story_v_side_old_119906.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play119906062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 119906062
		arg_255_1.duration_ = 5.5

		local var_255_0 = {
			zh = 4.8,
			ja = 5.5
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play119906063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.6

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(119906062)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 24 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 24)

				if (24 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 24)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906062", "story_v_side_old_119906.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906062", "story_v_side_old_119906.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_side_old_119906", "119906062", "story_v_side_old_119906.awb")

						arg_255_1:RecordAudio("119906062", var_258_6)
						arg_255_1:RecordAudio("119906062", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906062", "story_v_side_old_119906.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906062", "story_v_side_old_119906.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play119906063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 119906063
		arg_259_1.duration_ = 6.27

		local var_259_0 = {
			zh = 4.166,
			ja = 6.266
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play119906064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_0 = 0
			local var_262_1 = 0.55

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:GetWordFromCfg(119906063)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 22 <= 0 and var_262_1 or var_262_1 * (utf8.len(var_262_3) / 22)

				if (22 <= 0 and var_262_1 or var_262_1 * (utf8.len(var_262_3) / 22)) > 0 and var_262_1 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906063", "story_v_side_old_119906.awb") ~= 0 then
					local var_262_6 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906063", "story_v_side_old_119906.awb") / 1000

					if var_262_6 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_0
					end

					if var_262_2.prefab_name ~= "" and arg_259_1.actors_[var_262_2.prefab_name] ~= nil then
						local var_262_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_2.prefab_name].transform, "story_v_side_old_119906", "119906063", "story_v_side_old_119906.awb")

						arg_259_1:RecordAudio("119906063", var_262_7)
						arg_259_1:RecordAudio("119906063", var_262_7)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906063", "story_v_side_old_119906.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906063", "story_v_side_old_119906.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_8 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_8 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_8

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_8 and arg_259_1.time_ < var_262_0 + var_262_8 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play119906064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 119906064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play119906065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1099ui_story"]) and arg_263_1.var_.characterEffect1099ui_story == nil then
				arg_263_1.var_.characterEffect1099ui_story = arg_263_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1099ui_story"]) then
				if arg_263_1.var_.characterEffect1099ui_story and not isNil(arg_263_1.actors_["1099ui_story"]) then
					arg_263_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1099ui_story"]) and arg_263_1.var_.characterEffect1099ui_story then
				arg_263_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.75

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(119906064).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 30 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 30)

				if (30 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 30)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play119906065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 119906065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play119906066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.425

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(119906065).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 57 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 57)

				if (57 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 57)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play119906066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 119906066
		arg_271_1.duration_ = 5.2

		local var_271_0 = {
			zh = 5.2,
			ja = 2.833
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play119906067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1099ui_story"]) and arg_271_1.var_.characterEffect1099ui_story == nil then
				arg_271_1.var_.characterEffect1099ui_story = arg_271_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1099ui_story"]) then
				if arg_271_1.var_.characterEffect1099ui_story and not isNil(arg_271_1.actors_["1099ui_story"]) then
					arg_271_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1099ui_story"]) and arg_271_1.var_.characterEffect1099ui_story then
				arg_271_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_274_2 = 0
			local var_274_3 = 0.275

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(119906066)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 11 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 11)

				if (11 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 11)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906066", "story_v_side_old_119906.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906066", "story_v_side_old_119906.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_side_old_119906", "119906066", "story_v_side_old_119906.awb")

						arg_271_1:RecordAudio("119906066", var_274_9)
						arg_271_1:RecordAudio("119906066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906066", "story_v_side_old_119906.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906066", "story_v_side_old_119906.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play119906067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 119906067
		arg_275_1.duration_ = 7.63

		local var_275_0 = {
			zh = 7.4,
			ja = 7.633
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play119906068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.85

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(119906067)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 34 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 34)

				if (34 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 34)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906067", "story_v_side_old_119906.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906067", "story_v_side_old_119906.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_side_old_119906", "119906067", "story_v_side_old_119906.awb")

						arg_275_1:RecordAudio("119906067", var_278_6)
						arg_275_1:RecordAudio("119906067", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906067", "story_v_side_old_119906.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906067", "story_v_side_old_119906.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play119906068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 119906068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play119906069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1099ui_story"]) and arg_279_1.var_.characterEffect1099ui_story == nil then
				arg_279_1.var_.characterEffect1099ui_story = arg_279_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1099ui_story"]) then
				if arg_279_1.var_.characterEffect1099ui_story and not isNil(arg_279_1.actors_["1099ui_story"]) then
					arg_279_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1099ui_story"]) and arg_279_1.var_.characterEffect1099ui_story then
				arg_279_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.35

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(119906068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 14 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 14)

				if (14 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 14)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play119906069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 119906069
		arg_283_1.duration_ = 4.23

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play119906070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 1.96599999815226 < arg_283_1.time_ and arg_283_1.time_ <= 1.96599999815226 + arg_286_0 then
				arg_283_1.var_.moveOldPos1099ui_story = arg_283_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 1.96599999815226 <= arg_283_1.time_ and arg_283_1.time_ < 1.96599999815226 + var_286_0 then
				arg_283_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 1.96599999815226) / var_286_0)
				arg_283_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1099ui_story"].transform.position).z)
				arg_283_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1099ui_story"].transform.localEulerAngles = arg_283_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 1.96599999815226 + var_286_0 and arg_283_1.time_ < 1.96599999815226 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1099ui_story"].transform.position).z)
				arg_283_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1099ui_story"].transform.localEulerAngles = arg_283_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1099ui_story"]

			if 1.96599999815226 < arg_283_1.time_ and arg_283_1.time_ <= 1.96599999815226 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1099ui_story == nil then
				arg_283_1.var_.characterEffect1099ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.034000001847744

			if 1.96599999815226 <= arg_283_1.time_ and arg_283_1.time_ < 1.96599999815226 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1099ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 1.96599999815226) / var_286_2)
				end
			end

			if arg_283_1.time_ >= 1.96599999815226 + var_286_2 and arg_283_1.time_ < 1.96599999815226 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1099ui_story then
				arg_283_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_286_3 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_3 + arg_286_0 then
				arg_283_1.mask_.enabled = true
				arg_283_1.mask_.raycastTarget = true

				arg_283_1:SetGaussion(false)
			end

			local var_286_4 = 2

			if var_286_3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_3 + var_286_4 then
				local var_286_5 = Color.New(0, 0, 0)

				var_286_5.a = Mathf.Lerp(0, 1, (arg_283_1.time_ - var_286_3) / var_286_4)
				arg_283_1.mask_.color = var_286_5
			end

			if arg_283_1.time_ >= var_286_3 + var_286_4 and arg_283_1.time_ < var_286_3 + var_286_4 + arg_286_0 then
				local var_286_6 = Color.New(0, 0, 0)

				var_286_6.a = 1
				arg_283_1.mask_.color = var_286_6
			end

			local var_286_7 = 2

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= var_286_7 + arg_286_0 then
				arg_283_1.mask_.enabled = true
				arg_283_1.mask_.raycastTarget = true

				arg_283_1:SetGaussion(false)
			end

			local var_286_8 = 2

			if var_286_7 <= arg_283_1.time_ and arg_283_1.time_ < var_286_7 + var_286_8 then
				local var_286_9 = Color.New(0, 0, 0)

				var_286_9.a = Mathf.Lerp(1, 0, (arg_283_1.time_ - var_286_7) / var_286_8)
				arg_283_1.mask_.color = var_286_9
			end

			if arg_283_1.time_ >= var_286_7 + var_286_8 and arg_283_1.time_ < var_286_7 + var_286_8 + arg_286_0 then
				local var_286_10 = Color.New(0, 0, 0)

				arg_283_1.mask_.enabled = false
				var_286_10.a = 0
				arg_283_1.mask_.color = var_286_10
			end

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 then
				arg_283_1.fswbg_:SetActive(true)
				arg_283_1.dialog_:SetActive(false)

				arg_283_1.fswtw_.percent = 0
				arg_283_1.fswt_.text = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(119906069).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.fswt_)

				arg_283_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_283_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_283_1.fswtw_:SetDirty()

				arg_283_1.typewritterCharCountI18N = 0

				SetActive(arg_283_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_283_1:ShowNextGo(false)
			end

			local var_286_11 = 2.01666666666667

			if 2.01666666666667 < arg_283_1.time_ and arg_283_1.time_ <= var_286_11 + arg_286_0 then
				arg_283_1.var_.oldValueTypewriter = arg_283_1.fswtw_.percent

				SetActive(arg_283_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_283_1:ShowNextGo(false)
			end

			local var_286_12 = 31
			local var_286_13 = 2.06666666666667
			local var_286_14, var_286_15 = arg_283_1:GetPercentByPara(arg_283_1:FormatText(arg_283_1:GetWordFromCfg(119906069).content), 1)

			if var_286_11 < arg_283_1.time_ and arg_283_1.time_ <= var_286_11 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0

				local var_286_16 = var_286_12 <= 0 and var_286_13 or var_286_13 * ((var_286_15 - arg_283_1.typewritterCharCountI18N) / var_286_12)

				if (var_286_12 <= 0 and var_286_13 or var_286_13 * ((var_286_15 - arg_283_1.typewritterCharCountI18N) / var_286_12)) > 0 and var_286_13 < var_286_16 then
					arg_283_1.talkMaxDuration = var_286_16

					if var_286_16 + var_286_11 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_11
					end
				end
			end

			local var_286_17 = math.max(2.06666666666667, arg_283_1.talkMaxDuration)

			if var_286_11 <= arg_283_1.time_ and arg_283_1.time_ < var_286_11 + var_286_17 then
				arg_283_1.fswtw_.percent = Mathf.Lerp(arg_283_1.var_.oldValueTypewriter, var_286_14, (arg_283_1.time_ - var_286_11) / var_286_17)
				arg_283_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_283_1.fswtw_:SetDirty()
			end

			if arg_283_1.time_ >= var_286_11 + var_286_17 and arg_283_1.time_ < var_286_11 + var_286_17 + arg_286_0 then
				arg_283_1.fswtw_.percent = var_286_14

				arg_283_1.fswtw_:SetDirty()
				arg_283_1:ShowNextGo(true)

				arg_283_1.typewritterCharCountI18N = var_286_15
			end

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 then
				local var_286_18 = arg_283_1.fswbg_.transform:Find("textbox/adapt/content") or arg_283_1.fswbg_.transform:Find("textbox/content")
				local var_286_19 = arg_283_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_286_20 = var_286_18:GetComponent("RectTransform")

				var_286_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_286_20.offsetMin = Vector2.New(0, 0)
				var_286_20.offsetMax = Vector2.New(0, 0)
			end

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 then
				local var_286_21 = arg_283_1.bgs_.STblack

				arg_283_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_286_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_286_22 = var_286_21:GetComponent("SpriteRenderer")

				if var_286_22 and var_286_22.sprite then
					local var_286_23 = 2 * (var_286_21.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_286_21.transform.localScale = Vector3.New(var_286_23 / var_286_22.sprite.bounds.size.y < var_286_23 * manager.ui.mainCameraCom_.aspect / var_286_22.sprite.bounds.size.x and var_286_23 * manager.ui.mainCameraCom_.aspect / var_286_22.sprite.bounds.size.x or var_286_23 / var_286_22.sprite.bounds.size.y, var_286_23 / var_286_22.sprite.bounds.size.y < var_286_23 * manager.ui.mainCameraCom_.aspect / var_286_22.sprite.bounds.size.x and var_286_23 * manager.ui.mainCameraCom_.aspect / var_286_22.sprite.bounds.size.x or var_286_23 / var_286_22.sprite.bounds.size.y, 0)
				end

				for iter_286_0, iter_286_1 in pairs(arg_283_1.bgs_) do
					if iter_286_0 ~= "STblack" then
						iter_286_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play119906070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 119906070
		arg_287_1.duration_ = 7

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play119906071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_0 = 2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				local var_290_1 = Color.New(0, 0, 0)

				var_290_1.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.mask_.color = var_290_1
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				local var_290_2 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_2.a = 0
				arg_287_1.mask_.color = var_290_2
			end

			local var_290_3 = "C06b"

			if arg_287_1.bgs_.C06b == nil then
				local var_290_4 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_290_3)
				var_290_4.name = var_290_3
				var_290_4.transform.parent = arg_287_1.stage_.transform
				var_290_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_[var_290_3] = var_290_4
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				local var_290_5 = arg_287_1.bgs_.C06b

				arg_287_1.bgs_.C06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_6 = var_290_5:GetComponent("SpriteRenderer")

				if var_290_6 and var_290_6.sprite then
					local var_290_7 = 2 * (var_290_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_5.transform.localScale = Vector3.New(var_290_7 / var_290_6.sprite.bounds.size.y < var_290_7 * manager.ui.mainCameraCom_.aspect / var_290_6.sprite.bounds.size.x and var_290_7 * manager.ui.mainCameraCom_.aspect / var_290_6.sprite.bounds.size.x or var_290_7 / var_290_6.sprite.bounds.size.y, var_290_7 / var_290_6.sprite.bounds.size.y < var_290_7 * manager.ui.mainCameraCom_.aspect / var_290_6.sprite.bounds.size.x and var_290_7 * manager.ui.mainCameraCom_.aspect / var_290_6.sprite.bounds.size.x or var_290_7 / var_290_6.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "C06b" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.fswbg_:SetActive(false)
				arg_287_1.dialog_:SetActive(false)
				SetActive(arg_287_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_287_1:ShowNextGo(false)
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_8 = 2
			local var_290_9 = 0.775

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_10 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_10:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_11 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(119906070).content)

				arg_287_1.text_.text = var_290_11

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_13 = 31 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 31)

				if (31 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 31)) > 0 and var_290_9 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13
					var_290_8 = var_290_8 + 0.3

					if var_290_13 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_11
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = var_290_8 + 0.3
			local var_290_15 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_14 + var_290_15 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_14) / var_290_15

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_14 + var_290_15 and arg_287_1.time_ < var_290_14 + var_290_15 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play119906071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 119906071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play119906072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.3

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

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(119906071).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 52 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 52)

				if (52 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 52)) > 0 and var_296_0 < var_296_3 then
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
	Play119906072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 119906072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play119906073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.35

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(119906072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 14 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 14)

				if (14 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 14)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play119906073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 119906073
		arg_301_1.duration_ = 3.77

		local var_301_0 = {
			zh = 3.766,
			ja = 2.4
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play119906074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1099ui_story = arg_301_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1099ui_story"].transform.position).z)
				arg_301_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1099ui_story"].transform.localEulerAngles = arg_301_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_301_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1099ui_story"].transform.position).z)
				arg_301_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1099ui_story"].transform.localEulerAngles = arg_301_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1099ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1099ui_story == nil then
				arg_301_1.var_.characterEffect1099ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1099ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1099ui_story then
				arg_301_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_4 = 0
			local var_304_5 = 0.45

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(119906073)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 18 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 18)

				if (18 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 18)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906073", "story_v_side_old_119906.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906073", "story_v_side_old_119906.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_side_old_119906", "119906073", "story_v_side_old_119906.awb")

						arg_301_1:RecordAudio("119906073", var_304_11)
						arg_301_1:RecordAudio("119906073", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906073", "story_v_side_old_119906.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906073", "story_v_side_old_119906.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play119906074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 119906074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play119906075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1099ui_story"]) and arg_305_1.var_.characterEffect1099ui_story == nil then
				arg_305_1.var_.characterEffect1099ui_story = arg_305_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1099ui_story"]) then
				if arg_305_1.var_.characterEffect1099ui_story and not isNil(arg_305_1.actors_["1099ui_story"]) then
					arg_305_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1099ui_story"]) and arg_305_1.var_.characterEffect1099ui_story then
				arg_305_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.125

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(119906074).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 5 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 5)

				if (5 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 5)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play119906075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 119906075
		arg_309_1.duration_ = 4.37

		local var_309_0 = {
			zh = 1,
			ja = 4.366
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play119906076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1099ui_story"]) and arg_309_1.var_.characterEffect1099ui_story == nil then
				arg_309_1.var_.characterEffect1099ui_story = arg_309_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1099ui_story"]) then
				if arg_309_1.var_.characterEffect1099ui_story and not isNil(arg_309_1.actors_["1099ui_story"]) then
					arg_309_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1099ui_story"]) and arg_309_1.var_.characterEffect1099ui_story then
				arg_309_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_312_2 = 0
			local var_312_3 = 0.075

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(119906075)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 3 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 3)

				if (3 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 3)) > 0 and var_312_3 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906075", "story_v_side_old_119906.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906075", "story_v_side_old_119906.awb") / 1000

					if var_312_8 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_2
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_side_old_119906", "119906075", "story_v_side_old_119906.awb")

						arg_309_1:RecordAudio("119906075", var_312_9)
						arg_309_1:RecordAudio("119906075", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906075", "story_v_side_old_119906.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906075", "story_v_side_old_119906.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_10 and arg_309_1.time_ < var_312_2 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play119906076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 119906076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play119906077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1099ui_story"]) and arg_313_1.var_.characterEffect1099ui_story == nil then
				arg_313_1.var_.characterEffect1099ui_story = arg_313_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1099ui_story"]) then
				if arg_313_1.var_.characterEffect1099ui_story and not isNil(arg_313_1.actors_["1099ui_story"]) then
					arg_313_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1099ui_story"]) and arg_313_1.var_.characterEffect1099ui_story then
				arg_313_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.925

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(119906076).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 37 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 37)

				if (37 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 37)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play119906077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 119906077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play119906078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.375

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(119906077).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 15 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 15)

				if (15 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 15)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play119906078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 119906078
		arg_321_1.duration_ = 4.57

		local var_321_0 = {
			zh = 4.2,
			ja = 4.566
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play119906079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1099ui_story"]) and arg_321_1.var_.characterEffect1099ui_story == nil then
				arg_321_1.var_.characterEffect1099ui_story = arg_321_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1099ui_story"]) then
				if arg_321_1.var_.characterEffect1099ui_story and not isNil(arg_321_1.actors_["1099ui_story"]) then
					arg_321_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1099ui_story"]) and arg_321_1.var_.characterEffect1099ui_story then
				arg_321_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action434")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_324_2 = 0
			local var_324_3 = 0.425

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(119906078)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 17 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 17)

				if (17 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 17)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906078", "story_v_side_old_119906.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906078", "story_v_side_old_119906.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_side_old_119906", "119906078", "story_v_side_old_119906.awb")

						arg_321_1:RecordAudio("119906078", var_324_9)
						arg_321_1:RecordAudio("119906078", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906078", "story_v_side_old_119906.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906078", "story_v_side_old_119906.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play119906079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 119906079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play119906080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1099ui_story"]) and arg_325_1.var_.characterEffect1099ui_story == nil then
				arg_325_1.var_.characterEffect1099ui_story = arg_325_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1099ui_story"]) then
				if arg_325_1.var_.characterEffect1099ui_story and not isNil(arg_325_1.actors_["1099ui_story"]) then
					arg_325_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1099ui_story"]) and arg_325_1.var_.characterEffect1099ui_story then
				arg_325_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 0.05

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(119906079).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 2 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 2)

				if (2 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 2)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play119906080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 119906080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play119906081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.45

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(119906080).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 18 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 18)

				if (18 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 18)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play119906081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 119906081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play119906082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.625

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(119906081).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 25 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 25)

				if (25 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 25)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play119906082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 119906082
		arg_337_1.duration_ = 8.63

		local var_337_0 = {
			zh = 8.633,
			ja = 7.966
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play119906083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1099ui_story"]) and arg_337_1.var_.characterEffect1099ui_story == nil then
				arg_337_1.var_.characterEffect1099ui_story = arg_337_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1099ui_story"]) then
				if arg_337_1.var_.characterEffect1099ui_story and not isNil(arg_337_1.actors_["1099ui_story"]) then
					arg_337_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1099ui_story"]) and arg_337_1.var_.characterEffect1099ui_story then
				arg_337_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_340_2 = 0
			local var_340_3 = 1.05

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(119906082)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 42 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 42)

				if (42 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 42)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906082", "story_v_side_old_119906.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906082", "story_v_side_old_119906.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_side_old_119906", "119906082", "story_v_side_old_119906.awb")

						arg_337_1:RecordAudio("119906082", var_340_9)
						arg_337_1:RecordAudio("119906082", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906082", "story_v_side_old_119906.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906082", "story_v_side_old_119906.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play119906083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 119906083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play119906084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1099ui_story"]) and arg_341_1.var_.characterEffect1099ui_story == nil then
				arg_341_1.var_.characterEffect1099ui_story = arg_341_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1099ui_story"]) then
				if arg_341_1.var_.characterEffect1099ui_story and not isNil(arg_341_1.actors_["1099ui_story"]) then
					arg_341_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1099ui_story"]) and arg_341_1.var_.characterEffect1099ui_story then
				arg_341_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_344_1 = 0
			local var_344_2 = 0.15

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(119906083).content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 6 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 6)

				if (6 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 6)) > 0 and var_344_2 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_1 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_1
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_6 = math.max(var_344_2, arg_341_1.talkMaxDuration)

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_6 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_1) / var_344_6

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_1 + var_344_6 and arg_341_1.time_ < var_344_1 + var_344_6 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play119906084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 119906084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play119906085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.425

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(119906084).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 17 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 17)

				if (17 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 17)) > 0 and var_348_0 < var_348_3 then
					arg_345_1.talkMaxDuration = var_348_3

					if var_348_3 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_3 + 0
					end
				end

				arg_345_1.text_.text = var_348_1
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_4 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_4

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play119906085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 119906085
		arg_349_1.duration_ = 4.3

		local var_349_0 = {
			zh = 4.066,
			ja = 4.3
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play119906086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1099ui_story"]) and arg_349_1.var_.characterEffect1099ui_story == nil then
				arg_349_1.var_.characterEffect1099ui_story = arg_349_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1099ui_story"]) then
				if arg_349_1.var_.characterEffect1099ui_story and not isNil(arg_349_1.actors_["1099ui_story"]) then
					arg_349_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1099ui_story"]) and arg_349_1.var_.characterEffect1099ui_story then
				arg_349_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_352_2 = 0
			local var_352_3 = 0.45

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(119906085)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 18 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 18)

				if (18 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 18)) > 0 and var_352_3 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906085", "story_v_side_old_119906.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906085", "story_v_side_old_119906.awb") / 1000

					if var_352_8 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_2
					end

					if var_352_4.prefab_name ~= "" and arg_349_1.actors_[var_352_4.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_4.prefab_name].transform, "story_v_side_old_119906", "119906085", "story_v_side_old_119906.awb")

						arg_349_1:RecordAudio("119906085", var_352_9)
						arg_349_1:RecordAudio("119906085", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906085", "story_v_side_old_119906.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906085", "story_v_side_old_119906.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_10 and arg_349_1.time_ < var_352_2 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play119906086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 119906086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play119906087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1099ui_story"]) and arg_353_1.var_.characterEffect1099ui_story == nil then
				arg_353_1.var_.characterEffect1099ui_story = arg_353_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1099ui_story"]) then
				if arg_353_1.var_.characterEffect1099ui_story and not isNil(arg_353_1.actors_["1099ui_story"]) then
					arg_353_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1099ui_story"]) and arg_353_1.var_.characterEffect1099ui_story then
				arg_353_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.1

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(119906086).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 4 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 4)

				if (4 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 4)) > 0 and var_356_2 < var_356_5 then
					arg_353_1.talkMaxDuration = var_356_5

					if var_356_5 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_6 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_6 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_6

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_6 and arg_353_1.time_ < var_356_1 + var_356_6 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play119906087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 119906087
		arg_357_1.duration_ = 7.27

		local var_357_0 = {
			zh = 7.266,
			ja = 5.233
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play119906088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1099ui_story"]) and arg_357_1.var_.characterEffect1099ui_story == nil then
				arg_357_1.var_.characterEffect1099ui_story = arg_357_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1099ui_story"]) then
				if arg_357_1.var_.characterEffect1099ui_story and not isNil(arg_357_1.actors_["1099ui_story"]) then
					arg_357_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1099ui_story"]) and arg_357_1.var_.characterEffect1099ui_story then
				arg_357_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_2 = 0
			local var_360_3 = 0.8

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:GetWordFromCfg(119906087)
				local var_360_5 = arg_357_1:FormatText(var_360_4.content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 32 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 32)

				if (32 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 32)) > 0 and var_360_3 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906087", "story_v_side_old_119906.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906087", "story_v_side_old_119906.awb") / 1000

					if var_360_8 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_2
					end

					if var_360_4.prefab_name ~= "" and arg_357_1.actors_[var_360_4.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_4.prefab_name].transform, "story_v_side_old_119906", "119906087", "story_v_side_old_119906.awb")

						arg_357_1:RecordAudio("119906087", var_360_9)
						arg_357_1:RecordAudio("119906087", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906087", "story_v_side_old_119906.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906087", "story_v_side_old_119906.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_10 and arg_357_1.time_ < var_360_2 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play119906088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 119906088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play119906089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1099ui_story"]) and arg_361_1.var_.characterEffect1099ui_story == nil then
				arg_361_1.var_.characterEffect1099ui_story = arg_361_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1099ui_story"]) then
				if arg_361_1.var_.characterEffect1099ui_story and not isNil(arg_361_1.actors_["1099ui_story"]) then
					arg_361_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1099ui_story"]) and arg_361_1.var_.characterEffect1099ui_story then
				arg_361_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.475

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(119906088).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 19 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 19)

				if (19 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 19)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play119906089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 119906089
		arg_365_1.duration_ = 9.73

		local var_365_0 = {
			zh = 7.333,
			ja = 9.733
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play119906090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1099ui_story"]) and arg_365_1.var_.characterEffect1099ui_story == nil then
				arg_365_1.var_.characterEffect1099ui_story = arg_365_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1099ui_story"]) then
				if arg_365_1.var_.characterEffect1099ui_story and not isNil(arg_365_1.actors_["1099ui_story"]) then
					arg_365_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1099ui_story"]) and arg_365_1.var_.characterEffect1099ui_story then
				arg_365_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_368_2 = 0
			local var_368_3 = 0.95

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(119906089)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 38 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 38)

				if (38 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 38)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906089", "story_v_side_old_119906.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906089", "story_v_side_old_119906.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_side_old_119906", "119906089", "story_v_side_old_119906.awb")

						arg_365_1:RecordAudio("119906089", var_368_9)
						arg_365_1:RecordAudio("119906089", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906089", "story_v_side_old_119906.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906089", "story_v_side_old_119906.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play119906090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 119906090
		arg_369_1.duration_ = 7.03

		local var_369_0 = {
			zh = 4.766,
			ja = 7.033
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play119906091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1099ui_story"]) and arg_369_1.var_.characterEffect1099ui_story == nil then
				arg_369_1.var_.characterEffect1099ui_story = arg_369_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1099ui_story"]) then
				if arg_369_1.var_.characterEffect1099ui_story and not isNil(arg_369_1.actors_["1099ui_story"]) then
					arg_369_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1099ui_story"]) and arg_369_1.var_.characterEffect1099ui_story then
				arg_369_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action443")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_372_2 = 0
			local var_372_3 = 0.65

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_4 = arg_369_1:GetWordFromCfg(119906090)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 26 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 26)

				if (26 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 26)) > 0 and var_372_3 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906090", "story_v_side_old_119906.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906090", "story_v_side_old_119906.awb") / 1000

					if var_372_8 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_2
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_side_old_119906", "119906090", "story_v_side_old_119906.awb")

						arg_369_1:RecordAudio("119906090", var_372_9)
						arg_369_1:RecordAudio("119906090", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906090", "story_v_side_old_119906.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906090", "story_v_side_old_119906.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_10 and arg_369_1.time_ < var_372_2 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play119906091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 119906091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play119906092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1099ui_story"]) and arg_373_1.var_.characterEffect1099ui_story == nil then
				arg_373_1.var_.characterEffect1099ui_story = arg_373_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1099ui_story"]) then
				if arg_373_1.var_.characterEffect1099ui_story and not isNil(arg_373_1.actors_["1099ui_story"]) then
					arg_373_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1099ui_story"]) and arg_373_1.var_.characterEffect1099ui_story then
				arg_373_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_376_1 = 0
			local var_376_2 = 0.55

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(119906091).content)

				arg_373_1.text_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 30 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 30)

				if (30 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 30)) > 0 and var_376_2 < var_376_5 then
					arg_373_1.talkMaxDuration = var_376_5

					if var_376_5 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_3
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_6 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_6 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_6

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_6 and arg_373_1.time_ < var_376_1 + var_376_6 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play119906092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 119906092
		arg_377_1.duration_ = 15.63

		local var_377_0 = {
			zh = 10.666,
			ja = 15.633
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play119906093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1099ui_story"]) and arg_377_1.var_.characterEffect1099ui_story == nil then
				arg_377_1.var_.characterEffect1099ui_story = arg_377_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1099ui_story"]) then
				if arg_377_1.var_.characterEffect1099ui_story and not isNil(arg_377_1.actors_["1099ui_story"]) then
					arg_377_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1099ui_story"]) and arg_377_1.var_.characterEffect1099ui_story then
				arg_377_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_2")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_380_2 = 0
			local var_380_3 = 1.3

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_4 = arg_377_1:GetWordFromCfg(119906092)
				local var_380_5 = arg_377_1:FormatText(var_380_4.content)

				arg_377_1.text_.text = var_380_5

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_7 = 52 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 52)

				if (52 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 52)) > 0 and var_380_3 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_2
					end
				end

				arg_377_1.text_.text = var_380_5
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906092", "story_v_side_old_119906.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906092", "story_v_side_old_119906.awb") / 1000

					if var_380_8 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_2
					end

					if var_380_4.prefab_name ~= "" and arg_377_1.actors_[var_380_4.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_4.prefab_name].transform, "story_v_side_old_119906", "119906092", "story_v_side_old_119906.awb")

						arg_377_1:RecordAudio("119906092", var_380_9)
						arg_377_1:RecordAudio("119906092", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906092", "story_v_side_old_119906.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906092", "story_v_side_old_119906.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_3, arg_377_1.talkMaxDuration)

			if var_380_2 <= arg_377_1.time_ and arg_377_1.time_ < var_380_2 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_2) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_2 + var_380_10 and arg_377_1.time_ < var_380_2 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play119906093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 119906093
		arg_381_1.duration_ = 6.33

		local var_381_0 = {
			zh = 5.3,
			ja = 6.333
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play119906094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 1.96599999815226 < arg_381_1.time_ and arg_381_1.time_ <= 1.96599999815226 + arg_384_0 then
				arg_381_1.var_.moveOldPos1099ui_story = arg_381_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 1.96599999815226 <= arg_381_1.time_ and arg_381_1.time_ < 1.96599999815226 + var_384_0 then
				arg_381_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 1.96599999815226) / var_384_0)
				arg_381_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1099ui_story"].transform.position).z)
				arg_381_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1099ui_story"].transform.localEulerAngles = arg_381_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 1.96599999815226 + var_384_0 and arg_381_1.time_ < 1.96599999815226 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1099ui_story"].transform.position).z)
				arg_381_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1099ui_story"].transform.localEulerAngles = arg_381_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1099ui_story"]

			if 1.96599999815226 < arg_381_1.time_ and arg_381_1.time_ <= 1.96599999815226 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1099ui_story == nil then
				arg_381_1.var_.characterEffect1099ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.034000001847744

			if 1.96599999815226 <= arg_381_1.time_ and arg_381_1.time_ < 1.96599999815226 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1099ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 1.96599999815226) / var_384_2)
				end
			end

			if arg_381_1.time_ >= 1.96599999815226 + var_384_2 and arg_381_1.time_ < 1.96599999815226 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1099ui_story then
				arg_381_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_384_3 = 0

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_3 + arg_384_0 then
				arg_381_1.mask_.enabled = true
				arg_381_1.mask_.raycastTarget = true

				arg_381_1:SetGaussion(false)
			end

			local var_384_4 = 2

			if var_384_3 <= arg_381_1.time_ and arg_381_1.time_ < var_384_3 + var_384_4 then
				local var_384_5 = Color.New(0, 0, 0)

				var_384_5.a = Mathf.Lerp(0, 1, (arg_381_1.time_ - var_384_3) / var_384_4)
				arg_381_1.mask_.color = var_384_5
			end

			if arg_381_1.time_ >= var_384_3 + var_384_4 and arg_381_1.time_ < var_384_3 + var_384_4 + arg_384_0 then
				local var_384_6 = Color.New(0, 0, 0)

				var_384_6.a = 1
				arg_381_1.mask_.color = var_384_6
			end

			local var_384_7 = 2

			if 2 < arg_381_1.time_ and arg_381_1.time_ <= var_384_7 + arg_384_0 then
				arg_381_1.mask_.enabled = true
				arg_381_1.mask_.raycastTarget = true

				arg_381_1:SetGaussion(false)
			end

			local var_384_8 = 2

			if var_384_7 <= arg_381_1.time_ and arg_381_1.time_ < var_384_7 + var_384_8 then
				local var_384_9 = Color.New(0, 0, 0)

				var_384_9.a = Mathf.Lerp(1, 0, (arg_381_1.time_ - var_384_7) / var_384_8)
				arg_381_1.mask_.color = var_384_9
			end

			if arg_381_1.time_ >= var_384_7 + var_384_8 and arg_381_1.time_ < var_384_7 + var_384_8 + arg_384_0 then
				local var_384_10 = Color.New(0, 0, 0)

				arg_381_1.mask_.enabled = false
				var_384_10.a = 0
				arg_381_1.mask_.color = var_384_10
			end

			if 2 < arg_381_1.time_ and arg_381_1.time_ <= 2 + arg_384_0 then
				local var_384_11 = arg_381_1.bgs_.STblack

				arg_381_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_384_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_384_12 = var_384_11:GetComponent("SpriteRenderer")

				if var_384_12 and var_384_12.sprite then
					local var_384_13 = 2 * (var_384_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_384_11.transform.localScale = Vector3.New(var_384_13 / var_384_12.sprite.bounds.size.y < var_384_13 * manager.ui.mainCameraCom_.aspect / var_384_12.sprite.bounds.size.x and var_384_13 * manager.ui.mainCameraCom_.aspect / var_384_12.sprite.bounds.size.x or var_384_13 / var_384_12.sprite.bounds.size.y, var_384_13 / var_384_12.sprite.bounds.size.y < var_384_13 * manager.ui.mainCameraCom_.aspect / var_384_12.sprite.bounds.size.x and var_384_13 * manager.ui.mainCameraCom_.aspect / var_384_12.sprite.bounds.size.x or var_384_13 / var_384_12.sprite.bounds.size.y, 0)
				end

				for iter_384_0, iter_384_1 in pairs(arg_381_1.bgs_) do
					if iter_384_0 ~= "STblack" then
						iter_384_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_384_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_381_1.bgmTxt_.text ~= var_384_16 and arg_381_1.bgmTxt_.text ~= "" then
						if arg_381_1.bgmTxt2_.text ~= "" then
							arg_381_1.bgmTxt_.text = arg_381_1.bgmTxt2_.text
						end

						arg_381_1.bgmTxt2_.text = var_384_16

						arg_381_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_381_1.bgmTxt_.text = var_384_16
						arg_381_1.bgmTxt2_.text = var_384_16
					end

					if arg_381_1.bgmTimer then
						arg_381_1.bgmTimer:Stop()

						arg_381_1.bgmTimer = nil
					end

					if arg_381_1.settingData.show_music_name == 1 then
						arg_381_1.musicController:SetSelectedState("show")
						arg_381_1.musicAnimator_:Play("open", 0, 0)

						if arg_381_1.settingData.music_time ~= 0 then
							arg_381_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_381_1.settingData.music_time), function()
								if arg_381_1 == nil or isNil(arg_381_1.bgmTxt_) then
									return
								end

								arg_381_1.musicController:SetSelectedState("hide")
								arg_381_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_381_1.frameCnt_ <= 1 then
				arg_381_1.dialog_:SetActive(false)
			end

			local var_384_17 = 3.8
			local var_384_18 = 0.175

			if 3.8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_17 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0

				arg_381_1.dialog_:SetActive(true)

				arg_381_1.dialogCg_.alpha = 0

				local var_384_19 = LeanTween.value(arg_381_1.dialog_, 0, 1, 0.3)

				var_384_19:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_381_1.dialogCg_.alpha = arg_386_0
				end))
				var_384_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_381_1.dialog_)
					var_384_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_381_1.duration_ = arg_381_1.duration_ + 0.3

				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_20 = arg_381_1:GetWordFromCfg(119906093)
				local var_384_21 = arg_381_1:FormatText(var_384_20.content)

				arg_381_1.text_.text = var_384_21

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_23 = 7 <= 0 and var_384_18 or var_384_18 * (utf8.len(var_384_21) / 7)

				if (7 <= 0 and var_384_18 or var_384_18 * (utf8.len(var_384_21) / 7)) > 0 and var_384_18 < var_384_23 then
					arg_381_1.talkMaxDuration = var_384_23
					var_384_17 = var_384_17 + 0.3

					if var_384_23 + var_384_17 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_23 + var_384_17
					end
				end

				arg_381_1.text_.text = var_384_21
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906093", "story_v_side_old_119906.awb") ~= 0 then
					local var_384_24 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906093", "story_v_side_old_119906.awb") / 1000

					if var_384_24 + var_384_17 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_24 + var_384_17
					end

					if var_384_20.prefab_name ~= "" and arg_381_1.actors_[var_384_20.prefab_name] ~= nil then
						local var_384_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_20.prefab_name].transform, "story_v_side_old_119906", "119906093", "story_v_side_old_119906.awb")

						arg_381_1:RecordAudio("119906093", var_384_25)
						arg_381_1:RecordAudio("119906093", var_384_25)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906093", "story_v_side_old_119906.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906093", "story_v_side_old_119906.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_26 = var_384_17 + 0.3
			local var_384_27 = math.max(var_384_18, arg_381_1.talkMaxDuration)

			if var_384_17 + 0.3 <= arg_381_1.time_ and arg_381_1.time_ < var_384_26 + var_384_27 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_26) / var_384_27

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_26 + var_384_27 and arg_381_1.time_ < var_384_26 + var_384_27 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play119906094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 119906094
		arg_388_1.duration_ = 11.4

		local var_388_0 = {
			zh = 11.332999999999,
			ja = 11.399999999999
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play119906095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if arg_388_1.bgs_.S0902 == nil then
				local var_391_0 = Object.Instantiate(arg_388_1.paintGo_)

				var_391_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0902")
				var_391_0.name = "S0902"
				var_391_0.transform.parent = arg_388_1.stage_.transform
				var_391_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_388_1.bgs_.S0902 = var_391_0
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				local var_391_1 = arg_388_1.bgs_.S0902

				arg_388_1.bgs_.S0902.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_391_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_2 = var_391_1:GetComponent("SpriteRenderer")

				if var_391_2 and var_391_2.sprite then
					local var_391_3 = 2 * (var_391_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_391_1.transform.localScale = Vector3.New(var_391_3 / var_391_2.sprite.bounds.size.y < var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x and var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x or var_391_3 / var_391_2.sprite.bounds.size.y, var_391_3 / var_391_2.sprite.bounds.size.y < var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x and var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x or var_391_3 / var_391_2.sprite.bounds.size.y, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "S0902" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_4 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_5 = 2

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_5 then
				local var_391_6 = Color.New(0, 0, 0)

				var_391_6.a = Mathf.Lerp(1, 0, (arg_388_1.time_ - var_391_4) / var_391_5)
				arg_388_1.mask_.color = var_391_6
			end

			if arg_388_1.time_ >= var_391_4 + var_391_5 and arg_388_1.time_ < var_391_4 + var_391_5 + arg_391_0 then
				local var_391_7 = Color.New(0, 0, 0)

				arg_388_1.mask_.enabled = false
				var_391_7.a = 0
				arg_388_1.mask_.color = var_391_7
			end

			local var_391_8 = 0

			arg_388_1.isInRecall_ = false

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.screenFilterGo_:SetActive(true)

				arg_388_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_391_2, iter_391_3 in pairs(arg_388_1.actors_) do
					for iter_391_4, iter_391_5 in ipairs((iter_391_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_391_5.color = iter_391_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_391_9 = 0.2

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_9 then
				arg_388_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_388_1.time_ - var_391_8) / var_391_9)
			end

			if arg_388_1.time_ >= var_391_8 + var_391_9 and arg_388_1.time_ < var_391_8 + var_391_9 + arg_391_0 then
				arg_388_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_391_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_12 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_12

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_12
						arg_388_1.bgmTxt2_.text = var_391_12
					end

					if arg_388_1.bgmTimer then
						arg_388_1.bgmTimer:Stop()

						arg_388_1.bgmTimer = nil
					end

					if arg_388_1.settingData.show_music_name == 1 then
						arg_388_1.musicController:SetSelectedState("show")
						arg_388_1.musicAnimator_:Play("open", 0, 0)

						if arg_388_1.settingData.music_time ~= 0 then
							arg_388_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_388_1.settingData.music_time), function()
								if arg_388_1 == nil or isNil(arg_388_1.bgmTxt_) then
									return
								end

								arg_388_1.musicController:SetSelectedState("hide")
								arg_388_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.9 < arg_388_1.time_ and arg_388_1.time_ <= 1.9 + arg_391_0 then
				arg_388_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_391_15 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_15 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_15

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_15
						arg_388_1.bgmTxt2_.text = var_391_15
					end

					if arg_388_1.bgmTimer then
						arg_388_1.bgmTimer:Stop()

						arg_388_1.bgmTimer = nil
					end

					if arg_388_1.settingData.show_music_name == 1 then
						arg_388_1.musicController:SetSelectedState("show")
						arg_388_1.musicAnimator_:Play("open", 0, 0)

						if arg_388_1.settingData.music_time ~= 0 then
							arg_388_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_388_1.settingData.music_time), function()
								if arg_388_1 == nil or isNil(arg_388_1.bgmTxt_) then
									return
								end

								arg_388_1.musicController:SetSelectedState("hide")
								arg_388_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_16 = 1.999999999999
			local var_391_17 = 1.225

			if 1.999999999999 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_18 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_18:setOnUpdate(LuaHelper.FloatAction(function(arg_394_0)
					arg_388_1.dialogCg_.alpha = arg_394_0
				end))
				var_391_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_19 = arg_388_1:GetWordFromCfg(119906094)
				local var_391_20 = arg_388_1:FormatText(var_391_19.content)

				arg_388_1.text_.text = var_391_20

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_22 = 49 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_20) / 49)

				if (49 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_20) / 49)) > 0 and var_391_17 < var_391_22 then
					arg_388_1.talkMaxDuration = var_391_22
					var_391_16 = var_391_16 + 0.3

					if var_391_22 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_16
					end
				end

				arg_388_1.text_.text = var_391_20
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906094", "story_v_side_old_119906.awb") ~= 0 then
					local var_391_23 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906094", "story_v_side_old_119906.awb") / 1000

					if var_391_23 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_16
					end

					if var_391_19.prefab_name ~= "" and arg_388_1.actors_[var_391_19.prefab_name] ~= nil then
						local var_391_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_19.prefab_name].transform, "story_v_side_old_119906", "119906094", "story_v_side_old_119906.awb")

						arg_388_1:RecordAudio("119906094", var_391_24)
						arg_388_1:RecordAudio("119906094", var_391_24)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906094", "story_v_side_old_119906.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906094", "story_v_side_old_119906.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_25 = var_391_16 + 0.3
			local var_391_26 = math.max(var_391_17, arg_388_1.talkMaxDuration)

			if var_391_16 + 0.3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_25 + var_391_26 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_25) / var_391_26

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_25 + var_391_26 and arg_388_1.time_ < var_391_25 + var_391_26 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play119906095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 119906095
		arg_396_1.duration_ = 11.7

		local var_396_0 = {
			zh = 8.833,
			ja = 11.7
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play119906096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if arg_396_1.bgs_.R9901 == nil then
				local var_399_0 = Object.Instantiate(arg_396_1.paintGo_)

				var_399_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R9901")
				var_399_0.name = "R9901"
				var_399_0.transform.parent = arg_396_1.stage_.transform
				var_399_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.bgs_.R9901 = var_399_0
			end

			if 2 < arg_396_1.time_ and arg_396_1.time_ <= 2 + arg_399_0 then
				local var_399_1 = arg_396_1.bgs_.R9901

				arg_396_1.bgs_.R9901.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_399_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_399_2 = var_399_1:GetComponent("SpriteRenderer")

				if var_399_2 and var_399_2.sprite then
					local var_399_3 = 2 * (var_399_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_399_1.transform.localScale = Vector3.New(var_399_3 / var_399_2.sprite.bounds.size.y < var_399_3 * manager.ui.mainCameraCom_.aspect / var_399_2.sprite.bounds.size.x and var_399_3 * manager.ui.mainCameraCom_.aspect / var_399_2.sprite.bounds.size.x or var_399_3 / var_399_2.sprite.bounds.size.y, var_399_3 / var_399_2.sprite.bounds.size.y < var_399_3 * manager.ui.mainCameraCom_.aspect / var_399_2.sprite.bounds.size.x and var_399_3 * manager.ui.mainCameraCom_.aspect / var_399_2.sprite.bounds.size.x or var_399_3 / var_399_2.sprite.bounds.size.y, 0)
				end

				for iter_399_0, iter_399_1 in pairs(arg_396_1.bgs_) do
					if iter_399_0 ~= "R9901" then
						iter_399_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_399_4 = 0

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1.mask_.enabled = true
				arg_396_1.mask_.raycastTarget = true

				arg_396_1:SetGaussion(false)
			end

			local var_399_5 = 2

			if var_399_4 <= arg_396_1.time_ and arg_396_1.time_ < var_399_4 + var_399_5 then
				local var_399_6 = Color.New(0, 0, 0)

				var_399_6.a = Mathf.Lerp(0, 1, (arg_396_1.time_ - var_399_4) / var_399_5)
				arg_396_1.mask_.color = var_399_6
			end

			if arg_396_1.time_ >= var_399_4 + var_399_5 and arg_396_1.time_ < var_399_4 + var_399_5 + arg_399_0 then
				local var_399_7 = Color.New(0, 0, 0)

				var_399_7.a = 1
				arg_396_1.mask_.color = var_399_7
			end

			local var_399_8 = 2

			if 2 < arg_396_1.time_ and arg_396_1.time_ <= var_399_8 + arg_399_0 then
				arg_396_1.mask_.enabled = true
				arg_396_1.mask_.raycastTarget = true

				arg_396_1:SetGaussion(false)
			end

			local var_399_9 = 2

			if var_399_8 <= arg_396_1.time_ and arg_396_1.time_ < var_399_8 + var_399_9 then
				local var_399_10 = Color.New(0, 0, 0)

				var_399_10.a = Mathf.Lerp(1, 0, (arg_396_1.time_ - var_399_8) / var_399_9)
				arg_396_1.mask_.color = var_399_10
			end

			if arg_396_1.time_ >= var_399_8 + var_399_9 and arg_396_1.time_ < var_399_8 + var_399_9 + arg_399_0 then
				local var_399_11 = Color.New(0, 0, 0)

				arg_396_1.mask_.enabled = false
				var_399_11.a = 0
				arg_396_1.mask_.color = var_399_11
			end

			if arg_396_1.frameCnt_ <= 1 then
				arg_396_1.dialog_:SetActive(false)
			end

			local var_399_12 = 3.8
			local var_399_13 = 0.775

			if 3.8 < arg_396_1.time_ and arg_396_1.time_ <= var_399_12 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0

				arg_396_1.dialog_:SetActive(true)

				arg_396_1.dialogCg_.alpha = 0

				local var_399_14 = LeanTween.value(arg_396_1.dialog_, 0, 1, 0.3)

				var_399_14:setOnUpdate(LuaHelper.FloatAction(function(arg_400_0)
					arg_396_1.dialogCg_.alpha = arg_400_0
				end))
				var_399_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_396_1.dialog_)
					var_399_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_396_1.duration_ = arg_396_1.duration_ + 0.3

				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_15 = arg_396_1:GetWordFromCfg(119906095)
				local var_399_16 = arg_396_1:FormatText(var_399_15.content)

				arg_396_1.text_.text = var_399_16

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_18 = 31 <= 0 and var_399_13 or var_399_13 * (utf8.len(var_399_16) / 31)

				if (31 <= 0 and var_399_13 or var_399_13 * (utf8.len(var_399_16) / 31)) > 0 and var_399_13 < var_399_18 then
					arg_396_1.talkMaxDuration = var_399_18
					var_399_12 = var_399_12 + 0.3

					if var_399_18 + var_399_12 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_18 + var_399_12
					end
				end

				arg_396_1.text_.text = var_399_16
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906095", "story_v_side_old_119906.awb") ~= 0 then
					local var_399_19 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906095", "story_v_side_old_119906.awb") / 1000

					if var_399_19 + var_399_12 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_19 + var_399_12
					end

					if var_399_15.prefab_name ~= "" and arg_396_1.actors_[var_399_15.prefab_name] ~= nil then
						local var_399_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_15.prefab_name].transform, "story_v_side_old_119906", "119906095", "story_v_side_old_119906.awb")

						arg_396_1:RecordAudio("119906095", var_399_20)
						arg_396_1:RecordAudio("119906095", var_399_20)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906095", "story_v_side_old_119906.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906095", "story_v_side_old_119906.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_21 = var_399_12 + 0.3
			local var_399_22 = math.max(var_399_13, arg_396_1.talkMaxDuration)

			if var_399_12 + 0.3 <= arg_396_1.time_ and arg_396_1.time_ < var_399_21 + var_399_22 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_21) / var_399_22

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_21 + var_399_22 and arg_396_1.time_ < var_399_21 + var_399_22 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play119906096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 119906096
		arg_402_1.duration_ = 9.93

		local var_402_0 = {
			zh = 9.933,
			ja = 9.766
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play119906097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 2 < arg_402_1.time_ and arg_402_1.time_ <= 2 + arg_405_0 then
				local var_405_0 = arg_402_1.bgs_.STblack

				arg_402_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_405_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_405_1 = var_405_0:GetComponent("SpriteRenderer")

				if var_405_1 and var_405_1.sprite then
					local var_405_2 = 2 * (var_405_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_405_0.transform.localScale = Vector3.New(var_405_2 / var_405_1.sprite.bounds.size.y < var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x and var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x or var_405_2 / var_405_1.sprite.bounds.size.y, var_405_2 / var_405_1.sprite.bounds.size.y < var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x and var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x or var_405_2 / var_405_1.sprite.bounds.size.y, 0)
				end

				for iter_405_0, iter_405_1 in pairs(arg_402_1.bgs_) do
					if iter_405_0 ~= "STblack" then
						iter_405_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_405_3 = 0

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_3 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_4 = 2

			if var_405_3 <= arg_402_1.time_ and arg_402_1.time_ < var_405_3 + var_405_4 then
				local var_405_5 = Color.New(0, 0, 0)

				var_405_5.a = Mathf.Lerp(0, 1, (arg_402_1.time_ - var_405_3) / var_405_4)
				arg_402_1.mask_.color = var_405_5
			end

			if arg_402_1.time_ >= var_405_3 + var_405_4 and arg_402_1.time_ < var_405_3 + var_405_4 + arg_405_0 then
				local var_405_6 = Color.New(0, 0, 0)

				var_405_6.a = 1
				arg_402_1.mask_.color = var_405_6
			end

			local var_405_7 = 2

			if 2 < arg_402_1.time_ and arg_402_1.time_ <= var_405_7 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_8 = 2

			if var_405_7 <= arg_402_1.time_ and arg_402_1.time_ < var_405_7 + var_405_8 then
				local var_405_9 = Color.New(0, 0, 0)

				var_405_9.a = Mathf.Lerp(1, 0, (arg_402_1.time_ - var_405_7) / var_405_8)
				arg_402_1.mask_.color = var_405_9
			end

			if arg_402_1.time_ >= var_405_7 + var_405_8 and arg_402_1.time_ < var_405_7 + var_405_8 + arg_405_0 then
				local var_405_10 = Color.New(0, 0, 0)

				arg_402_1.mask_.enabled = false
				var_405_10.a = 0
				arg_402_1.mask_.color = var_405_10
			end

			if arg_402_1.frameCnt_ <= 1 then
				arg_402_1.dialog_:SetActive(false)
			end

			local var_405_11 = 2.6
			local var_405_12 = 0.9

			if 2.6 < arg_402_1.time_ and arg_402_1.time_ <= var_405_11 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0

				arg_402_1.dialog_:SetActive(true)

				arg_402_1.dialogCg_.alpha = 0

				local var_405_13 = LeanTween.value(arg_402_1.dialog_, 0, 1, 0.3)

				var_405_13:setOnUpdate(LuaHelper.FloatAction(function(arg_406_0)
					arg_402_1.dialogCg_.alpha = arg_406_0
				end))
				var_405_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_402_1.dialog_)
					var_405_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_402_1.duration_ = arg_402_1.duration_ + 0.3

				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_14 = arg_402_1:GetWordFromCfg(119906096)
				local var_405_15 = arg_402_1:FormatText(var_405_14.content)

				arg_402_1.text_.text = var_405_15

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_17 = 36 <= 0 and var_405_12 or var_405_12 * (utf8.len(var_405_15) / 36)

				if (36 <= 0 and var_405_12 or var_405_12 * (utf8.len(var_405_15) / 36)) > 0 and var_405_12 < var_405_17 then
					arg_402_1.talkMaxDuration = var_405_17
					var_405_11 = var_405_11 + 0.3

					if var_405_17 + var_405_11 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_17 + var_405_11
					end
				end

				arg_402_1.text_.text = var_405_15
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906096", "story_v_side_old_119906.awb") ~= 0 then
					local var_405_18 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906096", "story_v_side_old_119906.awb") / 1000

					if var_405_18 + var_405_11 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_18 + var_405_11
					end

					if var_405_14.prefab_name ~= "" and arg_402_1.actors_[var_405_14.prefab_name] ~= nil then
						local var_405_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_14.prefab_name].transform, "story_v_side_old_119906", "119906096", "story_v_side_old_119906.awb")

						arg_402_1:RecordAudio("119906096", var_405_19)
						arg_402_1:RecordAudio("119906096", var_405_19)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906096", "story_v_side_old_119906.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906096", "story_v_side_old_119906.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_20 = var_405_11 + 0.3
			local var_405_21 = math.max(var_405_12, arg_402_1.talkMaxDuration)

			if var_405_11 + 0.3 <= arg_402_1.time_ and arg_402_1.time_ < var_405_20 + var_405_21 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_20) / var_405_21

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_20 + var_405_21 and arg_402_1.time_ < var_405_20 + var_405_21 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play119906097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 119906097
		arg_408_1.duration_ = 2.57

		local var_408_0 = {
			zh = 1.333,
			ja = 2.566
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play119906098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.15

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:GetWordFromCfg(119906097)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 6 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 6)

				if (6 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 6)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906097", "story_v_side_old_119906.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906097", "story_v_side_old_119906.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_side_old_119906", "119906097", "story_v_side_old_119906.awb")

						arg_408_1:RecordAudio("119906097", var_411_6)
						arg_408_1:RecordAudio("119906097", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906097", "story_v_side_old_119906.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906097", "story_v_side_old_119906.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play119906098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 119906098
		arg_412_1.duration_ = 7

		local var_412_0 = {
			zh = 7,
			ja = 4
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play119906099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.mask_.enabled = true
				arg_412_1.mask_.raycastTarget = true

				arg_412_1:SetGaussion(false)
			end

			local var_415_0 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				local var_415_1 = Color.New(0, 0, 0)

				var_415_1.a = Mathf.Lerp(1, 0, (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.mask_.color = var_415_1
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				local var_415_2 = Color.New(0, 0, 0)

				arg_412_1.mask_.enabled = false
				var_415_2.a = 0
				arg_412_1.mask_.color = var_415_2
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				local var_415_3 = arg_412_1.bgs_.C06b

				arg_412_1.bgs_.C06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_415_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_415_4 = var_415_3:GetComponent("SpriteRenderer")

				if var_415_4 and var_415_4.sprite then
					local var_415_5 = 2 * (var_415_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_415_3.transform.localScale = Vector3.New(var_415_5 / var_415_4.sprite.bounds.size.y < var_415_5 * manager.ui.mainCameraCom_.aspect / var_415_4.sprite.bounds.size.x and var_415_5 * manager.ui.mainCameraCom_.aspect / var_415_4.sprite.bounds.size.x or var_415_5 / var_415_4.sprite.bounds.size.y, var_415_5 / var_415_4.sprite.bounds.size.y < var_415_5 * manager.ui.mainCameraCom_.aspect / var_415_4.sprite.bounds.size.x and var_415_5 * manager.ui.mainCameraCom_.aspect / var_415_4.sprite.bounds.size.x or var_415_5 / var_415_4.sprite.bounds.size.y, 0)
				end

				for iter_415_0, iter_415_1 in pairs(arg_412_1.bgs_) do
					if iter_415_0 ~= "C06b" then
						iter_415_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_415_6 = 0

			arg_412_1.isInRecall_ = false

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.screenFilterGo_:SetActive(false)

				for iter_415_2, iter_415_3 in pairs(arg_412_1.actors_) do
					for iter_415_4, iter_415_5 in ipairs((iter_415_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_415_5.color = iter_415_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_415_7 = 0.1

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_7 then
				arg_412_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_412_1.time_ - var_415_6) / var_415_7)
			end

			if arg_412_1.time_ >= var_415_6 + var_415_7 and arg_412_1.time_ < var_415_6 + var_415_7 + arg_415_0 then
				arg_412_1.screenFilterEffect_.weight = 0
			end

			if arg_412_1.frameCnt_ <= 1 then
				arg_412_1.dialog_:SetActive(false)
			end

			local var_415_8 = 2
			local var_415_9 = 0.55

			if 2 < arg_412_1.time_ and arg_412_1.time_ <= var_415_8 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0

				arg_412_1.dialog_:SetActive(true)

				arg_412_1.dialogCg_.alpha = 0

				local var_415_10 = LeanTween.value(arg_412_1.dialog_, 0, 1, 0.3)

				var_415_10:setOnUpdate(LuaHelper.FloatAction(function(arg_416_0)
					arg_412_1.dialogCg_.alpha = arg_416_0
				end))
				var_415_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_412_1.dialog_)
					var_415_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_412_1.duration_ = arg_412_1.duration_ + 0.3

				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_11 = arg_412_1:GetWordFromCfg(119906098)
				local var_415_12 = arg_412_1:FormatText(var_415_11.content)

				arg_412_1.text_.text = var_415_12

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_14 = 22 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_12) / 22)

				if (22 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_12) / 22)) > 0 and var_415_9 < var_415_14 then
					arg_412_1.talkMaxDuration = var_415_14
					var_415_8 = var_415_8 + 0.3

					if var_415_14 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_14 + var_415_8
					end
				end

				arg_412_1.text_.text = var_415_12
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906098", "story_v_side_old_119906.awb") ~= 0 then
					local var_415_15 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906098", "story_v_side_old_119906.awb") / 1000

					if var_415_15 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_15 + var_415_8
					end

					if var_415_11.prefab_name ~= "" and arg_412_1.actors_[var_415_11.prefab_name] ~= nil then
						local var_415_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_11.prefab_name].transform, "story_v_side_old_119906", "119906098", "story_v_side_old_119906.awb")

						arg_412_1:RecordAudio("119906098", var_415_16)
						arg_412_1:RecordAudio("119906098", var_415_16)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906098", "story_v_side_old_119906.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906098", "story_v_side_old_119906.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_17 = var_415_8 + 0.3
			local var_415_18 = math.max(var_415_9, arg_412_1.talkMaxDuration)

			if var_415_8 + 0.3 <= arg_412_1.time_ and arg_412_1.time_ < var_415_17 + var_415_18 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_17) / var_415_18

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_17 + var_415_18 and arg_412_1.time_ < var_415_17 + var_415_18 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play119906099 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 119906099
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play119906100(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.1

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(119906099).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 4 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 4)

				if (4 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 4)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play119906100 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 119906100
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play119906101(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.35

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(119906100).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 14 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 14)

				if (14 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 14)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play119906101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 119906101
		arg_426_1.duration_ = 9

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play119906102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.mask_.enabled = true
				arg_426_1.mask_.raycastTarget = true

				arg_426_1:SetGaussion(false)
			end

			local var_429_0 = 2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				local var_429_1 = Color.New(0, 0, 0)

				var_429_1.a = Mathf.Lerp(0, 1, (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.mask_.color = var_429_1
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				local var_429_2 = Color.New(0, 0, 0)

				var_429_2.a = 1
				arg_426_1.mask_.color = var_429_2
			end

			local var_429_3 = 2

			if 2 < arg_426_1.time_ and arg_426_1.time_ <= var_429_3 + arg_429_0 then
				arg_426_1.mask_.enabled = true
				arg_426_1.mask_.raycastTarget = true

				arg_426_1:SetGaussion(false)
			end

			local var_429_4 = 2

			if var_429_3 <= arg_426_1.time_ and arg_426_1.time_ < var_429_3 + var_429_4 then
				local var_429_5 = Color.New(0, 0, 0)

				var_429_5.a = Mathf.Lerp(1, 0, (arg_426_1.time_ - var_429_3) / var_429_4)
				arg_426_1.mask_.color = var_429_5
			end

			if arg_426_1.time_ >= var_429_3 + var_429_4 and arg_426_1.time_ < var_429_3 + var_429_4 + arg_429_0 then
				local var_429_6 = Color.New(0, 0, 0)

				arg_426_1.mask_.enabled = false
				var_429_6.a = 0
				arg_426_1.mask_.color = var_429_6
			end

			if arg_426_1.frameCnt_ <= 1 then
				arg_426_1.dialog_:SetActive(false)
			end

			local var_429_7 = 4
			local var_429_8 = 0.2

			if 4 < arg_426_1.time_ and arg_426_1.time_ <= var_429_7 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0

				arg_426_1.dialog_:SetActive(true)

				arg_426_1.dialogCg_.alpha = 0

				local var_429_9 = LeanTween.value(arg_426_1.dialog_, 0, 1, 0.3)

				var_429_9:setOnUpdate(LuaHelper.FloatAction(function(arg_430_0)
					arg_426_1.dialogCg_.alpha = arg_430_0
				end))
				var_429_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_426_1.dialog_)
					var_429_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_426_1.duration_ = arg_426_1.duration_ + 0.3

				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_10 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(119906101).content)

				arg_426_1.text_.text = var_429_10

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_12 = 8 <= 0 and var_429_8 or var_429_8 * (utf8.len(var_429_10) / 8)

				if (8 <= 0 and var_429_8 or var_429_8 * (utf8.len(var_429_10) / 8)) > 0 and var_429_8 < var_429_12 then
					arg_426_1.talkMaxDuration = var_429_12
					var_429_7 = var_429_7 + 0.3

					if var_429_12 + var_429_7 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_12 + var_429_7
					end
				end

				arg_426_1.text_.text = var_429_10
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_13 = var_429_7 + 0.3
			local var_429_14 = math.max(var_429_8, arg_426_1.talkMaxDuration)

			if var_429_7 + 0.3 <= arg_426_1.time_ and arg_426_1.time_ < var_429_13 + var_429_14 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_13) / var_429_14

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_13 + var_429_14 and arg_426_1.time_ < var_429_13 + var_429_14 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play119906102 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 119906102
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play119906103(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 1.2

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(119906102).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 48 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 48)

				if (48 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 48)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play119906103 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 119906103
		arg_436_1.duration_ = 8.5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play119906104(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if arg_436_1.bgs_.R9902 == nil then
				local var_439_0 = Object.Instantiate(arg_436_1.paintGo_)

				var_439_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R9902")
				var_439_0.name = "R9902"
				var_439_0.transform.parent = arg_436_1.stage_.transform
				var_439_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_436_1.bgs_.R9902 = var_439_0
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				local var_439_1 = arg_436_1.bgs_.R9902

				arg_436_1.bgs_.R9902.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_439_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_439_2 = var_439_1:GetComponent("SpriteRenderer")

				if var_439_2 and var_439_2.sprite then
					local var_439_3 = 2 * (var_439_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_439_1.transform.localScale = Vector3.New(var_439_3 / var_439_2.sprite.bounds.size.y < var_439_3 * manager.ui.mainCameraCom_.aspect / var_439_2.sprite.bounds.size.x and var_439_3 * manager.ui.mainCameraCom_.aspect / var_439_2.sprite.bounds.size.x or var_439_3 / var_439_2.sprite.bounds.size.y, var_439_3 / var_439_2.sprite.bounds.size.y < var_439_3 * manager.ui.mainCameraCom_.aspect / var_439_2.sprite.bounds.size.x and var_439_3 * manager.ui.mainCameraCom_.aspect / var_439_2.sprite.bounds.size.x or var_439_3 / var_439_2.sprite.bounds.size.y, 0)
				end

				for iter_439_0, iter_439_1 in pairs(arg_436_1.bgs_) do
					if iter_439_0 ~= "R9902" then
						iter_439_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_439_4 = 0

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.mask_.enabled = true
				arg_436_1.mask_.raycastTarget = true

				arg_436_1:SetGaussion(false)
			end

			local var_439_5 = 3.5

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_5 then
				local var_439_6 = Color.New(1, 1, 1)

				var_439_6.a = Mathf.Lerp(1, 0, (arg_436_1.time_ - var_439_4) / var_439_5)
				arg_436_1.mask_.color = var_439_6
			end

			if arg_436_1.time_ >= var_439_4 + var_439_5 and arg_436_1.time_ < var_439_4 + var_439_5 + arg_439_0 then
				local var_439_7 = Color.New(1, 1, 1)

				arg_436_1.mask_.enabled = false
				var_439_7.a = 0
				arg_436_1.mask_.color = var_439_7
			end

			local var_439_8 = arg_436_1.bgs_.R9902.transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPosR9902 = var_439_8.localPosition
			end

			local var_439_9 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_9 then
				var_439_8.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPosR9902, Vector3.New(2, 0, 0.5), (arg_436_1.time_ - 0) / var_439_9)
			end

			if arg_436_1.time_ >= 0 + var_439_9 and arg_436_1.time_ < 0 + var_439_9 + arg_439_0 then
				var_439_8.localPosition = Vector3.New(2, 0, 0.5)
			end

			local var_439_10 = arg_436_1.bgs_.R9902.transform

			if 0.0166666666666666 < arg_436_1.time_ and arg_436_1.time_ <= 0.0166666666666666 + arg_439_0 then
				arg_436_1.var_.moveOldPosR9902 = var_439_10.localPosition
			end

			local var_439_11 = 3.5

			if 0.0166666666666666 <= arg_436_1.time_ and arg_436_1.time_ < 0.0166666666666666 + var_439_11 then
				var_439_10.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPosR9902, Vector3.New(2, -0.5, 0.5), (arg_436_1.time_ - 0.0166666666666666) / var_439_11)
			end

			if arg_436_1.time_ >= 0.0166666666666666 + var_439_11 and arg_436_1.time_ < 0.0166666666666666 + var_439_11 + arg_439_0 then
				var_439_10.localPosition = Vector3.New(2, -0.5, 0.5)
			end

			local var_439_12 = "R9902_blur"

			if arg_436_1.bgs_.R9902_blur == nil then
				local var_439_13 = Object.Instantiate(arg_436_1.blurPaintGo_)

				var_439_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_439_12)
				var_439_13.name = var_439_12
				var_439_13.transform.parent = arg_436_1.stage_.transform
				var_439_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_436_1.bgs_[var_439_12] = var_439_13
			end

			local var_439_14 = 0
			local var_439_15 = arg_436_1.bgs_[var_439_12]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_14 + arg_439_0 then
				var_439_15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_439_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_439_16 = var_439_15:GetComponent("SpriteRenderer")

				if var_439_16 and var_439_16.sprite then
					local var_439_17 = 2 * (var_439_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_439_15.transform.localScale = Vector3.New(var_439_17 / var_439_16.sprite.bounds.size.y < var_439_17 * manager.ui.mainCameraCom_.aspect / var_439_16.sprite.bounds.size.x and var_439_17 * manager.ui.mainCameraCom_.aspect / var_439_16.sprite.bounds.size.x or var_439_17 / var_439_16.sprite.bounds.size.y, var_439_17 / var_439_16.sprite.bounds.size.y < var_439_17 * manager.ui.mainCameraCom_.aspect / var_439_16.sprite.bounds.size.x and var_439_17 * manager.ui.mainCameraCom_.aspect / var_439_16.sprite.bounds.size.x or var_439_17 / var_439_16.sprite.bounds.size.y, 0)
				end
			end

			local var_439_18 = 1

			if var_439_14 <= arg_436_1.time_ and arg_436_1.time_ < var_439_14 + var_439_18 then
				local var_439_19 = Color.New(1, 1, 1)

				var_439_19.a = Mathf.Lerp(0, 1, (arg_436_1.time_ - var_439_14) / var_439_18)

				var_439_15:GetComponent("SpriteRenderer").material:SetColor("_Color", var_439_19)
			end

			local var_439_20 = "R9902_blur"

			if arg_436_1.bgs_.R9902_blur == nil then
				local var_439_21 = Object.Instantiate(arg_436_1.paintGo_)

				var_439_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_439_20)
				var_439_21.name = var_439_20
				var_439_21.transform.parent = arg_436_1.stage_.transform
				var_439_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_436_1.bgs_[var_439_20] = var_439_21
			end

			local var_439_22 = arg_436_1.bgs_.R9902_blur.transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPosR9902_blur = var_439_22.localPosition
			end

			local var_439_23 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_23 then
				var_439_22.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPosR9902_blur, Vector3.New(2, 0, 0.5), (arg_436_1.time_ - 0) / var_439_23)
			end

			if arg_436_1.time_ >= 0 + var_439_23 and arg_436_1.time_ < 0 + var_439_23 + arg_439_0 then
				var_439_22.localPosition = Vector3.New(2, 0, 0.5)
			end

			local var_439_24 = arg_436_1.bgs_.R9902_blur.transform

			if 0.0166666666666667 < arg_436_1.time_ and arg_436_1.time_ <= 0.0166666666666667 + arg_439_0 then
				arg_436_1.var_.moveOldPosR9902_blur = var_439_24.localPosition
			end

			local var_439_25 = 3.5

			if 0.0166666666666667 <= arg_436_1.time_ and arg_436_1.time_ < 0.0166666666666667 + var_439_25 then
				var_439_24.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPosR9902_blur, Vector3.New(2, -0.5, 0.5), (arg_436_1.time_ - 0.0166666666666667) / var_439_25)
			end

			if arg_436_1.time_ >= 0.0166666666666667 + var_439_25 and arg_436_1.time_ < 0.0166666666666667 + var_439_25 + arg_439_0 then
				var_439_24.localPosition = Vector3.New(2, -0.5, 0.5)
			end

			if arg_436_1.frameCnt_ <= 1 then
				arg_436_1.dialog_:SetActive(false)
			end

			local var_439_26 = 3.5
			local var_439_27 = 0.05

			if 3.5 < arg_436_1.time_ and arg_436_1.time_ <= var_439_26 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0

				arg_436_1.dialog_:SetActive(true)

				arg_436_1.dialogCg_.alpha = 0

				local var_439_28 = LeanTween.value(arg_436_1.dialog_, 0, 1, 0.3)

				var_439_28:setOnUpdate(LuaHelper.FloatAction(function(arg_440_0)
					arg_436_1.dialogCg_.alpha = arg_440_0
				end))
				var_439_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_436_1.dialog_)
					var_439_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_436_1.duration_ = arg_436_1.duration_ + 0.3

				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_29 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(119906103).content)

				arg_436_1.text_.text = var_439_29

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_31 = 2 <= 0 and var_439_27 or var_439_27 * (utf8.len(var_439_29) / 2)

				if (2 <= 0 and var_439_27 or var_439_27 * (utf8.len(var_439_29) / 2)) > 0 and var_439_27 < var_439_31 then
					arg_436_1.talkMaxDuration = var_439_31
					var_439_26 = var_439_26 + 0.3

					if var_439_31 + var_439_26 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_31 + var_439_26
					end
				end

				arg_436_1.text_.text = var_439_29
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_32 = var_439_26 + 0.3
			local var_439_33 = math.max(var_439_27, arg_436_1.talkMaxDuration)

			if var_439_26 + 0.3 <= arg_436_1.time_ and arg_436_1.time_ < var_439_32 + var_439_33 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_32) / var_439_33

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_32 + var_439_33 and arg_436_1.time_ < var_439_32 + var_439_33 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9902_blur",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9902_blur",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play119906104 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 119906104
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play119906105(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if arg_442_1.bgs_.R9902_blur == nil then
				local var_445_0 = Object.Instantiate(arg_442_1.blurPaintGo_)

				var_445_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R9902_blur")
				var_445_0.name = "R9902_blur"
				var_445_0.transform.parent = arg_442_1.stage_.transform
				var_445_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.bgs_.R9902_blur = var_445_0
			end

			local var_445_1 = 0
			local var_445_2 = arg_442_1.bgs_.R9902_blur

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				var_445_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_445_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_3 = var_445_2:GetComponent("SpriteRenderer")

				if var_445_3 and var_445_3.sprite then
					local var_445_4 = 2 * (var_445_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_445_2.transform.localScale = Vector3.New(var_445_4 / var_445_3.sprite.bounds.size.y < var_445_4 * manager.ui.mainCameraCom_.aspect / var_445_3.sprite.bounds.size.x and var_445_4 * manager.ui.mainCameraCom_.aspect / var_445_3.sprite.bounds.size.x or var_445_4 / var_445_3.sprite.bounds.size.y, var_445_4 / var_445_3.sprite.bounds.size.y < var_445_4 * manager.ui.mainCameraCom_.aspect / var_445_3.sprite.bounds.size.x and var_445_4 * manager.ui.mainCameraCom_.aspect / var_445_3.sprite.bounds.size.x or var_445_4 / var_445_3.sprite.bounds.size.y, 0)
				end
			end

			local var_445_5 = 3

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_5 then
				local var_445_6 = Color.New(1, 1, 1)

				var_445_6.a = Mathf.Lerp(1, 0, (arg_442_1.time_ - var_445_1) / var_445_5)

				var_445_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_445_6)
			end

			local var_445_7 = 0

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_7 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			if arg_442_1.time_ >= var_445_7 + 1.5 and arg_442_1.time_ < var_445_7 + 1.5 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end

			local var_445_8 = 0
			local var_445_9 = 0.225

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_10 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(119906104).content)

				arg_442_1.text_.text = var_445_10

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_12 = 9 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_10) / 9)

				if (9 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_10) / 9)) > 0 and var_445_9 < var_445_12 then
					arg_442_1.talkMaxDuration = var_445_12

					if var_445_12 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_12 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_10
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_13 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_13 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_13

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_13 and arg_442_1.time_ < var_445_8 + var_445_13 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play119906105 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 119906105
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play119906106(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.6

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_1 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(119906105).content)

				arg_446_1.text_.text = var_449_1

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_3 = 24 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 24)

				if (24 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 24)) > 0 and var_449_0 < var_449_3 then
					arg_446_1.talkMaxDuration = var_449_3

					if var_449_3 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_3 + 0
					end
				end

				arg_446_1.text_.text = var_449_1
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_4 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_4 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_4

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_4 and arg_446_1.time_ < 0 + var_449_4 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play119906106 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 119906106
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play119906107(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.775

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_1 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(119906106).content)

				arg_450_1.text_.text = var_453_1

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_3 = 31 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 31)

				if (31 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 31)) > 0 and var_453_0 < var_453_3 then
					arg_450_1.talkMaxDuration = var_453_3

					if var_453_3 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_3 + 0
					end
				end

				arg_450_1.text_.text = var_453_1
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_4 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_4

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play119906107 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 119906107
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play119906108(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.825

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(119906107).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 33 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 33)

				if (33 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 33)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play119906108 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 119906108
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play119906109(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0.425

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_1 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(119906108).content)

				arg_458_1.text_.text = var_461_1

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_3 = 17 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_1) / 17)

				if (17 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_1) / 17)) > 0 and var_461_0 < var_461_3 then
					arg_458_1.talkMaxDuration = var_461_3

					if var_461_3 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_3 + 0
					end
				end

				arg_458_1.text_.text = var_461_1
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_4 = math.max(var_461_0, arg_458_1.talkMaxDuration)

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - 0) / var_461_4

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play119906109 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 119906109
		arg_462_1.duration_ = 7.87

		local var_462_0 = {
			zh = 7.86633333333333,
			ja = 6.93333333333333
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play119906110(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPosR9902 = arg_462_1.bgs_.R9902.transform.localPosition
			end

			local var_465_0 = 4

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 then
				arg_462_1.bgs_.R9902.transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPosR9902, Vector3.New(2, 0.5, 0.5), (arg_462_1.time_ - 0) / var_465_0)
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 then
				arg_462_1.bgs_.R9902.transform.localPosition = Vector3.New(2, 0.5, 0.5)
			end

			local var_465_1 = 0

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.allBtn_.enabled = false
			end

			if arg_462_1.time_ >= var_465_1 + 4 and arg_462_1.time_ < var_465_1 + 4 + arg_465_0 then
				arg_462_1.allBtn_.enabled = true
			end

			if arg_462_1.frameCnt_ <= 1 then
				arg_462_1.dialog_:SetActive(false)
			end

			local var_465_2 = 2.63333333333333
			local var_465_3 = 0.55

			if 2.63333333333333 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0

				arg_462_1.dialog_:SetActive(true)

				arg_462_1.dialogCg_.alpha = 0

				local var_465_4 = LeanTween.value(arg_462_1.dialog_, 0, 1, 0.3)

				var_465_4:setOnUpdate(LuaHelper.FloatAction(function(arg_466_0)
					arg_462_1.dialogCg_.alpha = arg_466_0
				end))
				var_465_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_462_1.dialog_)
					var_465_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_462_1.duration_ = arg_462_1.duration_ + 0.3

				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_5 = arg_462_1:GetWordFromCfg(119906109)
				local var_465_6 = arg_462_1:FormatText(var_465_5.content)

				arg_462_1.text_.text = var_465_6

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_8 = 22 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_6) / 22)

				if (22 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_6) / 22)) > 0 and var_465_3 < var_465_8 then
					arg_462_1.talkMaxDuration = var_465_8
					var_465_2 = var_465_2 + 0.3

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_6
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906109", "story_v_side_old_119906.awb") ~= 0 then
					local var_465_9 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906109", "story_v_side_old_119906.awb") / 1000

					if var_465_9 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_2
					end

					if var_465_5.prefab_name ~= "" and arg_462_1.actors_[var_465_5.prefab_name] ~= nil then
						local var_465_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_5.prefab_name].transform, "story_v_side_old_119906", "119906109", "story_v_side_old_119906.awb")

						arg_462_1:RecordAudio("119906109", var_465_10)
						arg_462_1:RecordAudio("119906109", var_465_10)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906109", "story_v_side_old_119906.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906109", "story_v_side_old_119906.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_11 = var_465_2 + 0.3
			local var_465_12 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 + 0.3 <= arg_462_1.time_ and arg_462_1.time_ < var_465_11 + var_465_12 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_11) / var_465_12

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_11 + var_465_12 and arg_462_1.time_ < var_465_11 + var_465_12 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play119906110 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 119906110
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play119906111(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.575

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(119906110).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 23 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 23)

				if (23 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 23)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play119906111 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 119906111
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play119906112(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPosR9902 = arg_472_1.bgs_.R9902.transform.localPosition
			end

			local var_475_0 = 4

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 then
				arg_472_1.bgs_.R9902.transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPosR9902, Vector3.New(2, 0, 0.5), (arg_472_1.time_ - 0) / var_475_0)
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 then
				arg_472_1.bgs_.R9902.transform.localPosition = Vector3.New(2, 0, 0.5)
			end

			local var_475_1 = 0

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.allBtn_.enabled = false
			end

			if arg_472_1.time_ >= var_475_1 + 4 and arg_472_1.time_ < var_475_1 + 4 + arg_475_0 then
				arg_472_1.allBtn_.enabled = true
			end

			local var_475_2 = 0
			local var_475_3 = 0.2

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_2 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_4 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(119906111).content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_6 = 8 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_4) / 8)

				if (8 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_4) / 8)) > 0 and var_475_3 < var_475_6 then
					arg_472_1.talkMaxDuration = var_475_6

					if var_475_6 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_2
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_3, arg_472_1.talkMaxDuration)

			if var_475_2 <= arg_472_1.time_ and arg_472_1.time_ < var_475_2 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_2) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_2 + var_475_7 and arg_472_1.time_ < var_475_2 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play119906112 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 119906112
		arg_476_1.duration_ = 6.07

		local var_476_0 = {
			zh = 5.8,
			ja = 6.066
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play119906113(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.675

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_1 = arg_476_1:GetWordFromCfg(119906112)
				local var_479_2 = arg_476_1:FormatText(var_479_1.content)

				arg_476_1.text_.text = var_479_2

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 27 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 27)

				if (27 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 27)) > 0 and var_479_0 < var_479_4 then
					arg_476_1.talkMaxDuration = var_479_4

					if var_479_4 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_4 + 0
					end
				end

				arg_476_1.text_.text = var_479_2
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906112", "story_v_side_old_119906.awb") ~= 0 then
					local var_479_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906112", "story_v_side_old_119906.awb") / 1000

					if var_479_5 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + 0
					end

					if var_479_1.prefab_name ~= "" and arg_476_1.actors_[var_479_1.prefab_name] ~= nil then
						local var_479_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_1.prefab_name].transform, "story_v_side_old_119906", "119906112", "story_v_side_old_119906.awb")

						arg_476_1:RecordAudio("119906112", var_479_6)
						arg_476_1:RecordAudio("119906112", var_479_6)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906112", "story_v_side_old_119906.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906112", "story_v_side_old_119906.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_7 and arg_476_1.time_ < 0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play119906113 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 119906113
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play119906114(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.375

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_1 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(119906113).content)

				arg_480_1.text_.text = var_483_1

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_3 = 15 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 15)

				if (15 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 15)) > 0 and var_483_0 < var_483_3 then
					arg_480_1.talkMaxDuration = var_483_3

					if var_483_3 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_3 + 0
					end
				end

				arg_480_1.text_.text = var_483_1
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_4 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_4

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play119906114 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 119906114
		arg_484_1.duration_ = 9

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play119906115(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 2 < arg_484_1.time_ and arg_484_1.time_ <= 2 + arg_487_0 then
				local var_487_0 = arg_484_1.bgs_.R9902

				arg_484_1.bgs_.R9902.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_487_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_487_1 = var_487_0:GetComponent("SpriteRenderer")

				if var_487_1 and var_487_1.sprite then
					local var_487_2 = 2 * (var_487_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_487_0.transform.localScale = Vector3.New(var_487_2 / var_487_1.sprite.bounds.size.y < var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x and var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x or var_487_2 / var_487_1.sprite.bounds.size.y, var_487_2 / var_487_1.sprite.bounds.size.y < var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x and var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x or var_487_2 / var_487_1.sprite.bounds.size.y, 0)
				end

				for iter_487_0, iter_487_1 in pairs(arg_484_1.bgs_) do
					if iter_487_0 ~= "R9902" then
						iter_487_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_487_3 = 0

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_3 + arg_487_0 then
				arg_484_1.mask_.enabled = true
				arg_484_1.mask_.raycastTarget = true

				arg_484_1:SetGaussion(false)
			end

			local var_487_4 = 2

			if var_487_3 <= arg_484_1.time_ and arg_484_1.time_ < var_487_3 + var_487_4 then
				local var_487_5 = Color.New(0, 0, 0)

				var_487_5.a = Mathf.Lerp(0, 1, (arg_484_1.time_ - var_487_3) / var_487_4)
				arg_484_1.mask_.color = var_487_5
			end

			if arg_484_1.time_ >= var_487_3 + var_487_4 and arg_484_1.time_ < var_487_3 + var_487_4 + arg_487_0 then
				local var_487_6 = Color.New(0, 0, 0)

				var_487_6.a = 1
				arg_484_1.mask_.color = var_487_6
			end

			local var_487_7 = 2

			if 2 < arg_484_1.time_ and arg_484_1.time_ <= var_487_7 + arg_487_0 then
				arg_484_1.mask_.enabled = true
				arg_484_1.mask_.raycastTarget = true

				arg_484_1:SetGaussion(false)
			end

			local var_487_8 = 2

			if var_487_7 <= arg_484_1.time_ and arg_484_1.time_ < var_487_7 + var_487_8 then
				local var_487_9 = Color.New(0, 0, 0)

				var_487_9.a = Mathf.Lerp(1, 0, (arg_484_1.time_ - var_487_7) / var_487_8)
				arg_484_1.mask_.color = var_487_9
			end

			if arg_484_1.time_ >= var_487_7 + var_487_8 and arg_484_1.time_ < var_487_7 + var_487_8 + arg_487_0 then
				local var_487_10 = Color.New(0, 0, 0)

				arg_484_1.mask_.enabled = false
				var_487_10.a = 0
				arg_484_1.mask_.color = var_487_10
			end

			local var_487_11 = arg_484_1.bgs_.R9902.transform

			if 2.16666666666667 < arg_484_1.time_ and arg_484_1.time_ <= 2.16666666666667 + arg_487_0 then
				arg_484_1.var_.moveOldPosR9902 = var_487_11.localPosition
			end

			local var_487_12 = 3

			if 2.16666666666667 <= arg_484_1.time_ and arg_484_1.time_ < 2.16666666666667 + var_487_12 then
				var_487_11.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPosR9902, Vector3.New(0, 1, 9.5), (arg_484_1.time_ - 2.16666666666667) / var_487_12)
			end

			if arg_484_1.time_ >= 2.16666666666667 + var_487_12 and arg_484_1.time_ < 2.16666666666667 + var_487_12 + arg_487_0 then
				var_487_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_487_13 = 4

			if 4 < arg_484_1.time_ and arg_484_1.time_ <= var_487_13 + arg_487_0 then
				arg_484_1.allBtn_.enabled = false
			end

			if arg_484_1.time_ >= var_487_13 + 1.16666666666667 and arg_484_1.time_ < var_487_13 + 1.16666666666667 + arg_487_0 then
				arg_484_1.allBtn_.enabled = true
			end

			if arg_484_1.frameCnt_ <= 1 then
				arg_484_1.dialog_:SetActive(false)
			end

			local var_487_14 = 4
			local var_487_15 = 0.925

			if 4 < arg_484_1.time_ and arg_484_1.time_ <= var_487_14 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0

				arg_484_1.dialog_:SetActive(true)

				arg_484_1.dialogCg_.alpha = 0

				local var_487_16 = LeanTween.value(arg_484_1.dialog_, 0, 1, 0.3)

				var_487_16:setOnUpdate(LuaHelper.FloatAction(function(arg_488_0)
					arg_484_1.dialogCg_.alpha = arg_488_0
				end))
				var_487_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_484_1.dialog_)
					var_487_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_484_1.duration_ = arg_484_1.duration_ + 0.3

				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_17 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(119906114).content)

				arg_484_1.text_.text = var_487_17

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_19 = 37 <= 0 and var_487_15 or var_487_15 * (utf8.len(var_487_17) / 37)

				if (37 <= 0 and var_487_15 or var_487_15 * (utf8.len(var_487_17) / 37)) > 0 and var_487_15 < var_487_19 then
					arg_484_1.talkMaxDuration = var_487_19
					var_487_14 = var_487_14 + 0.3

					if var_487_19 + var_487_14 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_19 + var_487_14
					end
				end

				arg_484_1.text_.text = var_487_17
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_20 = var_487_14 + 0.3
			local var_487_21 = math.max(var_487_15, arg_484_1.talkMaxDuration)

			if var_487_14 + 0.3 <= arg_484_1.time_ and arg_484_1.time_ < var_487_20 + var_487_21 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_20) / var_487_21

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_20 + var_487_21 and arg_484_1.time_ < var_487_20 + var_487_21 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_484_1:InitPlayNodeList()
	end,
	Play119906115 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 119906115
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play119906116(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 1.1

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_1 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(119906115).content)

				arg_490_1.text_.text = var_493_1

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_3 = 44 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 44)

				if (44 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 44)) > 0 and var_493_0 < var_493_3 then
					arg_490_1.talkMaxDuration = var_493_3

					if var_493_3 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_3 + 0
					end
				end

				arg_490_1.text_.text = var_493_1
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_4 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_4

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play119906116 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 119906116
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play119906117(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 1.475

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_1 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(119906116).content)

				arg_494_1.text_.text = var_497_1

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_3 = 59 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 59)

				if (59 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 59)) > 0 and var_497_0 < var_497_3 then
					arg_494_1.talkMaxDuration = var_497_3

					if var_497_3 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_3 + 0
					end
				end

				arg_494_1.text_.text = var_497_1
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_4 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_4

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play119906117 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 119906117
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play119906118(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.675

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_1 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(119906117).content)

				arg_498_1.text_.text = var_501_1

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_3 = 27 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_1) / 27)

				if (27 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_1) / 27)) > 0 and var_501_0 < var_501_3 then
					arg_498_1.talkMaxDuration = var_501_3

					if var_501_3 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_3 + 0
					end
				end

				arg_498_1.text_.text = var_501_1
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_4 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_4 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_4

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_4 and arg_498_1.time_ < 0 + var_501_4 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play119906118 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 119906118
		arg_502_1.duration_ = 6.77

		local var_502_0 = {
			zh = 6.7,
			ja = 6.766
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play119906119(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.3

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_1 = arg_502_1:GetWordFromCfg(119906118)
				local var_505_2 = arg_502_1:FormatText(var_505_1.content)

				arg_502_1.text_.text = var_505_2

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 12 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 12)

				if (12 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 12)) > 0 and var_505_0 < var_505_4 then
					arg_502_1.talkMaxDuration = var_505_4

					if var_505_4 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_4 + 0
					end
				end

				arg_502_1.text_.text = var_505_2
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906118", "story_v_side_old_119906.awb") ~= 0 then
					local var_505_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906118", "story_v_side_old_119906.awb") / 1000

					if var_505_5 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + 0
					end

					if var_505_1.prefab_name ~= "" and arg_502_1.actors_[var_505_1.prefab_name] ~= nil then
						local var_505_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_1.prefab_name].transform, "story_v_side_old_119906", "119906118", "story_v_side_old_119906.awb")

						arg_502_1:RecordAudio("119906118", var_505_6)
						arg_502_1:RecordAudio("119906118", var_505_6)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906118", "story_v_side_old_119906.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906118", "story_v_side_old_119906.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_7 and arg_502_1.time_ < 0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play119906119 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 119906119
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play119906120(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 1

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(119906119).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 40 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 40)

				if (40 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 40)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play119906120 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 119906120
		arg_510_1.duration_ = 3.1

		local var_510_0 = {
			zh = 1.933,
			ja = 3.1
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
			arg_510_1.auto_ = false
		end

		function arg_510_1.playNext_(arg_512_0)
			arg_510_1.onStoryFinished_()
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.2

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[519].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:GetWordFromCfg(119906120)
				local var_513_2 = arg_510_1:FormatText(var_513_1.content)

				arg_510_1.text_.text = var_513_2

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 8 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_2) / 8)

				if (8 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_2) / 8)) > 0 and var_513_0 < var_513_4 then
					arg_510_1.talkMaxDuration = var_513_4

					if var_513_4 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_4 + 0
					end
				end

				arg_510_1.text_.text = var_513_2
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_119906", "119906120", "story_v_side_old_119906.awb") ~= 0 then
					local var_513_5 = manager.audio:GetVoiceLength("story_v_side_old_119906", "119906120", "story_v_side_old_119906.awb") / 1000

					if var_513_5 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + 0
					end

					if var_513_1.prefab_name ~= "" and arg_510_1.actors_[var_513_1.prefab_name] ~= nil then
						local var_513_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_1.prefab_name].transform, "story_v_side_old_119906", "119906120", "story_v_side_old_119906.awb")

						arg_510_1:RecordAudio("119906120", var_513_6)
						arg_510_1:RecordAudio("119906120", var_513_6)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_old_119906", "119906120", "story_v_side_old_119906.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_old_119906", "119906120", "story_v_side_old_119906.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_7 and arg_510_1.time_ < 0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST16",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST11a",
		"TextureConfig/Background/C06b",
		"TextureConfig/Background/S0902",
		"TextureConfig/Background/R9901",
		"TextureConfig/Background/R9902"
	},
	voices = {
		"story_v_side_old_119906.awb"
	}
}
