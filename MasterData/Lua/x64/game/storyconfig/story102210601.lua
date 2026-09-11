return {
	Play221061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 221061001
		arg_1_1.duration_ = 8.7

		local var_1_0 = {
			ja = 8.7,
			ko = 8.133,
			zh = 8.133
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play221061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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

			local var_4_8 = "1072ui_story"

			if arg_1_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1072ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.71, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1072ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 1.3 < arg_1_1.time_ and arg_1_1.time_ <= 1.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 2
			local var_4_24 = 0.575

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(221061001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 23 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 23)

				if (23 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 23)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061001", "story_v_out_221061.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_221061", "221061001", "story_v_out_221061.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_221061", "221061001", "story_v_out_221061.awb")

						arg_1_1:RecordAudio("221061001", var_4_31)
						arg_1_1:RecordAudio("221061001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_221061", "221061001", "story_v_out_221061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_221061", "221061001", "story_v_out_221061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 221061002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play221061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1072ui_story"]) and arg_9_1.var_.characterEffect1072ui_story == nil then
				arg_9_1.var_.characterEffect1072ui_story = arg_9_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1072ui_story"]) then
				if arg_9_1.var_.characterEffect1072ui_story and not isNil(arg_9_1.actors_["1072ui_story"]) then
					arg_9_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1072ui_story"]) and arg_9_1.var_.characterEffect1072ui_story then
				arg_9_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(221061002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 61 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 61)

				if (61 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 61)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play221061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 221061003
		arg_13_1.duration_ = 8.33

		local var_13_0 = {
			ja = 8.333,
			ko = 8,
			zh = 8
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
				arg_13_0:Play221061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.75

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(221061003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 30 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 30)

				if (30 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 30)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061003", "story_v_out_221061.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061003", "story_v_out_221061.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_221061", "221061003", "story_v_out_221061.awb")

						arg_13_1:RecordAudio("221061003", var_16_6)
						arg_13_1:RecordAudio("221061003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_221061", "221061003", "story_v_out_221061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_221061", "221061003", "story_v_out_221061.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play221061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 221061004
		arg_17_1.duration_ = 2.7

		local var_17_0 = {
			ja = 2.7,
			ko = 2.166,
			zh = 2.166
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
				arg_17_0:Play221061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1072ui_story = arg_17_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1072ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1072ui_story == nil then
				arg_17_1.var_.characterEffect1072ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1072ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1072ui_story then
				arg_17_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action424")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(221061004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)

				if (10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061004", "story_v_out_221061.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061004", "story_v_out_221061.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_221061", "221061004", "story_v_out_221061.awb")

						arg_17_1:RecordAudio("221061004", var_20_11)
						arg_17_1:RecordAudio("221061004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_221061", "221061004", "story_v_out_221061.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_221061", "221061004", "story_v_out_221061.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 221061005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play221061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1072ui_story = arg_21_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).z)
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles = arg_21_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).z)
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles = arg_21_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1072ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1072ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_2)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1072ui_story then
				arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_24_3 = 0
			local var_24_4 = 1.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(221061005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 60 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 60)

				if (60 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 60)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play221061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 221061006
		arg_25_1.duration_ = 4.23

		local var_25_0 = {
			ja = 4.233,
			ko = 2.933,
			zh = 2.933
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
				arg_25_0:Play221061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1072ui_story = arg_25_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).z)
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles = arg_25_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_25_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).z)
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles = arg_25_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1072ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1072ui_story == nil then
				arg_25_1.var_.characterEffect1072ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1072ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1072ui_story then
				arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_28_4 = "1076ui_story"

			if arg_25_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_28_5 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_25_1.stage_.transform)

				var_28_5.name = var_28_4
				var_28_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_[var_28_4] = var_28_5

				local var_28_6 = var_28_5:GetComponentInChildren(typeof(CharacterEffect))

				var_28_6.enabled = true

				local var_28_7 = GameObjectTools.GetOrAddComponent(var_28_5, typeof(DynamicBoneHelper))

				if var_28_7 then
					var_28_7:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_6.transform, false)

				arg_25_1.var_[var_28_4 .. "Animator"] = var_28_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_[var_28_4 .. "Animator"].applyRootMotion = true
				arg_25_1.var_[var_28_4 .. "LipSync"] = var_28_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_8 = arg_25_1.actors_["1076ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1076ui_story = var_28_8.localPosition
			end

			local var_28_9 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 then
				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_25_1.time_ - 0) / var_28_9)
				var_28_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_8.position).x, (manager.ui.mainCamera.transform.position - var_28_8.position).y, (manager.ui.mainCamera.transform.position - var_28_8.position).z)
				var_28_8.localEulerAngles.z = 0
				var_28_8.localEulerAngles.x = 0
				var_28_8.localEulerAngles = var_28_8.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_28_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_8.position).x, (manager.ui.mainCamera.transform.position - var_28_8.position).y, (manager.ui.mainCamera.transform.position - var_28_8.position).z)
				var_28_8.localEulerAngles.z = 0
				var_28_8.localEulerAngles.x = 0
				var_28_8.localEulerAngles = var_28_8.localEulerAngles
			end

			local var_28_10 = arg_25_1.actors_["1076ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.0166666666666667

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_11 and not isNil(var_28_10) then
				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_10) then
					arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_11)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_11 and arg_25_1.time_ < 0 + var_28_11 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1076ui_story then
				arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_28_12 = 0
			local var_28_13 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(221061006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 11 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 11)

				if (11 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 11)) > 0 and var_28_13 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061006", "story_v_out_221061.awb") ~= 0 then
					local var_28_18 = manager.audio:GetVoiceLength("story_v_out_221061", "221061006", "story_v_out_221061.awb") / 1000

					if var_28_18 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_12
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_221061", "221061006", "story_v_out_221061.awb")

						arg_25_1:RecordAudio("221061006", var_28_19)
						arg_25_1:RecordAudio("221061006", var_28_19)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_221061", "221061006", "story_v_out_221061.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_221061", "221061006", "story_v_out_221061.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_20 and arg_25_1.time_ < var_28_12 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 221061007
		arg_29_1.duration_ = 13.2

		local var_29_0 = {
			ja = 13.2,
			ko = 9.366,
			zh = 9.366
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
				arg_29_0:Play221061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1072ui_story = arg_29_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).z)
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles = arg_29_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_29_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1072ui_story"].transform.position).z)
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1072ui_story"].transform.localEulerAngles = arg_29_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_1 = 0
			local var_32_2 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(221061007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 33 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 33)

				if (33 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 33)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061007", "story_v_out_221061.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061007", "story_v_out_221061.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_221061", "221061007", "story_v_out_221061.awb")

						arg_29_1:RecordAudio("221061007", var_32_8)
						arg_29_1:RecordAudio("221061007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_221061", "221061007", "story_v_out_221061.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_221061", "221061007", "story_v_out_221061.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play221061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 221061008
		arg_33_1.duration_ = 3.93

		local var_33_0 = {
			ja = 3.933,
			ko = 3,
			zh = 3
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
				arg_33_0:Play221061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1076ui_story = arg_33_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1076ui_story"].transform.position).z)
				arg_33_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1076ui_story"].transform.localEulerAngles = arg_33_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_33_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1076ui_story"].transform.position).z)
				arg_33_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1076ui_story"].transform.localEulerAngles = arg_33_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1076ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1076ui_story == nil then
				arg_33_1.var_.characterEffect1076ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1076ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1076ui_story then
				arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = arg_33_1.actors_["1072ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1072ui_story == nil then
				arg_33_1.var_.characterEffect1072ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1072ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1072ui_story then
				arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_36_6 = 0
			local var_36_7 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(221061008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 10 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 10)

				if (10 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 10)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061008", "story_v_out_221061.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061008", "story_v_out_221061.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_221061", "221061008", "story_v_out_221061.awb")

						arg_33_1:RecordAudio("221061008", var_36_13)
						arg_33_1:RecordAudio("221061008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_221061", "221061008", "story_v_out_221061.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_221061", "221061008", "story_v_out_221061.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 221061009
		arg_37_1.duration_ = 11.63

		local var_37_0 = {
			ja = 11.633,
			ko = 9.833,
			zh = 9.833
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play221061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1072ui_story = arg_37_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).z)
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles = arg_37_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_37_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).z)
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles = arg_37_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1072ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1072ui_story == nil then
				arg_37_1.var_.characterEffect1072ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1072ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1072ui_story then
				arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = arg_37_1.actors_["1076ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1076ui_story == nil then
				arg_37_1.var_.characterEffect1076ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect1076ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1076ui_story then
				arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_40_6 = 0
			local var_40_7 = 1.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(221061009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 42 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 42)

				if (42 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 42)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061009", "story_v_out_221061.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061009", "story_v_out_221061.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_221061", "221061009", "story_v_out_221061.awb")

						arg_37_1:RecordAudio("221061009", var_40_13)
						arg_37_1:RecordAudio("221061009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_221061", "221061009", "story_v_out_221061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_221061", "221061009", "story_v_out_221061.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play221061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 221061010
		arg_41_1.duration_ = 4.6

		local var_41_0 = {
			ja = 4.6,
			ko = 4.066,
			zh = 4.066
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
				arg_41_0:Play221061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1072ui_story = arg_41_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).z)
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles = arg_41_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_41_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).z)
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles = arg_41_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_1 = 0
			local var_44_2 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(221061010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 16 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 16)

				if (16 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 16)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061010", "story_v_out_221061.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061010", "story_v_out_221061.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_221061", "221061010", "story_v_out_221061.awb")

						arg_41_1:RecordAudio("221061010", var_44_8)
						arg_41_1:RecordAudio("221061010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_221061", "221061010", "story_v_out_221061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_221061", "221061010", "story_v_out_221061.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 221061011
		arg_45_1.duration_ = 8.4

		local var_45_0 = {
			ja = 8.4,
			ko = 5.9,
			zh = 5.9
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
				arg_45_0:Play221061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1072ui_story = arg_45_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).z)
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles = arg_45_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_45_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).z)
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles = arg_45_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1072ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1072ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1072ui_story then
				arg_45_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action462")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.55

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(221061011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 22 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 22)

				if (22 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 22)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061011", "story_v_out_221061.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061011", "story_v_out_221061.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_221061", "221061011", "story_v_out_221061.awb")

						arg_45_1:RecordAudio("221061011", var_48_11)
						arg_45_1:RecordAudio("221061011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_221061", "221061011", "story_v_out_221061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_221061", "221061011", "story_v_out_221061.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play221061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 221061012
		arg_49_1.duration_ = 7.93

		local var_49_0 = {
			ja = 6.5,
			ko = 7.933,
			zh = 7.933
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play221061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1076ui_story = arg_49_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1076ui_story"].transform.position).z)
				arg_49_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1076ui_story"].transform.localEulerAngles = arg_49_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_49_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1076ui_story"].transform.position).z)
				arg_49_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1076ui_story"].transform.localEulerAngles = arg_49_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1076ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1076ui_story == nil then
				arg_49_1.var_.characterEffect1076ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1076ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1076ui_story then
				arg_49_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1072ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1072ui_story then
				arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(221061012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 30 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 30)

				if (30 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 30)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061012", "story_v_out_221061.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061012", "story_v_out_221061.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_221061", "221061012", "story_v_out_221061.awb")

						arg_49_1:RecordAudio("221061012", var_52_13)
						arg_49_1:RecordAudio("221061012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_221061", "221061012", "story_v_out_221061.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_221061", "221061012", "story_v_out_221061.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play221061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 221061013
		arg_53_1.duration_ = 7.8

		local var_53_0 = {
			ja = 7.8,
			ko = 5.466,
			zh = 5.466
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
				arg_53_0:Play221061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1076ui_story = arg_53_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).z)
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles = arg_53_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_53_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).z)
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles = arg_53_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_56_1 = 0
			local var_56_2 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(221061013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 24 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 24)

				if (24 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 24)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061013", "story_v_out_221061.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061013", "story_v_out_221061.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_221061", "221061013", "story_v_out_221061.awb")

						arg_53_1:RecordAudio("221061013", var_56_8)
						arg_53_1:RecordAudio("221061013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_221061", "221061013", "story_v_out_221061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_221061", "221061013", "story_v_out_221061.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 221061014
		arg_57_1.duration_ = 2.83

		local var_57_0 = {
			ja = 2.166,
			ko = 2.833,
			zh = 2.833
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
				arg_57_0:Play221061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1072ui_story = arg_57_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).z)
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles = arg_57_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_57_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1072ui_story"].transform.position).z)
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1072ui_story"].transform.localEulerAngles = arg_57_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1072ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1072ui_story == nil then
				arg_57_1.var_.characterEffect1072ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1072ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1072ui_story then
				arg_57_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_60_4 = arg_57_1.actors_["1076ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1076ui_story == nil then
				arg_57_1.var_.characterEffect1076ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect1076ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1076ui_story then
				arg_57_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_60_6 = 0
			local var_60_7 = 0.05

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(221061014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 2 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 2)

				if (2 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 2)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061014", "story_v_out_221061.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061014", "story_v_out_221061.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_221061", "221061014", "story_v_out_221061.awb")

						arg_57_1:RecordAudio("221061014", var_60_13)
						arg_57_1:RecordAudio("221061014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_221061", "221061014", "story_v_out_221061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_221061", "221061014", "story_v_out_221061.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 221061015
		arg_61_1.duration_ = 11.67

		local var_61_0 = {
			ja = 11.666,
			ko = 9.466,
			zh = 9.466
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
				arg_61_0:Play221061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1072ui_story = arg_61_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).z)
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles = arg_61_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_61_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).z)
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles = arg_61_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1072ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 0.85

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(221061015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 34 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 34)

				if (34 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 34)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061015", "story_v_out_221061.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061015", "story_v_out_221061.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_221061", "221061015", "story_v_out_221061.awb")

						arg_61_1:RecordAudio("221061015", var_64_11)
						arg_61_1:RecordAudio("221061015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_221061", "221061015", "story_v_out_221061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_221061", "221061015", "story_v_out_221061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 221061016
		arg_65_1.duration_ = 8.23

		local var_65_0 = {
			ja = 8.233,
			ko = 6.133,
			zh = 6.133
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
				arg_65_0:Play221061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1076ui_story = arg_65_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).z)
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles = arg_65_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_65_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).z)
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles = arg_65_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1076ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1076ui_story == nil then
				arg_65_1.var_.characterEffect1076ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1076ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1076ui_story then
				arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = arg_65_1.actors_["1072ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect1072ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1072ui_story then
				arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_68_6 = 0
			local var_68_7 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(221061016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 24 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 24)

				if (24 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 24)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061016", "story_v_out_221061.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061016", "story_v_out_221061.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_221061", "221061016", "story_v_out_221061.awb")

						arg_65_1:RecordAudio("221061016", var_68_13)
						arg_65_1:RecordAudio("221061016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_221061", "221061016", "story_v_out_221061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_221061", "221061016", "story_v_out_221061.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 221061017
		arg_69_1.duration_ = 6.9

		local var_69_0 = {
			ja = 5.466,
			ko = 6.9,
			zh = 6.9
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play221061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1072ui_story = arg_69_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).z)
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles = arg_69_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_69_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).z)
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles = arg_69_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1072ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = arg_69_1.actors_["1076ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1076ui_story == nil then
				arg_69_1.var_.characterEffect1076ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect1076ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1076ui_story then
				arg_69_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_72_6 = 0
			local var_72_7 = 0.45

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(221061017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 18 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 18)

				if (18 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 18)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061017", "story_v_out_221061.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061017", "story_v_out_221061.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_221061", "221061017", "story_v_out_221061.awb")

						arg_69_1:RecordAudio("221061017", var_72_13)
						arg_69_1:RecordAudio("221061017", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_221061", "221061017", "story_v_out_221061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_221061", "221061017", "story_v_out_221061.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play221061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 221061018
		arg_73_1.duration_ = 6.83

		local var_73_0 = {
			ja = 6.833,
			ko = 5.033,
			zh = 5.033
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
				arg_73_0:Play221061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1072ui_story = arg_73_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_1 = 0
			local var_76_2 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(221061018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 19 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 19)

				if (19 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 19)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061018", "story_v_out_221061.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061018", "story_v_out_221061.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_221061", "221061018", "story_v_out_221061.awb")

						arg_73_1:RecordAudio("221061018", var_76_8)
						arg_73_1:RecordAudio("221061018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_221061", "221061018", "story_v_out_221061.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_221061", "221061018", "story_v_out_221061.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play221061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 221061019
		arg_77_1.duration_ = 2

		local var_77_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_77_0:Play221061020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1076ui_story = arg_77_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).z)
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles = arg_77_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_77_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).z)
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles = arg_77_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1076ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1076ui_story == nil then
				arg_77_1.var_.characterEffect1076ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1076ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1076ui_story then
				arg_77_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = arg_77_1.actors_["1072ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1072ui_story == nil then
				arg_77_1.var_.characterEffect1072ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_5 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 and not isNil(var_80_4) then
				if arg_77_1.var_.characterEffect1072ui_story and not isNil(var_80_4) then
					arg_77_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_5)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1072ui_story then
				arg_77_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_80_6 = 0
			local var_80_7 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(221061019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 5 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 5)

				if (5 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 5)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061019", "story_v_out_221061.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061019", "story_v_out_221061.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_221061", "221061019", "story_v_out_221061.awb")

						arg_77_1:RecordAudio("221061019", var_80_13)
						arg_77_1:RecordAudio("221061019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_221061", "221061019", "story_v_out_221061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_221061", "221061019", "story_v_out_221061.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221061020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 221061020
		arg_81_1.duration_ = 6.47

		local var_81_0 = {
			ja = 6.466,
			ko = 4.3,
			zh = 4.3
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play221061021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1072ui_story = arg_81_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).z)
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles = arg_81_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_81_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).z)
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles = arg_81_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1072ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1072ui_story == nil then
				arg_81_1.var_.characterEffect1072ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1072ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1072ui_story then
				arg_81_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = arg_81_1.actors_["1076ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect1076ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1076ui_story then
				arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_84_6 = 0
			local var_84_7 = 0.425

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(221061020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 17 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 17)

				if (17 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 17)) > 0 and var_84_7 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061020", "story_v_out_221061.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061020", "story_v_out_221061.awb") / 1000

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_221061", "221061020", "story_v_out_221061.awb")

						arg_81_1:RecordAudio("221061020", var_84_13)
						arg_81_1:RecordAudio("221061020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_221061", "221061020", "story_v_out_221061.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_221061", "221061020", "story_v_out_221061.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play221061021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 221061021
		arg_85_1.duration_ = 8.4

		local var_85_0 = {
			ja = 8.4,
			ko = 8.166,
			zh = 8.166
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
				arg_85_0:Play221061022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1072ui_story = arg_85_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).z)
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles = arg_85_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_85_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).z)
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles = arg_85_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_88_1 = 0
			local var_88_2 = 0.875

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(221061021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 35 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 35)

				if (35 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 35)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061021", "story_v_out_221061.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061021", "story_v_out_221061.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_221061", "221061021", "story_v_out_221061.awb")

						arg_85_1:RecordAudio("221061021", var_88_8)
						arg_85_1:RecordAudio("221061021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_221061", "221061021", "story_v_out_221061.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_221061", "221061021", "story_v_out_221061.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play221061022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 221061022
		arg_89_1.duration_ = 8

		local var_89_0 = {
			ja = 8,
			ko = 6.7,
			zh = 6.7
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play221061023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_92_0 = 0
			local var_92_1 = 0.925

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(221061022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 37 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 37)

				if (37 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 37)) > 0 and var_92_1 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061022", "story_v_out_221061.awb") ~= 0 then
					local var_92_6 = manager.audio:GetVoiceLength("story_v_out_221061", "221061022", "story_v_out_221061.awb") / 1000

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end

					if var_92_2.prefab_name ~= "" and arg_89_1.actors_[var_92_2.prefab_name] ~= nil then
						local var_92_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_2.prefab_name].transform, "story_v_out_221061", "221061022", "story_v_out_221061.awb")

						arg_89_1:RecordAudio("221061022", var_92_7)
						arg_89_1:RecordAudio("221061022", var_92_7)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_221061", "221061022", "story_v_out_221061.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_221061", "221061022", "story_v_out_221061.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play221061023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 221061023
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play221061024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1076ui_story = arg_93_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).z)
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles = arg_93_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_93_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).z)
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles = arg_93_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1076ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1076ui_story == nil then
				arg_93_1.var_.characterEffect1076ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1076ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1076ui_story then
				arg_93_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["1072ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1072ui_story == nil then
				arg_93_1.var_.characterEffect1072ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_5 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 and not isNil(var_96_4) then
				if arg_93_1.var_.characterEffect1072ui_story and not isNil(var_96_4) then
					arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_5)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1072ui_story then
				arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_96_6 = 0
			local var_96_7 = 0.05

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(221061023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 2 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 2)

				if (2 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 2)) > 0 and var_96_7 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061023", "story_v_out_221061.awb") ~= 0 then
					local var_96_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061023", "story_v_out_221061.awb") / 1000

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_out_221061", "221061023", "story_v_out_221061.awb")

						arg_93_1:RecordAudio("221061023", var_96_13)
						arg_93_1:RecordAudio("221061023", var_96_13)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_221061", "221061023", "story_v_out_221061.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_221061", "221061023", "story_v_out_221061.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play221061024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 221061024
		arg_97_1.duration_ = 8.23

		local var_97_0 = {
			ja = 8.233,
			ko = 6.2,
			zh = 6.2
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
				arg_97_0:Play221061025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1072ui_story = arg_97_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).z)
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles = arg_97_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_97_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).z)
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles = arg_97_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1072ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1072ui_story == nil then
				arg_97_1.var_.characterEffect1072ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1072ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1072ui_story then
				arg_97_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = arg_97_1.actors_["1076ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1076ui_story == nil then
				arg_97_1.var_.characterEffect1076ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect1076ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1076ui_story then
				arg_97_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_100_6 = 0
			local var_100_7 = 0.725

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(221061024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 29 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 29)

				if (29 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 29)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061024", "story_v_out_221061.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061024", "story_v_out_221061.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_221061", "221061024", "story_v_out_221061.awb")

						arg_97_1:RecordAudio("221061024", var_100_13)
						arg_97_1:RecordAudio("221061024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_221061", "221061024", "story_v_out_221061.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_221061", "221061024", "story_v_out_221061.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 221061025
		arg_101_1.duration_ = 9.1

		local var_101_0 = {
			ja = 9.1,
			ko = 5.666,
			zh = 5.666
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
				arg_101_0:Play221061026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1072ui_story = arg_101_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).z)
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles = arg_101_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_101_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1072ui_story"].transform.position).z)
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1072ui_story"].transform.localEulerAngles = arg_101_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1072ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1072ui_story == nil then
				arg_101_1.var_.characterEffect1072ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1072ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1072ui_story then
				arg_101_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action472")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.725

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(221061025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 29 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 29)

				if (29 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 29)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061025", "story_v_out_221061.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061025", "story_v_out_221061.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_221061", "221061025", "story_v_out_221061.awb")

						arg_101_1:RecordAudio("221061025", var_104_11)
						arg_101_1:RecordAudio("221061025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_221061", "221061025", "story_v_out_221061.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_221061", "221061025", "story_v_out_221061.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play221061026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 221061026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play221061027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1076ui_story = arg_105_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1076ui_story"].transform.position).z)
				arg_105_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1076ui_story"].transform.localEulerAngles = arg_105_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1076ui_story"].transform.position).z)
				arg_105_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1076ui_story"].transform.localEulerAngles = arg_105_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1076ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1076ui_story == nil then
				arg_105_1.var_.characterEffect1076ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1076ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1076ui_story then
				arg_105_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_108_3 = arg_105_1.actors_["1072ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1072ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(0, 100, 0)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["1072ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1072ui_story == nil then
				arg_105_1.var_.characterEffect1072ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1072ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_6)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1072ui_story then
				arg_105_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_108_7 = 0
			local var_108_8 = 0.925

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_9 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(221061026).content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 37 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_9) / 37)

				if (37 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_9) / 37)) > 0 and var_108_8 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_7) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_7 + var_108_12 and arg_105_1.time_ < var_108_7 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play221061027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 221061027
		arg_109_1.duration_ = 9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play221061028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.bgs_.ST39 == nil then
				local var_112_0 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST39")
				var_112_0.name = "ST39"
				var_112_0.transform.parent = arg_109_1.stage_.transform
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_.ST39 = var_112_0
			end

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				local var_112_1 = arg_109_1.bgs_.ST39

				arg_109_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_2 = var_112_1:GetComponent("SpriteRenderer")

				if var_112_2 and var_112_2.sprite then
					local var_112_3 = 2 * (var_112_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_1.transform.localScale = Vector3.New(var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST39" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_4 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_5 = 2

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_5 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_4) / var_112_5)
				arg_109_1.mask_.color = var_112_6
			end

			if arg_109_1.time_ >= var_112_4 + var_112_5 and arg_109_1.time_ < var_112_4 + var_112_5 + arg_112_0 then
				local var_112_7 = Color.New(0, 0, 0)

				var_112_7.a = 1
				arg_109_1.mask_.color = var_112_7
			end

			local var_112_8 = 2

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_9 = 2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 then
				local var_112_10 = Color.New(0, 0, 0)

				var_112_10.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_8) / var_112_9)
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 then
				local var_112_11 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_11.a = 0
				arg_109_1.mask_.color = var_112_11
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_12 = 4
			local var_112_13 = 1.125

			if 4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_14 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_14:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_15 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(221061027).content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_17 = 45 <= 0 and var_112_13 or var_112_13 * (utf8.len(var_112_15) / 45)

				if (45 <= 0 and var_112_13 or var_112_13 * (utf8.len(var_112_15) / 45)) > 0 and var_112_13 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17
					var_112_12 = var_112_12 + 0.3

					if var_112_17 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_12
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = var_112_12 + 0.3
			local var_112_19 = math.max(var_112_13, arg_109_1.talkMaxDuration)

			if var_112_12 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_18 + var_112_19 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_18) / var_112_19

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_18 + var_112_19 and arg_109_1.time_ < var_112_18 + var_112_19 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play221061028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 221061028
		arg_115_1.duration_ = 8.3

		local var_115_0 = {
			ja = 8.3,
			ko = 6.066,
			zh = 6.066
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play221061029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.6

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(221061028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 24 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 24)

				if (24 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 24)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061028", "story_v_out_221061.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061028", "story_v_out_221061.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_221061", "221061028", "story_v_out_221061.awb")

						arg_115_1:RecordAudio("221061028", var_118_6)
						arg_115_1:RecordAudio("221061028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_221061", "221061028", "story_v_out_221061.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_221061", "221061028", "story_v_out_221061.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play221061029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 221061029
		arg_119_1.duration_ = 4.37

		local var_119_0 = {
			ja = 3.633,
			ko = 4.366,
			zh = 4.366
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play221061030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(221061029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 14 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 14)

				if (14 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 14)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061029", "story_v_out_221061.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061029", "story_v_out_221061.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_221061", "221061029", "story_v_out_221061.awb")

						arg_119_1:RecordAudio("221061029", var_122_6)
						arg_119_1:RecordAudio("221061029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_221061", "221061029", "story_v_out_221061.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_221061", "221061029", "story_v_out_221061.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play221061030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 221061030
		arg_123_1.duration_ = 7.17

		local var_123_0 = {
			ja = 7.166,
			ko = 6.133,
			zh = 6.133
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play221061031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1072ui_story = arg_123_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1072ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1072ui_story == nil then
				arg_123_1.var_.characterEffect1072ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1072ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1072ui_story then
				arg_123_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.7

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(221061030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 28 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 28)

				if (28 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 28)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061030", "story_v_out_221061.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061030", "story_v_out_221061.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_221061", "221061030", "story_v_out_221061.awb")

						arg_123_1:RecordAudio("221061030", var_126_11)
						arg_123_1:RecordAudio("221061030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_221061", "221061030", "story_v_out_221061.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_221061", "221061030", "story_v_out_221061.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play221061031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 221061031
		arg_127_1.duration_ = 6.07

		local var_127_0 = {
			ja = 6.066,
			ko = 3.8,
			zh = 3.8
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play221061032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.525

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(221061031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 21 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 21)

				if (21 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 21)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061031", "story_v_out_221061.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061031", "story_v_out_221061.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_221061", "221061031", "story_v_out_221061.awb")

						arg_127_1:RecordAudio("221061031", var_130_6)
						arg_127_1:RecordAudio("221061031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_221061", "221061031", "story_v_out_221061.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_221061", "221061031", "story_v_out_221061.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play221061032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 221061032
		arg_131_1.duration_ = 10.13

		local var_131_0 = {
			ja = 10.133,
			ko = 7.933,
			zh = 7.933
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play221061033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_134_0 = 0
			local var_134_1 = 0.8

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(221061032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 32 <= 0 and var_134_1 or var_134_1 * (utf8.len(var_134_3) / 32)

				if (32 <= 0 and var_134_1 or var_134_1 * (utf8.len(var_134_3) / 32)) > 0 and var_134_1 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061032", "story_v_out_221061.awb") ~= 0 then
					local var_134_6 = manager.audio:GetVoiceLength("story_v_out_221061", "221061032", "story_v_out_221061.awb") / 1000

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end

					if var_134_2.prefab_name ~= "" and arg_131_1.actors_[var_134_2.prefab_name] ~= nil then
						local var_134_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_2.prefab_name].transform, "story_v_out_221061", "221061032", "story_v_out_221061.awb")

						arg_131_1:RecordAudio("221061032", var_134_7)
						arg_131_1:RecordAudio("221061032", var_134_7)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_221061", "221061032", "story_v_out_221061.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_221061", "221061032", "story_v_out_221061.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play221061033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 221061033
		arg_135_1.duration_ = 4.73

		local var_135_0 = {
			ja = 4.733,
			ko = 4.466,
			zh = 4.466
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play221061034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action462")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_0 = 0
			local var_138_1 = 0.45

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(221061033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 18 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 18)

				if (18 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 18)) > 0 and var_138_1 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061033", "story_v_out_221061.awb") ~= 0 then
					local var_138_6 = manager.audio:GetVoiceLength("story_v_out_221061", "221061033", "story_v_out_221061.awb") / 1000

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end

					if var_138_2.prefab_name ~= "" and arg_135_1.actors_[var_138_2.prefab_name] ~= nil then
						local var_138_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_2.prefab_name].transform, "story_v_out_221061", "221061033", "story_v_out_221061.awb")

						arg_135_1:RecordAudio("221061033", var_138_7)
						arg_135_1:RecordAudio("221061033", var_138_7)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_221061", "221061033", "story_v_out_221061.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_221061", "221061033", "story_v_out_221061.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play221061034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 221061034
		arg_139_1.duration_ = 3.7

		local var_139_0 = {
			ja = 3.7,
			ko = 3.5,
			zh = 3.5
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play221061035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(221061034)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 12 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 12)

				if (12 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 12)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061034", "story_v_out_221061.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061034", "story_v_out_221061.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_221061", "221061034", "story_v_out_221061.awb")

						arg_139_1:RecordAudio("221061034", var_142_6)
						arg_139_1:RecordAudio("221061034", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_221061", "221061034", "story_v_out_221061.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_221061", "221061034", "story_v_out_221061.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play221061035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 221061035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play221061036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1072ui_story = arg_143_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).z)
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles = arg_143_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).z)
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles = arg_143_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1072ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1072ui_story == nil then
				arg_143_1.var_.characterEffect1072ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1072ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1072ui_story then
				arg_143_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_146_3 = 0
			local var_146_4 = 1.175

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(221061035).content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 47 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 47)

				if (47 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 47)) > 0 and var_146_4 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_8 and arg_143_1.time_ < var_146_3 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play221061036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 221061036
		arg_147_1.duration_ = 7.57

		local var_147_0 = {
			ja = 4.633,
			ko = 7.566,
			zh = 7.566
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play221061037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.75

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:GetWordFromCfg(221061036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 30 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 30)

				if (30 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 30)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061036", "story_v_out_221061.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061036", "story_v_out_221061.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_221061", "221061036", "story_v_out_221061.awb")

						arg_147_1:RecordAudio("221061036", var_150_6)
						arg_147_1:RecordAudio("221061036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_221061", "221061036", "story_v_out_221061.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_221061", "221061036", "story_v_out_221061.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play221061037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 221061037
		arg_151_1.duration_ = 9.9

		local var_151_0 = {
			ja = 9.9,
			ko = 6.833,
			zh = 6.833
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play221061038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.725

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(221061037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 29 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 29)

				if (29 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 29)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061037", "story_v_out_221061.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061037", "story_v_out_221061.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_221061", "221061037", "story_v_out_221061.awb")

						arg_151_1:RecordAudio("221061037", var_154_6)
						arg_151_1:RecordAudio("221061037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_221061", "221061037", "story_v_out_221061.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_221061", "221061037", "story_v_out_221061.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play221061038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 221061038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play221061039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.6

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(221061038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 24 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 24)

				if (24 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 24)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play221061039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 221061039
		arg_159_1.duration_ = 6.23

		local var_159_0 = {
			ja = 6.233,
			ko = 5.2,
			zh = 5.2
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play221061040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1072ui_story = arg_159_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).z)
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles = arg_159_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_159_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).z)
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles = arg_159_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1072ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1072ui_story == nil then
				arg_159_1.var_.characterEffect1072ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1072ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1072ui_story then
				arg_159_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_4 = 0
			local var_162_5 = 0.425

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(221061039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 17 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 17)

				if (17 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 17)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061039", "story_v_out_221061.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061039", "story_v_out_221061.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_221061", "221061039", "story_v_out_221061.awb")

						arg_159_1:RecordAudio("221061039", var_162_11)
						arg_159_1:RecordAudio("221061039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_221061", "221061039", "story_v_out_221061.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_221061", "221061039", "story_v_out_221061.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play221061040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 221061040
		arg_163_1.duration_ = 8.7

		local var_163_0 = {
			ja = 8.7,
			ko = 6.533,
			zh = 6.533
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play221061041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1072ui_story = arg_163_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1072ui_story"].transform.position).z)
				arg_163_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1072ui_story"].transform.localEulerAngles = arg_163_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_163_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1072ui_story"].transform.position).z)
				arg_163_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1072ui_story"].transform.localEulerAngles = arg_163_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1072ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1072ui_story == nil then
				arg_163_1.var_.characterEffect1072ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1072ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1072ui_story then
				arg_163_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action485")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(221061040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 29 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 29)

				if (29 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 29)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061040", "story_v_out_221061.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061040", "story_v_out_221061.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_221061", "221061040", "story_v_out_221061.awb")

						arg_163_1:RecordAudio("221061040", var_166_11)
						arg_163_1:RecordAudio("221061040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_221061", "221061040", "story_v_out_221061.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_221061", "221061040", "story_v_out_221061.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 221061041
		arg_167_1.duration_ = 5.2

		local var_167_0 = {
			ja = 2.966,
			ko = 5.2,
			zh = 5.2
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play221061042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1072ui_story"]) and arg_167_1.var_.characterEffect1072ui_story == nil then
				arg_167_1.var_.characterEffect1072ui_story = arg_167_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1072ui_story"]) then
				if arg_167_1.var_.characterEffect1072ui_story and not isNil(arg_167_1.actors_["1072ui_story"]) then
					arg_167_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1072ui_story"]) and arg_167_1.var_.characterEffect1072ui_story then
				arg_167_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.55

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(221061041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 22 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_4) / 22)

				if (22 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_4) / 22)) > 0 and var_170_2 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061041", "story_v_out_221061.awb") ~= 0 then
					local var_170_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061041", "story_v_out_221061.awb") / 1000

					if var_170_7 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_1
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_221061", "221061041", "story_v_out_221061.awb")

						arg_167_1:RecordAudio("221061041", var_170_8)
						arg_167_1:RecordAudio("221061041", var_170_8)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_221061", "221061041", "story_v_out_221061.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_221061", "221061041", "story_v_out_221061.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_9 and arg_167_1.time_ < var_170_1 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play221061042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 221061042
		arg_171_1.duration_ = 3.17

		local var_171_0 = {
			ja = 3.033,
			ko = 3.166,
			zh = 3.166
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play221061043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1072ui_story = arg_171_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).z)
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles = arg_171_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_171_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).z)
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles = arg_171_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1072ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1072ui_story == nil then
				arg_171_1.var_.characterEffect1072ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1072ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1072ui_story then
				arg_171_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.275

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(221061042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 11 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 11)

				if (11 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 11)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061042", "story_v_out_221061.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061042", "story_v_out_221061.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_221061", "221061042", "story_v_out_221061.awb")

						arg_171_1:RecordAudio("221061042", var_174_11)
						arg_171_1:RecordAudio("221061042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_221061", "221061042", "story_v_out_221061.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_221061", "221061042", "story_v_out_221061.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play221061043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 221061043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play221061044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1072ui_story = arg_175_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).z)
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles = arg_175_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).z)
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles = arg_175_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1072ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1072ui_story == nil then
				arg_175_1.var_.characterEffect1072ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1072ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1072ui_story then
				arg_175_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_178_3 = 0
			local var_178_4 = 0.85

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_5 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(221061043).content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 34 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 34)

				if (34 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 34)) > 0 and var_178_4 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_3
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_4, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_3) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_8 and arg_175_1.time_ < var_178_3 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221061044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 221061044
		arg_179_1.duration_ = 10.7

		local var_179_0 = {
			ja = 10.7,
			ko = 7.4,
			zh = 7.4
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play221061045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1076ui_story = arg_179_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).z)
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles = arg_179_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_179_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).z)
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles = arg_179_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1076ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1076ui_story == nil then
				arg_179_1.var_.characterEffect1076ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1076ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1076ui_story then
				arg_179_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_4 = arg_179_1.actors_["1072ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1072ui_story = var_182_4.localPosition
			end

			local var_182_5 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 then
				var_182_4.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_179_1.time_ - 0) / var_182_5)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 then
				var_182_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			local var_182_6 = arg_179_1.actors_["1072ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1072ui_story == nil then
				arg_179_1.var_.characterEffect1072ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_7 = 0.0166666666666667

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 and not isNil(var_182_6) then
				if arg_179_1.var_.characterEffect1072ui_story and not isNil(var_182_6) then
					arg_179_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_7)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1072ui_story then
				arg_179_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_182_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_179_1.bgmTxt_.text ~= var_182_10 and arg_179_1.bgmTxt_.text ~= "" then
						if arg_179_1.bgmTxt2_.text ~= "" then
							arg_179_1.bgmTxt_.text = arg_179_1.bgmTxt2_.text
						end

						arg_179_1.bgmTxt2_.text = var_182_10

						arg_179_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_179_1.bgmTxt_.text = var_182_10
						arg_179_1.bgmTxt2_.text = var_182_10
					end

					if arg_179_1.bgmTimer then
						arg_179_1.bgmTimer:Stop()

						arg_179_1.bgmTimer = nil
					end

					if arg_179_1.settingData.show_music_name == 1 then
						arg_179_1.musicController:SetSelectedState("show")
						arg_179_1.musicAnimator_:Play("open", 0, 0)

						if arg_179_1.settingData.music_time ~= 0 then
							arg_179_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_179_1.settingData.music_time), function()
								if arg_179_1 == nil or isNil(arg_179_1.bgmTxt_) then
									return
								end

								arg_179_1.musicController:SetSelectedState("hide")
								arg_179_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_182_11 = 0
			local var_182_12 = 0.7

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:GetWordFromCfg(221061044)
				local var_182_14 = arg_179_1:FormatText(var_182_13.content)

				arg_179_1.text_.text = var_182_14

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 28 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_14) / 28)

				if (28 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_14) / 28)) > 0 and var_182_12 < var_182_16 then
					arg_179_1.talkMaxDuration = var_182_16

					if var_182_16 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_16 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_14
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061044", "story_v_out_221061.awb") ~= 0 then
					local var_182_17 = manager.audio:GetVoiceLength("story_v_out_221061", "221061044", "story_v_out_221061.awb") / 1000

					if var_182_17 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_11
					end

					if var_182_13.prefab_name ~= "" and arg_179_1.actors_[var_182_13.prefab_name] ~= nil then
						local var_182_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_13.prefab_name].transform, "story_v_out_221061", "221061044", "story_v_out_221061.awb")

						arg_179_1:RecordAudio("221061044", var_182_18)
						arg_179_1:RecordAudio("221061044", var_182_18)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_221061", "221061044", "story_v_out_221061.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_221061", "221061044", "story_v_out_221061.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_19 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_19 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_19

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_19 and arg_179_1.time_ < var_182_11 + var_182_19 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play221061045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 221061045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play221061046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1076ui_story"]) and arg_184_1.var_.characterEffect1076ui_story == nil then
				arg_184_1.var_.characterEffect1076ui_story = arg_184_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1076ui_story"]) then
				if arg_184_1.var_.characterEffect1076ui_story and not isNil(arg_184_1.actors_["1076ui_story"]) then
					arg_184_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1076ui_story"]) and arg_184_1.var_.characterEffect1076ui_story then
				arg_184_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_187_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_184_1.bgmTxt_.text ~= var_187_3 and arg_184_1.bgmTxt_.text ~= "" then
						if arg_184_1.bgmTxt2_.text ~= "" then
							arg_184_1.bgmTxt_.text = arg_184_1.bgmTxt2_.text
						end

						arg_184_1.bgmTxt2_.text = var_187_3

						arg_184_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_184_1.bgmTxt_.text = var_187_3
						arg_184_1.bgmTxt2_.text = var_187_3
					end

					if arg_184_1.bgmTimer then
						arg_184_1.bgmTimer:Stop()

						arg_184_1.bgmTimer = nil
					end

					if arg_184_1.settingData.show_music_name == 1 then
						arg_184_1.musicController:SetSelectedState("show")
						arg_184_1.musicAnimator_:Play("open", 0, 0)

						if arg_184_1.settingData.music_time ~= 0 then
							arg_184_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_184_1.settingData.music_time), function()
								if arg_184_1 == nil or isNil(arg_184_1.bgmTxt_) then
									return
								end

								arg_184_1.musicController:SetSelectedState("hide")
								arg_184_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_184_1.time_ and arg_184_1.time_ <= 0.233333333333333 + arg_187_0 then
				arg_184_1:AudioAction("play", "music", "bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess.awb")

				local var_187_6 = manager.audio:GetAudioName("bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess")

				if "" ~= "" then
					if arg_184_1.bgmTxt_.text ~= var_187_6 and arg_184_1.bgmTxt_.text ~= "" then
						if arg_184_1.bgmTxt2_.text ~= "" then
							arg_184_1.bgmTxt_.text = arg_184_1.bgmTxt2_.text
						end

						arg_184_1.bgmTxt2_.text = var_187_6

						arg_184_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_184_1.bgmTxt_.text = var_187_6
						arg_184_1.bgmTxt2_.text = var_187_6
					end

					if arg_184_1.bgmTimer then
						arg_184_1.bgmTimer:Stop()

						arg_184_1.bgmTimer = nil
					end

					if arg_184_1.settingData.show_music_name == 1 then
						arg_184_1.musicController:SetSelectedState("show")
						arg_184_1.musicAnimator_:Play("open", 0, 0)

						if arg_184_1.settingData.music_time ~= 0 then
							arg_184_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_184_1.settingData.music_time), function()
								if arg_184_1 == nil or isNil(arg_184_1.bgmTxt_) then
									return
								end

								arg_184_1.musicController:SetSelectedState("hide")
								arg_184_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_187_7 = 0
			local var_187_8 = 0.725

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_9 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(221061045).content)

				arg_184_1.text_.text = var_187_9

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 29 <= 0 and var_187_8 or var_187_8 * (utf8.len(var_187_9) / 29)

				if (29 <= 0 and var_187_8 or var_187_8 * (utf8.len(var_187_9) / 29)) > 0 and var_187_8 < var_187_11 then
					arg_184_1.talkMaxDuration = var_187_11

					if var_187_11 + var_187_7 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_7
					end
				end

				arg_184_1.text_.text = var_187_9
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_8, arg_184_1.talkMaxDuration)

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_7) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_7 + var_187_12 and arg_184_1.time_ < var_187_7 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play221061046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 221061046
		arg_190_1.duration_ = 5

		local var_190_0 = {
			ja = 5,
			ko = 3.8,
			zh = 3.8
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
				arg_190_0:Play221061047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1072ui_story = arg_190_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1072ui_story"].transform.position).z)
				arg_190_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1072ui_story"].transform.localEulerAngles = arg_190_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_190_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1072ui_story"].transform.position).z)
				arg_190_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1072ui_story"].transform.localEulerAngles = arg_190_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1072ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1072ui_story == nil then
				arg_190_1.var_.characterEffect1072ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1072ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1072ui_story then
				arg_190_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_193_4 = 0
			local var_193_5 = 0.325

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(221061046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 13 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 13)

				if (13 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 13)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061046", "story_v_out_221061.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061046", "story_v_out_221061.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_221061", "221061046", "story_v_out_221061.awb")

						arg_190_1:RecordAudio("221061046", var_193_11)
						arg_190_1:RecordAudio("221061046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_221061", "221061046", "story_v_out_221061.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_221061", "221061046", "story_v_out_221061.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play221061047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 221061047
		arg_194_1.duration_ = 4.87

		local var_194_0 = {
			ja = 4.866,
			ko = 4.166,
			zh = 4.166
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
				arg_194_0:Play221061048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if arg_194_1.bgs_.XH0801 == nil then
				local var_197_0 = Object.Instantiate(arg_194_1.paintGo_)

				var_197_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0801")
				var_197_0.name = "XH0801"
				var_197_0.transform.parent = arg_194_1.stage_.transform
				var_197_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.bgs_.XH0801 = var_197_0
			end

			if 2 < arg_194_1.time_ and arg_194_1.time_ <= 2 + arg_197_0 then
				local var_197_1 = arg_194_1.bgs_.XH0801

				arg_194_1.bgs_.XH0801.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_197_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_2 = var_197_1:GetComponent("SpriteRenderer")

				if var_197_2 and var_197_2.sprite then
					local var_197_3 = 2 * (var_197_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_197_1.transform.localScale = Vector3.New(var_197_3 / var_197_2.sprite.bounds.size.y < var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x and var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x or var_197_3 / var_197_2.sprite.bounds.size.y, var_197_3 / var_197_2.sprite.bounds.size.y < var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x and var_197_3 * manager.ui.mainCameraCom_.aspect / var_197_2.sprite.bounds.size.x or var_197_3 / var_197_2.sprite.bounds.size.y, 0)
				end

				for iter_197_0, iter_197_1 in pairs(arg_194_1.bgs_) do
					if iter_197_0 ~= "XH0801" then
						iter_197_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_197_4 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_5 = 2

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_5 then
				local var_197_6 = Color.New(0, 0, 0)

				var_197_6.a = Mathf.Lerp(0, 1, (arg_194_1.time_ - var_197_4) / var_197_5)
				arg_194_1.mask_.color = var_197_6
			end

			if arg_194_1.time_ >= var_197_4 + var_197_5 and arg_194_1.time_ < var_197_4 + var_197_5 + arg_197_0 then
				local var_197_7 = Color.New(0, 0, 0)

				var_197_7.a = 1
				arg_194_1.mask_.color = var_197_7
			end

			local var_197_8 = 2

			if 2 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_9 = 2

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_9 then
				local var_197_10 = Color.New(0, 0, 0)

				var_197_10.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_8) / var_197_9)
				arg_194_1.mask_.color = var_197_10
			end

			if arg_194_1.time_ >= var_197_8 + var_197_9 and arg_194_1.time_ < var_197_8 + var_197_9 + arg_197_0 then
				local var_197_11 = Color.New(0, 0, 0)

				arg_194_1.mask_.enabled = false
				var_197_11.a = 0
				arg_194_1.mask_.color = var_197_11
			end

			local var_197_12 = arg_194_1.actors_["1076ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1076ui_story = var_197_12.localPosition
			end

			local var_197_13 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_13 then
				var_197_12.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_13)
				var_197_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_12.position).x, (manager.ui.mainCamera.transform.position - var_197_12.position).y, (manager.ui.mainCamera.transform.position - var_197_12.position).z)
				var_197_12.localEulerAngles.z = 0
				var_197_12.localEulerAngles.x = 0
				var_197_12.localEulerAngles = var_197_12.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_13 and arg_194_1.time_ < 0 + var_197_13 + arg_197_0 then
				var_197_12.localPosition = Vector3.New(0, 100, 0)
				var_197_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_12.position).x, (manager.ui.mainCamera.transform.position - var_197_12.position).y, (manager.ui.mainCamera.transform.position - var_197_12.position).z)
				var_197_12.localEulerAngles.z = 0
				var_197_12.localEulerAngles.x = 0
				var_197_12.localEulerAngles = var_197_12.localEulerAngles
			end

			local var_197_14 = arg_194_1.actors_["1072ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1072ui_story = var_197_14.localPosition
			end

			local var_197_15 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_15 then
				var_197_14.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_15)
				var_197_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_14.position).x, (manager.ui.mainCamera.transform.position - var_197_14.position).y, (manager.ui.mainCamera.transform.position - var_197_14.position).z)
				var_197_14.localEulerAngles.z = 0
				var_197_14.localEulerAngles.x = 0
				var_197_14.localEulerAngles = var_197_14.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_15 and arg_194_1.time_ < 0 + var_197_15 + arg_197_0 then
				var_197_14.localPosition = Vector3.New(0, 100, 0)
				var_197_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_14.position).x, (manager.ui.mainCamera.transform.position - var_197_14.position).y, (manager.ui.mainCamera.transform.position - var_197_14.position).z)
				var_197_14.localEulerAngles.z = 0
				var_197_14.localEulerAngles.x = 0
				var_197_14.localEulerAngles = var_197_14.localEulerAngles
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_16 = 4
			local var_197_17 = 0.05

			if 4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_18 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_18:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_194_1.dialogCg_.alpha = arg_198_0
				end))
				var_197_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_19 = arg_194_1:GetWordFromCfg(221061047)
				local var_197_20 = arg_194_1:FormatText(var_197_19.content)

				arg_194_1.text_.text = var_197_20

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_22 = 2 <= 0 and var_197_17 or var_197_17 * (utf8.len(var_197_20) / 2)

				if (2 <= 0 and var_197_17 or var_197_17 * (utf8.len(var_197_20) / 2)) > 0 and var_197_17 < var_197_22 then
					arg_194_1.talkMaxDuration = var_197_22
					var_197_16 = var_197_16 + 0.3

					if var_197_22 + var_197_16 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_22 + var_197_16
					end
				end

				arg_194_1.text_.text = var_197_20
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061047", "story_v_out_221061.awb") ~= 0 then
					local var_197_23 = manager.audio:GetVoiceLength("story_v_out_221061", "221061047", "story_v_out_221061.awb") / 1000

					if var_197_23 + var_197_16 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_23 + var_197_16
					end

					if var_197_19.prefab_name ~= "" and arg_194_1.actors_[var_197_19.prefab_name] ~= nil then
						local var_197_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_19.prefab_name].transform, "story_v_out_221061", "221061047", "story_v_out_221061.awb")

						arg_194_1:RecordAudio("221061047", var_197_24)
						arg_194_1:RecordAudio("221061047", var_197_24)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_221061", "221061047", "story_v_out_221061.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_221061", "221061047", "story_v_out_221061.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_25 = var_197_16 + 0.3
			local var_197_26 = math.max(var_197_17, arg_194_1.talkMaxDuration)

			if var_197_16 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_25 + var_197_26 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_25) / var_197_26

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_25 + var_197_26 and arg_194_1.time_ < var_197_25 + var_197_26 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play221061048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 221061048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play221061049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.7

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(221061048).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 28 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 28)

				if (28 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 28)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play221061049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 221061049
		arg_204_1.duration_ = 18.1

		local var_204_0 = {
			ja = 18.1,
			ko = 16.1,
			zh = 16.1
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play221061050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if arg_204_1.bgs_.XH0802 == nil then
				local var_207_0 = Object.Instantiate(arg_204_1.paintGo_)

				var_207_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0802")
				var_207_0.name = "XH0802"
				var_207_0.transform.parent = arg_204_1.stage_.transform
				var_207_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.bgs_.XH0802 = var_207_0
			end

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= 2 + arg_207_0 then
				local var_207_1 = arg_204_1.bgs_.XH0802

				arg_204_1.bgs_.XH0802.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_207_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_2 = var_207_1:GetComponent("SpriteRenderer")

				if var_207_2 and var_207_2.sprite then
					local var_207_3 = 2 * (var_207_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_207_1.transform.localScale = Vector3.New(var_207_3 / var_207_2.sprite.bounds.size.y < var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x and var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x or var_207_3 / var_207_2.sprite.bounds.size.y, var_207_3 / var_207_2.sprite.bounds.size.y < var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x and var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x or var_207_3 / var_207_2.sprite.bounds.size.y, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "XH0802" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_4 = 0

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_5 = 2

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_5 then
				local var_207_6 = Color.New(0, 0, 0)

				var_207_6.a = Mathf.Lerp(0, 1, (arg_204_1.time_ - var_207_4) / var_207_5)
				arg_204_1.mask_.color = var_207_6
			end

			if arg_204_1.time_ >= var_207_4 + var_207_5 and arg_204_1.time_ < var_207_4 + var_207_5 + arg_207_0 then
				local var_207_7 = Color.New(0, 0, 0)

				var_207_7.a = 1
				arg_204_1.mask_.color = var_207_7
			end

			local var_207_8 = 2

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_9 = 2

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_9 then
				local var_207_10 = Color.New(0, 0, 0)

				var_207_10.a = Mathf.Lerp(1, 0, (arg_204_1.time_ - var_207_8) / var_207_9)
				arg_204_1.mask_.color = var_207_10
			end

			if arg_204_1.time_ >= var_207_8 + var_207_9 and arg_204_1.time_ < var_207_8 + var_207_9 + arg_207_0 then
				local var_207_11 = Color.New(0, 0, 0)

				arg_204_1.mask_.enabled = false
				var_207_11.a = 0
				arg_204_1.mask_.color = var_207_11
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_12 = 4
			local var_207_13 = 1.2

			if 4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_14 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_14:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_15 = arg_204_1:GetWordFromCfg(221061049)
				local var_207_16 = arg_204_1:FormatText(var_207_15.content)

				arg_204_1.text_.text = var_207_16

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_18 = 48 <= 0 and var_207_13 or var_207_13 * (utf8.len(var_207_16) / 48)

				if (48 <= 0 and var_207_13 or var_207_13 * (utf8.len(var_207_16) / 48)) > 0 and var_207_13 < var_207_18 then
					arg_204_1.talkMaxDuration = var_207_18
					var_207_12 = var_207_12 + 0.3

					if var_207_18 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_18 + var_207_12
					end
				end

				arg_204_1.text_.text = var_207_16
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061049", "story_v_out_221061.awb") ~= 0 then
					local var_207_19 = manager.audio:GetVoiceLength("story_v_out_221061", "221061049", "story_v_out_221061.awb") / 1000

					if var_207_19 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_19 + var_207_12
					end

					if var_207_15.prefab_name ~= "" and arg_204_1.actors_[var_207_15.prefab_name] ~= nil then
						local var_207_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_15.prefab_name].transform, "story_v_out_221061", "221061049", "story_v_out_221061.awb")

						arg_204_1:RecordAudio("221061049", var_207_20)
						arg_204_1:RecordAudio("221061049", var_207_20)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_221061", "221061049", "story_v_out_221061.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_221061", "221061049", "story_v_out_221061.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_21 = var_207_12 + 0.3
			local var_207_22 = math.max(var_207_13, arg_204_1.talkMaxDuration)

			if var_207_12 + 0.3 <= arg_204_1.time_ and arg_204_1.time_ < var_207_21 + var_207_22 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_21) / var_207_22

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_21 + var_207_22 and arg_204_1.time_ < var_207_21 + var_207_22 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play221061050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 221061050
		arg_210_1.duration_ = 10.2

		local var_210_0 = {
			ja = 10.2,
			ko = 5.1,
			zh = 5.1
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
				arg_210_0:Play221061051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.575

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_1 = arg_210_1:GetWordFromCfg(221061050)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 23 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 23)

				if (23 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 23)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061050", "story_v_out_221061.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061050", "story_v_out_221061.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_221061", "221061050", "story_v_out_221061.awb")

						arg_210_1:RecordAudio("221061050", var_213_6)
						arg_210_1:RecordAudio("221061050", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_221061", "221061050", "story_v_out_221061.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_221061", "221061050", "story_v_out_221061.awb")
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
	Play221061051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 221061051
		arg_214_1.duration_ = 22.7

		local var_214_0 = {
			ja = 22.7,
			ko = 10.7,
			zh = 10.7
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
				arg_214_0:Play221061052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if arg_214_1.bgs_.XH0804 == nil then
				local var_217_0 = Object.Instantiate(arg_214_1.paintGo_)

				var_217_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0804")
				var_217_0.name = "XH0804"
				var_217_0.transform.parent = arg_214_1.stage_.transform
				var_217_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.bgs_.XH0804 = var_217_0
			end

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= 2 + arg_217_0 then
				local var_217_1 = arg_214_1.bgs_.XH0804

				arg_214_1.bgs_.XH0804.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_217_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_217_2 = var_217_1:GetComponent("SpriteRenderer")

				if var_217_2 and var_217_2.sprite then
					local var_217_3 = 2 * (var_217_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_217_1.transform.localScale = Vector3.New(var_217_3 / var_217_2.sprite.bounds.size.y < var_217_3 * manager.ui.mainCameraCom_.aspect / var_217_2.sprite.bounds.size.x and var_217_3 * manager.ui.mainCameraCom_.aspect / var_217_2.sprite.bounds.size.x or var_217_3 / var_217_2.sprite.bounds.size.y, var_217_3 / var_217_2.sprite.bounds.size.y < var_217_3 * manager.ui.mainCameraCom_.aspect / var_217_2.sprite.bounds.size.x and var_217_3 * manager.ui.mainCameraCom_.aspect / var_217_2.sprite.bounds.size.x or var_217_3 / var_217_2.sprite.bounds.size.y, 0)
				end

				for iter_217_0, iter_217_1 in pairs(arg_214_1.bgs_) do
					if iter_217_0 ~= "XH0804" then
						iter_217_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_217_4 = 0

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_5 = 2

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_5 then
				local var_217_6 = Color.New(0, 0, 0)

				var_217_6.a = Mathf.Lerp(0, 1, (arg_214_1.time_ - var_217_4) / var_217_5)
				arg_214_1.mask_.color = var_217_6
			end

			if arg_214_1.time_ >= var_217_4 + var_217_5 and arg_214_1.time_ < var_217_4 + var_217_5 + arg_217_0 then
				local var_217_7 = Color.New(0, 0, 0)

				var_217_7.a = 1
				arg_214_1.mask_.color = var_217_7
			end

			local var_217_8 = 2

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_9 = 2

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_9 then
				local var_217_10 = Color.New(0, 0, 0)

				var_217_10.a = Mathf.Lerp(1, 0, (arg_214_1.time_ - var_217_8) / var_217_9)
				arg_214_1.mask_.color = var_217_10
			end

			if arg_214_1.time_ >= var_217_8 + var_217_9 and arg_214_1.time_ < var_217_8 + var_217_9 + arg_217_0 then
				local var_217_11 = Color.New(0, 0, 0)

				arg_214_1.mask_.enabled = false
				var_217_11.a = 0
				arg_214_1.mask_.color = var_217_11
			end

			if arg_214_1.frameCnt_ <= 1 then
				arg_214_1.dialog_:SetActive(false)
			end

			local var_217_12 = 4
			local var_217_13 = 0.8

			if 4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_12 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0

				arg_214_1.dialog_:SetActive(true)

				arg_214_1.dialogCg_.alpha = 0

				local var_217_14 = LeanTween.value(arg_214_1.dialog_, 0, 1, 0.3)

				var_217_14:setOnUpdate(LuaHelper.FloatAction(function(arg_218_0)
					arg_214_1.dialogCg_.alpha = arg_218_0
				end))
				var_217_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_214_1.dialog_)
					var_217_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_214_1.duration_ = arg_214_1.duration_ + 0.3

				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_15 = arg_214_1:GetWordFromCfg(221061051)
				local var_217_16 = arg_214_1:FormatText(var_217_15.content)

				arg_214_1.text_.text = var_217_16

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_18 = 32 <= 0 and var_217_13 or var_217_13 * (utf8.len(var_217_16) / 32)

				if (32 <= 0 and var_217_13 or var_217_13 * (utf8.len(var_217_16) / 32)) > 0 and var_217_13 < var_217_18 then
					arg_214_1.talkMaxDuration = var_217_18
					var_217_12 = var_217_12 + 0.3

					if var_217_18 + var_217_12 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_18 + var_217_12
					end
				end

				arg_214_1.text_.text = var_217_16
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061051", "story_v_out_221061.awb") ~= 0 then
					local var_217_19 = manager.audio:GetVoiceLength("story_v_out_221061", "221061051", "story_v_out_221061.awb") / 1000

					if var_217_19 + var_217_12 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_19 + var_217_12
					end

					if var_217_15.prefab_name ~= "" and arg_214_1.actors_[var_217_15.prefab_name] ~= nil then
						local var_217_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_15.prefab_name].transform, "story_v_out_221061", "221061051", "story_v_out_221061.awb")

						arg_214_1:RecordAudio("221061051", var_217_20)
						arg_214_1:RecordAudio("221061051", var_217_20)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_221061", "221061051", "story_v_out_221061.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_221061", "221061051", "story_v_out_221061.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_21 = var_217_12 + 0.3
			local var_217_22 = math.max(var_217_13, arg_214_1.talkMaxDuration)

			if var_217_12 + 0.3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_21 + var_217_22 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_21) / var_217_22

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_21 + var_217_22 and arg_214_1.time_ < var_217_21 + var_217_22 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play221061052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 221061052
		arg_220_1.duration_ = 3.17

		local var_220_0 = {
			ja = 3.166,
			ko = 3,
			zh = 3
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play221061053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.3

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:GetWordFromCfg(221061052)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 12 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 12)

				if (12 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 12)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061052", "story_v_out_221061.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061052", "story_v_out_221061.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_221061", "221061052", "story_v_out_221061.awb")

						arg_220_1:RecordAudio("221061052", var_223_6)
						arg_220_1:RecordAudio("221061052", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_221061", "221061052", "story_v_out_221061.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_221061", "221061052", "story_v_out_221061.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play221061053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 221061053
		arg_224_1.duration_ = 21.97

		local var_224_0 = {
			ja = 21.966,
			ko = 13.666,
			zh = 13.666
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play221061054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if arg_224_1.bgs_.XH0805 == nil then
				local var_227_0 = Object.Instantiate(arg_224_1.paintGo_)

				var_227_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0805")
				var_227_0.name = "XH0805"
				var_227_0.transform.parent = arg_224_1.stage_.transform
				var_227_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.bgs_.XH0805 = var_227_0
			end

			if 2 < arg_224_1.time_ and arg_224_1.time_ <= 2 + arg_227_0 then
				local var_227_1 = arg_224_1.bgs_.XH0805

				arg_224_1.bgs_.XH0805.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_227_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_227_2 = var_227_1:GetComponent("SpriteRenderer")

				if var_227_2 and var_227_2.sprite then
					local var_227_3 = 2 * (var_227_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_227_1.transform.localScale = Vector3.New(var_227_3 / var_227_2.sprite.bounds.size.y < var_227_3 * manager.ui.mainCameraCom_.aspect / var_227_2.sprite.bounds.size.x and var_227_3 * manager.ui.mainCameraCom_.aspect / var_227_2.sprite.bounds.size.x or var_227_3 / var_227_2.sprite.bounds.size.y, var_227_3 / var_227_2.sprite.bounds.size.y < var_227_3 * manager.ui.mainCameraCom_.aspect / var_227_2.sprite.bounds.size.x and var_227_3 * manager.ui.mainCameraCom_.aspect / var_227_2.sprite.bounds.size.x or var_227_3 / var_227_2.sprite.bounds.size.y, 0)
				end

				for iter_227_0, iter_227_1 in pairs(arg_224_1.bgs_) do
					if iter_227_0 ~= "XH0805" then
						iter_227_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_227_4 = 0

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.mask_.enabled = true
				arg_224_1.mask_.raycastTarget = true

				arg_224_1:SetGaussion(false)
			end

			local var_227_5 = 2

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_5 then
				local var_227_6 = Color.New(0, 0, 0)

				var_227_6.a = Mathf.Lerp(0, 1, (arg_224_1.time_ - var_227_4) / var_227_5)
				arg_224_1.mask_.color = var_227_6
			end

			if arg_224_1.time_ >= var_227_4 + var_227_5 and arg_224_1.time_ < var_227_4 + var_227_5 + arg_227_0 then
				local var_227_7 = Color.New(0, 0, 0)

				var_227_7.a = 1
				arg_224_1.mask_.color = var_227_7
			end

			local var_227_8 = 2

			if 2 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.mask_.enabled = true
				arg_224_1.mask_.raycastTarget = true

				arg_224_1:SetGaussion(false)
			end

			local var_227_9 = 2

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_9 then
				local var_227_10 = Color.New(0, 0, 0)

				var_227_10.a = Mathf.Lerp(1, 0, (arg_224_1.time_ - var_227_8) / var_227_9)
				arg_224_1.mask_.color = var_227_10
			end

			if arg_224_1.time_ >= var_227_8 + var_227_9 and arg_224_1.time_ < var_227_8 + var_227_9 + arg_227_0 then
				local var_227_11 = Color.New(0, 0, 0)

				arg_224_1.mask_.enabled = false
				var_227_11.a = 0
				arg_224_1.mask_.color = var_227_11
			end

			if arg_224_1.frameCnt_ <= 1 then
				arg_224_1.dialog_:SetActive(false)
			end

			local var_227_12 = 4
			local var_227_13 = 0.875

			if 4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0

				arg_224_1.dialog_:SetActive(true)

				arg_224_1.dialogCg_.alpha = 0

				local var_227_14 = LeanTween.value(arg_224_1.dialog_, 0, 1, 0.3)

				var_227_14:setOnUpdate(LuaHelper.FloatAction(function(arg_228_0)
					arg_224_1.dialogCg_.alpha = arg_228_0
				end))
				var_227_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_224_1.dialog_)
					var_227_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_224_1.duration_ = arg_224_1.duration_ + 0.3

				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_15 = arg_224_1:GetWordFromCfg(221061053)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_18 = 35 <= 0 and var_227_13 or var_227_13 * (utf8.len(var_227_16) / 35)

				if (35 <= 0 and var_227_13 or var_227_13 * (utf8.len(var_227_16) / 35)) > 0 and var_227_13 < var_227_18 then
					arg_224_1.talkMaxDuration = var_227_18
					var_227_12 = var_227_12 + 0.3

					if var_227_18 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_18 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061053", "story_v_out_221061.awb") ~= 0 then
					local var_227_19 = manager.audio:GetVoiceLength("story_v_out_221061", "221061053", "story_v_out_221061.awb") / 1000

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_221061", "221061053", "story_v_out_221061.awb")

						arg_224_1:RecordAudio("221061053", var_227_20)
						arg_224_1:RecordAudio("221061053", var_227_20)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_221061", "221061053", "story_v_out_221061.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_221061", "221061053", "story_v_out_221061.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_21 = var_227_12 + 0.3
			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 + 0.3 <= arg_224_1.time_ and arg_224_1.time_ < var_227_21 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_21) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_21 + var_227_22 and arg_224_1.time_ < var_227_21 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play221061054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 221061054
		arg_230_1.duration_ = 12.43

		local var_230_0 = {
			ja = 12.433,
			ko = 9.633,
			zh = 9.633
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play221061055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.225

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:GetWordFromCfg(221061054)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 49 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 49)

				if (49 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 49)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061054", "story_v_out_221061.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061054", "story_v_out_221061.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_221061", "221061054", "story_v_out_221061.awb")

						arg_230_1:RecordAudio("221061054", var_233_6)
						arg_230_1:RecordAudio("221061054", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_221061", "221061054", "story_v_out_221061.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_221061", "221061054", "story_v_out_221061.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play221061055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 221061055
		arg_234_1.duration_ = 4.33

		local var_234_0 = {
			ja = 4.333,
			ko = 2.666,
			zh = 2.666
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play221061056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.325

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:GetWordFromCfg(221061055)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 13 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 13)

				if (13 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 13)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061055", "story_v_out_221061.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061055", "story_v_out_221061.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_221061", "221061055", "story_v_out_221061.awb")

						arg_234_1:RecordAudio("221061055", var_237_6)
						arg_234_1:RecordAudio("221061055", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_221061", "221061055", "story_v_out_221061.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_221061", "221061055", "story_v_out_221061.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play221061056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 221061056
		arg_238_1.duration_ = 1.03

		local var_238_0 = {
			ja = 1.033,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play221061057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.05

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_1 = arg_238_1:GetWordFromCfg(221061056)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 2 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 2)

				if (2 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 2)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061056", "story_v_out_221061.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061056", "story_v_out_221061.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_221061", "221061056", "story_v_out_221061.awb")

						arg_238_1:RecordAudio("221061056", var_241_6)
						arg_238_1:RecordAudio("221061056", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_221061", "221061056", "story_v_out_221061.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_221061", "221061056", "story_v_out_221061.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play221061057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 221061057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play221061058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.25

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(221061057).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 50 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 50)

				if (50 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 50)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play221061058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 221061058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play221061059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.35

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(221061058).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 14 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 14)

				if (14 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 14)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play221061059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 221061059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play221061060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.775

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(221061059).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 31 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 31)

				if (31 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 31)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play221061060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 221061060
		arg_254_1.duration_ = 4.93

		local var_254_0 = {
			ja = 4.933,
			ko = 3.6,
			zh = 3.6
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play221061061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.425

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_1 = arg_254_1:GetWordFromCfg(221061060)
				local var_257_2 = arg_254_1:FormatText(var_257_1.content)

				arg_254_1.text_.text = var_257_2

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 17 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 17)

				if (17 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 17)) > 0 and var_257_0 < var_257_4 then
					arg_254_1.talkMaxDuration = var_257_4

					if var_257_4 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_4 + 0
					end
				end

				arg_254_1.text_.text = var_257_2
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061060", "story_v_out_221061.awb") ~= 0 then
					local var_257_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061060", "story_v_out_221061.awb") / 1000

					if var_257_5 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + 0
					end

					if var_257_1.prefab_name ~= "" and arg_254_1.actors_[var_257_1.prefab_name] ~= nil then
						local var_257_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_1.prefab_name].transform, "story_v_out_221061", "221061060", "story_v_out_221061.awb")

						arg_254_1:RecordAudio("221061060", var_257_6)
						arg_254_1:RecordAudio("221061060", var_257_6)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_221061", "221061060", "story_v_out_221061.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_221061", "221061060", "story_v_out_221061.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play221061061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 221061061
		arg_258_1.duration_ = 15.7

		local var_258_0 = {
			ja = 15.7,
			ko = 14.833,
			zh = 14.833
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play221061062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if arg_258_1.bgs_.XH0807 == nil then
				local var_261_0 = Object.Instantiate(arg_258_1.paintGo_)

				var_261_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0807")
				var_261_0.name = "XH0807"
				var_261_0.transform.parent = arg_258_1.stage_.transform
				var_261_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.bgs_.XH0807 = var_261_0
			end

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= 2 + arg_261_0 then
				local var_261_1 = arg_258_1.bgs_.XH0807

				arg_258_1.bgs_.XH0807.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_261_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_2 = var_261_1:GetComponent("SpriteRenderer")

				if var_261_2 and var_261_2.sprite then
					local var_261_3 = 2 * (var_261_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_261_1.transform.localScale = Vector3.New(var_261_3 / var_261_2.sprite.bounds.size.y < var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x and var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x or var_261_3 / var_261_2.sprite.bounds.size.y, var_261_3 / var_261_2.sprite.bounds.size.y < var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x and var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x or var_261_3 / var_261_2.sprite.bounds.size.y, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "XH0807" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_4 = 0

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_5 = 2

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_5 then
				local var_261_6 = Color.New(0, 0, 0)

				var_261_6.a = Mathf.Lerp(0, 1, (arg_258_1.time_ - var_261_4) / var_261_5)
				arg_258_1.mask_.color = var_261_6
			end

			if arg_258_1.time_ >= var_261_4 + var_261_5 and arg_258_1.time_ < var_261_4 + var_261_5 + arg_261_0 then
				local var_261_7 = Color.New(0, 0, 0)

				var_261_7.a = 1
				arg_258_1.mask_.color = var_261_7
			end

			local var_261_8 = 2

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_9 = 2

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_9 then
				local var_261_10 = Color.New(0, 0, 0)

				var_261_10.a = Mathf.Lerp(1, 0, (arg_258_1.time_ - var_261_8) / var_261_9)
				arg_258_1.mask_.color = var_261_10
			end

			if arg_258_1.time_ >= var_261_8 + var_261_9 and arg_258_1.time_ < var_261_8 + var_261_9 + arg_261_0 then
				local var_261_11 = Color.New(0, 0, 0)

				arg_258_1.mask_.enabled = false
				var_261_11.a = 0
				arg_258_1.mask_.color = var_261_11
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_12 = 4
			local var_261_13 = 1.275

			if 4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_14 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_14:setOnUpdate(LuaHelper.FloatAction(function(arg_262_0)
					arg_258_1.dialogCg_.alpha = arg_262_0
				end))
				var_261_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_15 = arg_258_1:GetWordFromCfg(221061061)
				local var_261_16 = arg_258_1:FormatText(var_261_15.content)

				arg_258_1.text_.text = var_261_16

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_18 = 51 <= 0 and var_261_13 or var_261_13 * (utf8.len(var_261_16) / 51)

				if (51 <= 0 and var_261_13 or var_261_13 * (utf8.len(var_261_16) / 51)) > 0 and var_261_13 < var_261_18 then
					arg_258_1.talkMaxDuration = var_261_18
					var_261_12 = var_261_12 + 0.3

					if var_261_18 + var_261_12 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_18 + var_261_12
					end
				end

				arg_258_1.text_.text = var_261_16
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061061", "story_v_out_221061.awb") ~= 0 then
					local var_261_19 = manager.audio:GetVoiceLength("story_v_out_221061", "221061061", "story_v_out_221061.awb") / 1000

					if var_261_19 + var_261_12 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_19 + var_261_12
					end

					if var_261_15.prefab_name ~= "" and arg_258_1.actors_[var_261_15.prefab_name] ~= nil then
						local var_261_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_15.prefab_name].transform, "story_v_out_221061", "221061061", "story_v_out_221061.awb")

						arg_258_1:RecordAudio("221061061", var_261_20)
						arg_258_1:RecordAudio("221061061", var_261_20)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_221061", "221061061", "story_v_out_221061.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_221061", "221061061", "story_v_out_221061.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_21 = var_261_12 + 0.3
			local var_261_22 = math.max(var_261_13, arg_258_1.talkMaxDuration)

			if var_261_12 + 0.3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_21 + var_261_22 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_21) / var_261_22

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_21 + var_261_22 and arg_258_1.time_ < var_261_21 + var_261_22 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play221061062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 221061062
		arg_264_1.duration_ = 3.7

		local var_264_0 = {
			ja = 3.7,
			ko = 3.633,
			zh = 3.633
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play221061063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.375

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:GetWordFromCfg(221061062)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 15 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 15)

				if (15 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 15)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061062", "story_v_out_221061.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061062", "story_v_out_221061.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_221061", "221061062", "story_v_out_221061.awb")

						arg_264_1:RecordAudio("221061062", var_267_6)
						arg_264_1:RecordAudio("221061062", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_221061", "221061062", "story_v_out_221061.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_221061", "221061062", "story_v_out_221061.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play221061063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 221061063
		arg_268_1.duration_ = 17.07

		local var_268_0 = {
			ja = 17.066,
			ko = 10,
			zh = 10
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play221061064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if arg_268_1.bgs_.XH0808 == nil then
				local var_271_0 = Object.Instantiate(arg_268_1.paintGo_)

				var_271_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0808")
				var_271_0.name = "XH0808"
				var_271_0.transform.parent = arg_268_1.stage_.transform
				var_271_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_268_1.bgs_.XH0808 = var_271_0
			end

			if 2 < arg_268_1.time_ and arg_268_1.time_ <= 2 + arg_271_0 then
				local var_271_1 = arg_268_1.bgs_.XH0808

				arg_268_1.bgs_.XH0808.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_271_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_271_2 = var_271_1:GetComponent("SpriteRenderer")

				if var_271_2 and var_271_2.sprite then
					local var_271_3 = 2 * (var_271_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_271_1.transform.localScale = Vector3.New(var_271_3 / var_271_2.sprite.bounds.size.y < var_271_3 * manager.ui.mainCameraCom_.aspect / var_271_2.sprite.bounds.size.x and var_271_3 * manager.ui.mainCameraCom_.aspect / var_271_2.sprite.bounds.size.x or var_271_3 / var_271_2.sprite.bounds.size.y, var_271_3 / var_271_2.sprite.bounds.size.y < var_271_3 * manager.ui.mainCameraCom_.aspect / var_271_2.sprite.bounds.size.x and var_271_3 * manager.ui.mainCameraCom_.aspect / var_271_2.sprite.bounds.size.x or var_271_3 / var_271_2.sprite.bounds.size.y, 0)
				end

				for iter_271_0, iter_271_1 in pairs(arg_268_1.bgs_) do
					if iter_271_0 ~= "XH0808" then
						iter_271_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_271_4 = 0

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_5 = 2

			if var_271_4 <= arg_268_1.time_ and arg_268_1.time_ < var_271_4 + var_271_5 then
				local var_271_6 = Color.New(0, 0, 0)

				var_271_6.a = Mathf.Lerp(0, 1, (arg_268_1.time_ - var_271_4) / var_271_5)
				arg_268_1.mask_.color = var_271_6
			end

			if arg_268_1.time_ >= var_271_4 + var_271_5 and arg_268_1.time_ < var_271_4 + var_271_5 + arg_271_0 then
				local var_271_7 = Color.New(0, 0, 0)

				var_271_7.a = 1
				arg_268_1.mask_.color = var_271_7
			end

			local var_271_8 = 2

			if 2 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_9 = 2

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_9 then
				local var_271_10 = Color.New(0, 0, 0)

				var_271_10.a = Mathf.Lerp(1, 0, (arg_268_1.time_ - var_271_8) / var_271_9)
				arg_268_1.mask_.color = var_271_10
			end

			if arg_268_1.time_ >= var_271_8 + var_271_9 and arg_268_1.time_ < var_271_8 + var_271_9 + arg_271_0 then
				local var_271_11 = Color.New(0, 0, 0)

				arg_268_1.mask_.enabled = false
				var_271_11.a = 0
				arg_268_1.mask_.color = var_271_11
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_12 = 4
			local var_271_13 = 0.6

			if 4 < arg_268_1.time_ and arg_268_1.time_ <= var_271_12 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_14 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_14:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_15 = arg_268_1:GetWordFromCfg(221061063)
				local var_271_16 = arg_268_1:FormatText(var_271_15.content)

				arg_268_1.text_.text = var_271_16

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_18 = 24 <= 0 and var_271_13 or var_271_13 * (utf8.len(var_271_16) / 24)

				if (24 <= 0 and var_271_13 or var_271_13 * (utf8.len(var_271_16) / 24)) > 0 and var_271_13 < var_271_18 then
					arg_268_1.talkMaxDuration = var_271_18
					var_271_12 = var_271_12 + 0.3

					if var_271_18 + var_271_12 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_18 + var_271_12
					end
				end

				arg_268_1.text_.text = var_271_16
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061063", "story_v_out_221061.awb") ~= 0 then
					local var_271_19 = manager.audio:GetVoiceLength("story_v_out_221061", "221061063", "story_v_out_221061.awb") / 1000

					if var_271_19 + var_271_12 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_19 + var_271_12
					end

					if var_271_15.prefab_name ~= "" and arg_268_1.actors_[var_271_15.prefab_name] ~= nil then
						local var_271_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_15.prefab_name].transform, "story_v_out_221061", "221061063", "story_v_out_221061.awb")

						arg_268_1:RecordAudio("221061063", var_271_20)
						arg_268_1:RecordAudio("221061063", var_271_20)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_221061", "221061063", "story_v_out_221061.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_221061", "221061063", "story_v_out_221061.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_21 = var_271_12 + 0.3
			local var_271_22 = math.max(var_271_13, arg_268_1.talkMaxDuration)

			if var_271_12 + 0.3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_21 + var_271_22 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_21) / var_271_22

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_21 + var_271_22 and arg_268_1.time_ < var_271_21 + var_271_22 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play221061064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 221061064
		arg_274_1.duration_ = 4.23

		local var_274_0 = {
			ja = 4.233,
			ko = 3,
			zh = 3
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play221061065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.25

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:GetWordFromCfg(221061064)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 10 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 10)

				if (10 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 10)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061064", "story_v_out_221061.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061064", "story_v_out_221061.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_out_221061", "221061064", "story_v_out_221061.awb")

						arg_274_1:RecordAudio("221061064", var_277_6)
						arg_274_1:RecordAudio("221061064", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_221061", "221061064", "story_v_out_221061.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_221061", "221061064", "story_v_out_221061.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play221061065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 221061065
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play221061066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.725

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(221061065).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 29 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 29)

				if (29 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 29)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play221061066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 221061066
		arg_282_1.duration_ = 3.93

		local var_282_0 = {
			ja = 3.933,
			ko = 3.6,
			zh = 3.6
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
				arg_282_0:Play221061067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if arg_282_1.bgs_.STblack == nil then
				local var_285_0 = Object.Instantiate(arg_282_1.paintGo_)

				var_285_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_285_0.name = "STblack"
				var_285_0.transform.parent = arg_282_1.stage_.transform
				var_285_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.bgs_.STblack = var_285_0
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_1 = arg_282_1.bgs_.STblack

				arg_282_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_285_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_2 = var_285_1:GetComponent("SpriteRenderer")

				if var_285_2 and var_285_2.sprite then
					local var_285_3 = 2 * (var_285_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_285_1.transform.localScale = Vector3.New(var_285_3 / var_285_2.sprite.bounds.size.y < var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x and var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x or var_285_3 / var_285_2.sprite.bounds.size.y, var_285_3 / var_285_2.sprite.bounds.size.y < var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x and var_285_3 * manager.ui.mainCameraCom_.aspect / var_285_2.sprite.bounds.size.x or var_285_3 / var_285_2.sprite.bounds.size.y, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "STblack" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_4 = 0

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_5 = 2

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_5 then
				local var_285_6 = Color.New(0, 0, 0)

				var_285_6.a = Mathf.Lerp(1, 0, (arg_282_1.time_ - var_285_4) / var_285_5)
				arg_282_1.mask_.color = var_285_6
			end

			if arg_282_1.time_ >= var_285_4 + var_285_5 and arg_282_1.time_ < var_285_4 + var_285_5 + arg_285_0 then
				local var_285_7 = Color.New(0, 0, 0)

				arg_282_1.mask_.enabled = false
				var_285_7.a = 0
				arg_282_1.mask_.color = var_285_7
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_8 = 2
			local var_285_9 = 0.1

			if 2 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_10 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_10:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_11 = arg_282_1:GetWordFromCfg(221061066)
				local var_285_12 = arg_282_1:FormatText(var_285_11.content)

				arg_282_1.text_.text = var_285_12

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_14 = 4 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_12) / 4)

				if (4 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_12) / 4)) > 0 and var_285_9 < var_285_14 then
					arg_282_1.talkMaxDuration = var_285_14
					var_285_8 = var_285_8 + 0.3

					if var_285_14 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_14 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_12
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061066", "story_v_out_221061.awb") ~= 0 then
					local var_285_15 = manager.audio:GetVoiceLength("story_v_out_221061", "221061066", "story_v_out_221061.awb") / 1000

					if var_285_15 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_15 + var_285_8
					end

					if var_285_11.prefab_name ~= "" and arg_282_1.actors_[var_285_11.prefab_name] ~= nil then
						local var_285_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_11.prefab_name].transform, "story_v_out_221061", "221061066", "story_v_out_221061.awb")

						arg_282_1:RecordAudio("221061066", var_285_16)
						arg_282_1:RecordAudio("221061066", var_285_16)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_221061", "221061066", "story_v_out_221061.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_221061", "221061066", "story_v_out_221061.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_17 = var_285_8 + 0.3
			local var_285_18 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 + 0.3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_17 + var_285_18 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_17) / var_285_18

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_17 + var_285_18 and arg_282_1.time_ < var_285_17 + var_285_18 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play221061067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 221061067
		arg_288_1.duration_ = 8.02

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play221061068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if arg_288_1.bgs_.XH0404 == nil then
				local var_291_0 = Object.Instantiate(arg_288_1.paintGo_)

				var_291_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0404")
				var_291_0.name = "XH0404"
				var_291_0.transform.parent = arg_288_1.stage_.transform
				var_291_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_288_1.bgs_.XH0404 = var_291_0
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				local var_291_1 = arg_288_1.bgs_.XH0404

				arg_288_1.bgs_.XH0404.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_291_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_291_2 = var_291_1:GetComponent("SpriteRenderer")

				if var_291_2 and var_291_2.sprite then
					local var_291_3 = 2 * (var_291_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_291_1.transform.localScale = Vector3.New(var_291_3 / var_291_2.sprite.bounds.size.y < var_291_3 * manager.ui.mainCameraCom_.aspect / var_291_2.sprite.bounds.size.x and var_291_3 * manager.ui.mainCameraCom_.aspect / var_291_2.sprite.bounds.size.x or var_291_3 / var_291_2.sprite.bounds.size.y, var_291_3 / var_291_2.sprite.bounds.size.y < var_291_3 * manager.ui.mainCameraCom_.aspect / var_291_2.sprite.bounds.size.x and var_291_3 * manager.ui.mainCameraCom_.aspect / var_291_2.sprite.bounds.size.x or var_291_3 / var_291_2.sprite.bounds.size.y, 0)
				end

				for iter_291_0, iter_291_1 in pairs(arg_288_1.bgs_) do
					if iter_291_0 ~= "XH0404" then
						iter_291_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_291_4 = 0

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_5 = 4

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_5 then
				local var_291_6 = Color.New(0, 0, 0)

				var_291_6.a = Mathf.Lerp(1, 0, (arg_288_1.time_ - var_291_4) / var_291_5)
				arg_288_1.mask_.color = var_291_6
			end

			if arg_288_1.time_ >= var_291_4 + var_291_5 and arg_288_1.time_ < var_291_4 + var_291_5 + arg_291_0 then
				local var_291_7 = Color.New(0, 0, 0)

				arg_288_1.mask_.enabled = false
				var_291_7.a = 0
				arg_288_1.mask_.color = var_291_7
			end

			local var_291_8 = arg_288_1.bgs_.XH0404.transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPosXH0404 = var_291_8.localPosition
			end

			local var_291_9 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_9 then
				var_291_8.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPosXH0404, Vector3.New(0.05, 1, 8.5), (arg_288_1.time_ - 0) / var_291_9)
			end

			if arg_288_1.time_ >= 0 + var_291_9 and arg_288_1.time_ < 0 + var_291_9 + arg_291_0 then
				var_291_8.localPosition = Vector3.New(0.05, 1, 8.5)
			end

			local var_291_10 = arg_288_1.bgs_.XH0404.transform

			if 0.0166666666666682 < arg_288_1.time_ and arg_288_1.time_ <= 0.0166666666666682 + arg_291_0 then
				arg_288_1.var_.moveOldPosXH0404 = var_291_10.localPosition
			end

			local var_291_11 = 8

			if 0.0166666666666682 <= arg_288_1.time_ and arg_288_1.time_ < 0.0166666666666682 + var_291_11 then
				var_291_10.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPosXH0404, Vector3.New(0, 1, 10), (arg_288_1.time_ - 0.0166666666666682) / var_291_11)
			end

			if arg_288_1.time_ >= 0.0166666666666682 + var_291_11 and arg_288_1.time_ < 0.0166666666666682 + var_291_11 + arg_291_0 then
				var_291_10.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_12 = 4
			local var_291_13 = 0.225

			if 4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_12 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_14 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_14:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_15 = arg_288_1:GetWordFromCfg(221061067)
				local var_291_16 = arg_288_1:FormatText(var_291_15.content)

				arg_288_1.text_.text = var_291_16

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_18 = 9 <= 0 and var_291_13 or var_291_13 * (utf8.len(var_291_16) / 9)

				if (9 <= 0 and var_291_13 or var_291_13 * (utf8.len(var_291_16) / 9)) > 0 and var_291_13 < var_291_18 then
					arg_288_1.talkMaxDuration = var_291_18
					var_291_12 = var_291_12 + 0.3

					if var_291_18 + var_291_12 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_18 + var_291_12
					end
				end

				arg_288_1.text_.text = var_291_16
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061067", "story_v_out_221061.awb") ~= 0 then
					local var_291_19 = manager.audio:GetVoiceLength("story_v_out_221061", "221061067", "story_v_out_221061.awb") / 1000

					if var_291_19 + var_291_12 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_19 + var_291_12
					end

					if var_291_15.prefab_name ~= "" and arg_288_1.actors_[var_291_15.prefab_name] ~= nil then
						local var_291_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_15.prefab_name].transform, "story_v_out_221061", "221061067", "story_v_out_221061.awb")

						arg_288_1:RecordAudio("221061067", var_291_20)
						arg_288_1:RecordAudio("221061067", var_291_20)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_221061", "221061067", "story_v_out_221061.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_221061", "221061067", "story_v_out_221061.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_21 = var_291_12 + 0.3
			local var_291_22 = math.max(var_291_13, arg_288_1.talkMaxDuration)

			if var_291_12 + 0.3 <= arg_288_1.time_ and arg_288_1.time_ < var_291_21 + var_291_22 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_21) / var_291_22

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_21 + var_291_22 and arg_288_1.time_ < var_291_21 + var_291_22 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 0.0166666666666682,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play221061068 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 221061068
		arg_294_1.duration_ = 3.23

		local var_294_0 = {
			ja = 2.733,
			ko = 3.233,
			zh = 3.233
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play221061069(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.2

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:GetWordFromCfg(221061068)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 8 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 8)

				if (8 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 8)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061068", "story_v_out_221061.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061068", "story_v_out_221061.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_221061", "221061068", "story_v_out_221061.awb")

						arg_294_1:RecordAudio("221061068", var_297_6)
						arg_294_1:RecordAudio("221061068", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_221061", "221061068", "story_v_out_221061.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_221061", "221061068", "story_v_out_221061.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play221061069 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 221061069
		arg_298_1.duration_ = 6.53

		local var_298_0 = {
			ja = 6.533,
			ko = 5.733,
			zh = 5.733
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
				arg_298_0:Play221061070(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.5

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:GetWordFromCfg(221061069)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 20 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 20)

				if (20 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 20)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061069", "story_v_out_221061.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061069", "story_v_out_221061.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_out_221061", "221061069", "story_v_out_221061.awb")

						arg_298_1:RecordAudio("221061069", var_301_6)
						arg_298_1:RecordAudio("221061069", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_221061", "221061069", "story_v_out_221061.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_221061", "221061069", "story_v_out_221061.awb")
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
	Play221061070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 221061070
		arg_302_1.duration_ = 10.7

		local var_302_0 = {
			ja = 10.7,
			ko = 5.9,
			zh = 5.9
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
				arg_302_0:Play221061071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.775

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:GetWordFromCfg(221061070)
				local var_305_2 = arg_302_1:FormatText(var_305_1.content)

				arg_302_1.text_.text = var_305_2

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_4 = 31 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 31)

				if (31 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 31)) > 0 and var_305_0 < var_305_4 then
					arg_302_1.talkMaxDuration = var_305_4

					if var_305_4 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_4 + 0
					end
				end

				arg_302_1.text_.text = var_305_2
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061070", "story_v_out_221061.awb") ~= 0 then
					local var_305_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061070", "story_v_out_221061.awb") / 1000

					if var_305_5 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + 0
					end

					if var_305_1.prefab_name ~= "" and arg_302_1.actors_[var_305_1.prefab_name] ~= nil then
						local var_305_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_1.prefab_name].transform, "story_v_out_221061", "221061070", "story_v_out_221061.awb")

						arg_302_1:RecordAudio("221061070", var_305_6)
						arg_302_1:RecordAudio("221061070", var_305_6)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_221061", "221061070", "story_v_out_221061.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_221061", "221061070", "story_v_out_221061.awb")
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
	Play221061071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 221061071
		arg_306_1.duration_ = 14.5

		local var_306_0 = {
			ja = 14.5,
			ko = 9.366,
			zh = 9.366
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
				arg_306_0:Play221061072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.125

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:GetWordFromCfg(221061071)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 45 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 45)

				if (45 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 45)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061071", "story_v_out_221061.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061071", "story_v_out_221061.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_221061", "221061071", "story_v_out_221061.awb")

						arg_306_1:RecordAudio("221061071", var_309_6)
						arg_306_1:RecordAudio("221061071", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_221061", "221061071", "story_v_out_221061.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_221061", "221061071", "story_v_out_221061.awb")
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
	Play221061072 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 221061072
		arg_310_1.duration_ = 4.33

		local var_310_0 = {
			ja = 4.333,
			ko = 3.7,
			zh = 3.7
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
				arg_310_0:Play221061073(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.125

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:GetWordFromCfg(221061072)
				local var_313_2 = arg_310_1:FormatText(var_313_1.content)

				arg_310_1.text_.text = var_313_2

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 5 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 5)

				if (5 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 5)) > 0 and var_313_0 < var_313_4 then
					arg_310_1.talkMaxDuration = var_313_4

					if var_313_4 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_4 + 0
					end
				end

				arg_310_1.text_.text = var_313_2
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061072", "story_v_out_221061.awb") ~= 0 then
					local var_313_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061072", "story_v_out_221061.awb") / 1000

					if var_313_5 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + 0
					end

					if var_313_1.prefab_name ~= "" and arg_310_1.actors_[var_313_1.prefab_name] ~= nil then
						local var_313_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_1.prefab_name].transform, "story_v_out_221061", "221061072", "story_v_out_221061.awb")

						arg_310_1:RecordAudio("221061072", var_313_6)
						arg_310_1:RecordAudio("221061072", var_313_6)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_221061", "221061072", "story_v_out_221061.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_221061", "221061072", "story_v_out_221061.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play221061073 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 221061073
		arg_314_1.duration_ = 1

		local var_314_0 = {
			ja = 0.999999999999,
			ko = 1,
			zh = 1
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
				arg_314_0:Play221061074(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.05

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:GetWordFromCfg(221061073)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 2 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 2)

				if (2 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 2)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061073", "story_v_out_221061.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061073", "story_v_out_221061.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_221061", "221061073", "story_v_out_221061.awb")

						arg_314_1:RecordAudio("221061073", var_317_6)
						arg_314_1:RecordAudio("221061073", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_221061", "221061073", "story_v_out_221061.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_221061", "221061073", "story_v_out_221061.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play221061074 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 221061074
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play221061075(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.675

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(221061074).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 27 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 27)

				if (27 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 27)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play221061075 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 221061075
		arg_322_1.duration_ = 4.07

		local var_322_0 = {
			ja = 4.066,
			ko = 3.833,
			zh = 3.833
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
				arg_322_0:Play221061076(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.3

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:GetWordFromCfg(221061075)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 12 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 12)

				if (12 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 12)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061075", "story_v_out_221061.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061075", "story_v_out_221061.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_221061", "221061075", "story_v_out_221061.awb")

						arg_322_1:RecordAudio("221061075", var_325_6)
						arg_322_1:RecordAudio("221061075", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_221061", "221061075", "story_v_out_221061.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_221061", "221061075", "story_v_out_221061.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play221061076 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 221061076
		arg_326_1.duration_ = 11.57

		local var_326_0 = {
			ja = 11.566,
			ko = 8.766,
			zh = 8.766
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
				arg_326_0:Play221061077(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.975

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:GetWordFromCfg(221061076)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 39 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 39)

				if (39 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 39)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061076", "story_v_out_221061.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061076", "story_v_out_221061.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_221061", "221061076", "story_v_out_221061.awb")

						arg_326_1:RecordAudio("221061076", var_329_6)
						arg_326_1:RecordAudio("221061076", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_221061", "221061076", "story_v_out_221061.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_221061", "221061076", "story_v_out_221061.awb")
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
	Play221061077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 221061077
		arg_330_1.duration_ = 6.57

		local var_330_0 = {
			ja = 6.566,
			ko = 4.766,
			zh = 4.766
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
				arg_330_0:Play221061078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.55

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(221061077)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 22 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 22)

				if (22 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 22)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061077", "story_v_out_221061.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061077", "story_v_out_221061.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_221061", "221061077", "story_v_out_221061.awb")

						arg_330_1:RecordAudio("221061077", var_333_6)
						arg_330_1:RecordAudio("221061077", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_221061", "221061077", "story_v_out_221061.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_221061", "221061077", "story_v_out_221061.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play221061078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 221061078
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play221061079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 1.8

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(221061078).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 71 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 71)

				if (71 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 71)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play221061079 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 221061079
		arg_338_1.duration_ = 10.3

		local var_338_0 = {
			ja = 9.366,
			ko = 10.3,
			zh = 10.3
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play221061080(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 2 < arg_338_1.time_ and arg_338_1.time_ <= 2 + arg_341_0 then
				local var_341_0 = arg_338_1.bgs_.ST39

				arg_338_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_341_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_1 = var_341_0:GetComponent("SpriteRenderer")

				if var_341_1 and var_341_1.sprite then
					local var_341_2 = 2 * (var_341_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_341_0.transform.localScale = Vector3.New(var_341_2 / var_341_1.sprite.bounds.size.y < var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x and var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x or var_341_2 / var_341_1.sprite.bounds.size.y, var_341_2 / var_341_1.sprite.bounds.size.y < var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x and var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x or var_341_2 / var_341_1.sprite.bounds.size.y, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "ST39" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_3 = 0

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_3 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_4 = 2

			if var_341_3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_3 + var_341_4 then
				local var_341_5 = Color.New(0, 0, 0)

				var_341_5.a = Mathf.Lerp(0, 1, (arg_338_1.time_ - var_341_3) / var_341_4)
				arg_338_1.mask_.color = var_341_5
			end

			if arg_338_1.time_ >= var_341_3 + var_341_4 and arg_338_1.time_ < var_341_3 + var_341_4 + arg_341_0 then
				local var_341_6 = Color.New(0, 0, 0)

				var_341_6.a = 1
				arg_338_1.mask_.color = var_341_6
			end

			local var_341_7 = 2

			if 2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_7 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_8 = 2

			if var_341_7 <= arg_338_1.time_ and arg_338_1.time_ < var_341_7 + var_341_8 then
				local var_341_9 = Color.New(0, 0, 0)

				var_341_9.a = Mathf.Lerp(1, 0, (arg_338_1.time_ - var_341_7) / var_341_8)
				arg_338_1.mask_.color = var_341_9
			end

			if arg_338_1.time_ >= var_341_7 + var_341_8 and arg_338_1.time_ < var_341_7 + var_341_8 + arg_341_0 then
				local var_341_10 = Color.New(0, 0, 0)

				arg_338_1.mask_.enabled = false
				var_341_10.a = 0
				arg_338_1.mask_.color = var_341_10
			end

			local var_341_11 = arg_338_1.actors_["1072ui_story"].transform

			if 4 < arg_338_1.time_ and arg_338_1.time_ <= 4 + arg_341_0 then
				arg_338_1.var_.moveOldPos1072ui_story = var_341_11.localPosition
			end

			local var_341_12 = 0.001

			if 4 <= arg_338_1.time_ and arg_338_1.time_ < 4 + var_341_12 then
				var_341_11.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_338_1.time_ - 4) / var_341_12)
				var_341_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_11.position).x, (manager.ui.mainCamera.transform.position - var_341_11.position).y, (manager.ui.mainCamera.transform.position - var_341_11.position).z)
				var_341_11.localEulerAngles.z = 0
				var_341_11.localEulerAngles.x = 0
				var_341_11.localEulerAngles = var_341_11.localEulerAngles
			end

			if arg_338_1.time_ >= 4 + var_341_12 and arg_338_1.time_ < 4 + var_341_12 + arg_341_0 then
				var_341_11.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_341_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_11.position).x, (manager.ui.mainCamera.transform.position - var_341_11.position).y, (manager.ui.mainCamera.transform.position - var_341_11.position).z)
				var_341_11.localEulerAngles.z = 0
				var_341_11.localEulerAngles.x = 0
				var_341_11.localEulerAngles = var_341_11.localEulerAngles
			end

			local var_341_13 = arg_338_1.actors_["1072ui_story"]

			if 4 < arg_338_1.time_ and arg_338_1.time_ <= 4 + arg_341_0 and not isNil(var_341_13) and arg_338_1.var_.characterEffect1072ui_story == nil then
				arg_338_1.var_.characterEffect1072ui_story = var_341_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_14 = 0.200000002980232

			if 4 <= arg_338_1.time_ and arg_338_1.time_ < 4 + var_341_14 and not isNil(var_341_13) then
				if arg_338_1.var_.characterEffect1072ui_story and not isNil(var_341_13) then
					arg_338_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 4 + var_341_14 and arg_338_1.time_ < 4 + var_341_14 + arg_341_0 and not isNil(var_341_13) and arg_338_1.var_.characterEffect1072ui_story then
				arg_338_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 4 < arg_338_1.time_ and arg_338_1.time_ <= 4 + arg_341_0 then
				arg_338_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 4 < arg_338_1.time_ and arg_338_1.time_ <= 4 + arg_341_0 then
				arg_338_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_338_1.frameCnt_ <= 1 then
				arg_338_1.dialog_:SetActive(false)
			end

			local var_341_16 = 4
			local var_341_17 = 0.8

			if 4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				arg_338_1.dialog_:SetActive(true)

				arg_338_1.dialogCg_.alpha = 0

				local var_341_18 = LeanTween.value(arg_338_1.dialog_, 0, 1, 0.3)

				var_341_18:setOnUpdate(LuaHelper.FloatAction(function(arg_342_0)
					arg_338_1.dialogCg_.alpha = arg_342_0
				end))
				var_341_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_338_1.dialog_)
					var_341_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_338_1.duration_ = arg_338_1.duration_ + 0.3

				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_19 = arg_338_1:GetWordFromCfg(221061079)
				local var_341_20 = arg_338_1:FormatText(var_341_19.content)

				arg_338_1.text_.text = var_341_20

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_22 = 32 <= 0 and var_341_17 or var_341_17 * (utf8.len(var_341_20) / 32)

				if (32 <= 0 and var_341_17 or var_341_17 * (utf8.len(var_341_20) / 32)) > 0 and var_341_17 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22
					var_341_16 = var_341_16 + 0.3

					if var_341_22 + var_341_16 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_16
					end
				end

				arg_338_1.text_.text = var_341_20
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061079", "story_v_out_221061.awb") ~= 0 then
					local var_341_23 = manager.audio:GetVoiceLength("story_v_out_221061", "221061079", "story_v_out_221061.awb") / 1000

					if var_341_23 + var_341_16 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_16
					end

					if var_341_19.prefab_name ~= "" and arg_338_1.actors_[var_341_19.prefab_name] ~= nil then
						local var_341_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_19.prefab_name].transform, "story_v_out_221061", "221061079", "story_v_out_221061.awb")

						arg_338_1:RecordAudio("221061079", var_341_24)
						arg_338_1:RecordAudio("221061079", var_341_24)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_221061", "221061079", "story_v_out_221061.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_221061", "221061079", "story_v_out_221061.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_25 = var_341_16 + 0.3
			local var_341_26 = math.max(var_341_17, arg_338_1.talkMaxDuration)

			if var_341_16 + 0.3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_25 + var_341_26 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_25) / var_341_26

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_25 + var_341_26 and arg_338_1.time_ < var_341_25 + var_341_26 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play221061080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 221061080
		arg_344_1.duration_ = 5.87

		local var_344_0 = {
			ja = 5.866,
			ko = 3.466,
			zh = 3.466
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play221061081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos1076ui_story = arg_344_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_347_0 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 then
				arg_344_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_344_1.time_ - 0) / var_347_0)
				arg_344_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1076ui_story"].transform.position).z)
				arg_344_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["1076ui_story"].transform.localEulerAngles = arg_344_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 then
				arg_344_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_344_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1076ui_story"].transform.position).z)
				arg_344_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["1076ui_story"].transform.localEulerAngles = arg_344_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_347_1 = arg_344_1.actors_["1076ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect1076ui_story == nil then
				arg_344_1.var_.characterEffect1076ui_story = var_347_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_2 and not isNil(var_347_1) then
				if arg_344_1.var_.characterEffect1076ui_story and not isNil(var_347_1) then
					arg_344_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_2 and arg_344_1.time_ < 0 + var_347_2 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect1076ui_story then
				arg_344_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_4 = arg_344_1.actors_["1072ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1072ui_story == nil then
				arg_344_1.var_.characterEffect1072ui_story = var_347_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_5 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_5 and not isNil(var_347_4) then
				if arg_344_1.var_.characterEffect1072ui_story and not isNil(var_347_4) then
					arg_344_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_5)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_5 and arg_344_1.time_ < 0 + var_347_5 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1072ui_story then
				arg_344_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_347_6 = 0
			local var_347_7 = 0.45

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_8 = arg_344_1:GetWordFromCfg(221061080)
				local var_347_9 = arg_344_1:FormatText(var_347_8.content)

				arg_344_1.text_.text = var_347_9

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 18 <= 0 and var_347_7 or var_347_7 * (utf8.len(var_347_9) / 18)

				if (18 <= 0 and var_347_7 or var_347_7 * (utf8.len(var_347_9) / 18)) > 0 and var_347_7 < var_347_11 then
					arg_344_1.talkMaxDuration = var_347_11

					if var_347_11 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_11 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_9
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061080", "story_v_out_221061.awb") ~= 0 then
					local var_347_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061080", "story_v_out_221061.awb") / 1000

					if var_347_12 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_12 + var_347_6
					end

					if var_347_8.prefab_name ~= "" and arg_344_1.actors_[var_347_8.prefab_name] ~= nil then
						local var_347_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_8.prefab_name].transform, "story_v_out_221061", "221061080", "story_v_out_221061.awb")

						arg_344_1:RecordAudio("221061080", var_347_13)
						arg_344_1:RecordAudio("221061080", var_347_13)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_221061", "221061080", "story_v_out_221061.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_221061", "221061080", "story_v_out_221061.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_14 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_14 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_14

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_14 and arg_344_1.time_ < var_347_6 + var_347_14 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play221061081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 221061081
		arg_348_1.duration_ = 7.2

		local var_348_0 = {
			ja = 7.2,
			ko = 6,
			zh = 6
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play221061082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1072ui_story = arg_348_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1072ui_story"].transform.position).z)
				arg_348_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1072ui_story"].transform.localEulerAngles = arg_348_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_348_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1072ui_story"].transform.position).z)
				arg_348_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1072ui_story"].transform.localEulerAngles = arg_348_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["1072ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1072ui_story == nil then
				arg_348_1.var_.characterEffect1072ui_story = var_351_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 and not isNil(var_351_1) then
				if arg_348_1.var_.characterEffect1072ui_story and not isNil(var_351_1) then
					arg_348_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1072ui_story then
				arg_348_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_351_4 = arg_348_1.actors_["1076ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_4) and arg_348_1.var_.characterEffect1076ui_story == nil then
				arg_348_1.var_.characterEffect1076ui_story = var_351_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_5 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_5 and not isNil(var_351_4) then
				if arg_348_1.var_.characterEffect1076ui_story and not isNil(var_351_4) then
					arg_348_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_5)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_5 and arg_348_1.time_ < 0 + var_351_5 + arg_351_0 and not isNil(var_351_4) and arg_348_1.var_.characterEffect1076ui_story then
				arg_348_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_351_6 = 0
			local var_351_7 = 0.55

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_8 = arg_348_1:GetWordFromCfg(221061081)
				local var_351_9 = arg_348_1:FormatText(var_351_8.content)

				arg_348_1.text_.text = var_351_9

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_11 = 22 <= 0 and var_351_7 or var_351_7 * (utf8.len(var_351_9) / 22)

				if (22 <= 0 and var_351_7 or var_351_7 * (utf8.len(var_351_9) / 22)) > 0 and var_351_7 < var_351_11 then
					arg_348_1.talkMaxDuration = var_351_11

					if var_351_11 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_11 + var_351_6
					end
				end

				arg_348_1.text_.text = var_351_9
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061081", "story_v_out_221061.awb") ~= 0 then
					local var_351_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061081", "story_v_out_221061.awb") / 1000

					if var_351_12 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_12 + var_351_6
					end

					if var_351_8.prefab_name ~= "" and arg_348_1.actors_[var_351_8.prefab_name] ~= nil then
						local var_351_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_8.prefab_name].transform, "story_v_out_221061", "221061081", "story_v_out_221061.awb")

						arg_348_1:RecordAudio("221061081", var_351_13)
						arg_348_1:RecordAudio("221061081", var_351_13)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_221061", "221061081", "story_v_out_221061.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_221061", "221061081", "story_v_out_221061.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_14 = math.max(var_351_7, arg_348_1.talkMaxDuration)

			if var_351_6 <= arg_348_1.time_ and arg_348_1.time_ < var_351_6 + var_351_14 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_6) / var_351_14

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_6 + var_351_14 and arg_348_1.time_ < var_351_6 + var_351_14 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play221061082 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 221061082
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play221061083(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1072ui_story = arg_352_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_355_0 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 then
				arg_352_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_352_1.time_ - 0) / var_355_0)
				arg_352_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).z)
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles = arg_352_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 then
				arg_352_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_352_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).z)
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles = arg_352_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_355_1 = arg_352_1.actors_["1072ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1072ui_story == nil then
				arg_352_1.var_.characterEffect1072ui_story = var_355_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_2 and not isNil(var_355_1) then
				if arg_352_1.var_.characterEffect1072ui_story and not isNil(var_355_1) then
					arg_352_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_2)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_2 and arg_352_1.time_ < 0 + var_355_2 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1072ui_story then
				arg_352_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_355_3 = arg_352_1.actors_["1076ui_story"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1076ui_story = var_355_3.localPosition
			end

			local var_355_4 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				var_355_3.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_352_1.time_ - 0) / var_355_4)
				var_355_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_355_3.position).x, (manager.ui.mainCamera.transform.position - var_355_3.position).y, (manager.ui.mainCamera.transform.position - var_355_3.position).z)
				var_355_3.localEulerAngles.z = 0
				var_355_3.localEulerAngles.x = 0
				var_355_3.localEulerAngles = var_355_3.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				var_355_3.localPosition = Vector3.New(0, 100, 0)
				var_355_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_355_3.position).x, (manager.ui.mainCamera.transform.position - var_355_3.position).y, (manager.ui.mainCamera.transform.position - var_355_3.position).z)
				var_355_3.localEulerAngles.z = 0
				var_355_3.localEulerAngles.x = 0
				var_355_3.localEulerAngles = var_355_3.localEulerAngles
			end

			local var_355_5 = arg_352_1.actors_["1076ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_5) and arg_352_1.var_.characterEffect1076ui_story == nil then
				arg_352_1.var_.characterEffect1076ui_story = var_355_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_6 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_6 and not isNil(var_355_5) then
				if arg_352_1.var_.characterEffect1076ui_story and not isNil(var_355_5) then
					arg_352_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_6)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_6 and arg_352_1.time_ < 0 + var_355_6 + arg_355_0 and not isNil(var_355_5) and arg_352_1.var_.characterEffect1076ui_story then
				arg_352_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_355_7 = 0
			local var_355_8 = 0.925

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_9 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(221061082).content)

				arg_352_1.text_.text = var_355_9

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 37 <= 0 and var_355_8 or var_355_8 * (utf8.len(var_355_9) / 37)

				if (37 <= 0 and var_355_8 or var_355_8 * (utf8.len(var_355_9) / 37)) > 0 and var_355_8 < var_355_11 then
					arg_352_1.talkMaxDuration = var_355_11

					if var_355_11 + var_355_7 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_7
					end
				end

				arg_352_1.text_.text = var_355_9
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_12 = math.max(var_355_8, arg_352_1.talkMaxDuration)

			if var_355_7 <= arg_352_1.time_ and arg_352_1.time_ < var_355_7 + var_355_12 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_7) / var_355_12

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_7 + var_355_12 and arg_352_1.time_ < var_355_7 + var_355_12 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play221061083 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 221061083
		arg_356_1.duration_ = 9

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play221061084(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if arg_356_1.bgs_.ST31a == nil then
				local var_359_0 = Object.Instantiate(arg_356_1.paintGo_)

				var_359_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31a")
				var_359_0.name = "ST31a"
				var_359_0.transform.parent = arg_356_1.stage_.transform
				var_359_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.bgs_.ST31a = var_359_0
			end

			if 2 < arg_356_1.time_ and arg_356_1.time_ <= 2 + arg_359_0 then
				local var_359_1 = arg_356_1.bgs_.ST31a

				arg_356_1.bgs_.ST31a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_359_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_359_2 = var_359_1:GetComponent("SpriteRenderer")

				if var_359_2 and var_359_2.sprite then
					local var_359_3 = 2 * (var_359_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_359_1.transform.localScale = Vector3.New(var_359_3 / var_359_2.sprite.bounds.size.y < var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x and var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x or var_359_3 / var_359_2.sprite.bounds.size.y, var_359_3 / var_359_2.sprite.bounds.size.y < var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x and var_359_3 * manager.ui.mainCameraCom_.aspect / var_359_2.sprite.bounds.size.x or var_359_3 / var_359_2.sprite.bounds.size.y, 0)
				end

				for iter_359_0, iter_359_1 in pairs(arg_356_1.bgs_) do
					if iter_359_0 ~= "ST31a" then
						iter_359_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_359_4 = 0

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_5 = 2

			if var_359_4 <= arg_356_1.time_ and arg_356_1.time_ < var_359_4 + var_359_5 then
				local var_359_6 = Color.New(0, 0, 0)

				var_359_6.a = Mathf.Lerp(0, 1, (arg_356_1.time_ - var_359_4) / var_359_5)
				arg_356_1.mask_.color = var_359_6
			end

			if arg_356_1.time_ >= var_359_4 + var_359_5 and arg_356_1.time_ < var_359_4 + var_359_5 + arg_359_0 then
				local var_359_7 = Color.New(0, 0, 0)

				var_359_7.a = 1
				arg_356_1.mask_.color = var_359_7
			end

			local var_359_8 = 2

			if 2 < arg_356_1.time_ and arg_356_1.time_ <= var_359_8 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_9 = 2

			if var_359_8 <= arg_356_1.time_ and arg_356_1.time_ < var_359_8 + var_359_9 then
				local var_359_10 = Color.New(0, 0, 0)

				var_359_10.a = Mathf.Lerp(1, 0, (arg_356_1.time_ - var_359_8) / var_359_9)
				arg_356_1.mask_.color = var_359_10
			end

			if arg_356_1.time_ >= var_359_8 + var_359_9 and arg_356_1.time_ < var_359_8 + var_359_9 + arg_359_0 then
				local var_359_11 = Color.New(0, 0, 0)

				arg_356_1.mask_.enabled = false
				var_359_11.a = 0
				arg_356_1.mask_.color = var_359_11
			end

			if 1.53333333333333 < arg_356_1.time_ and arg_356_1.time_ <= 1.53333333333333 + arg_359_0 then
				arg_356_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_359_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_356_1.bgmTxt_.text ~= var_359_15 and arg_356_1.bgmTxt_.text ~= "" then
						if arg_356_1.bgmTxt2_.text ~= "" then
							arg_356_1.bgmTxt_.text = arg_356_1.bgmTxt2_.text
						end

						arg_356_1.bgmTxt2_.text = var_359_15

						arg_356_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_356_1.bgmTxt_.text = var_359_15
						arg_356_1.bgmTxt2_.text = var_359_15
					end

					if arg_356_1.bgmTimer then
						arg_356_1.bgmTimer:Stop()

						arg_356_1.bgmTimer = nil
					end

					if arg_356_1.settingData.show_music_name == 1 then
						arg_356_1.musicController:SetSelectedState("show")
						arg_356_1.musicAnimator_:Play("open", 0, 0)

						if arg_356_1.settingData.music_time ~= 0 then
							arg_356_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_356_1.settingData.music_time), function()
								if arg_356_1 == nil or isNil(arg_356_1.bgmTxt_) then
									return
								end

								arg_356_1.musicController:SetSelectedState("hide")
								arg_356_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_356_1.time_ and arg_356_1.time_ <= 0.8 + arg_359_0 then
				arg_356_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_359_18 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_356_1.bgmTxt_.text ~= var_359_18 and arg_356_1.bgmTxt_.text ~= "" then
						if arg_356_1.bgmTxt2_.text ~= "" then
							arg_356_1.bgmTxt_.text = arg_356_1.bgmTxt2_.text
						end

						arg_356_1.bgmTxt2_.text = var_359_18

						arg_356_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_356_1.bgmTxt_.text = var_359_18
						arg_356_1.bgmTxt2_.text = var_359_18
					end

					if arg_356_1.bgmTimer then
						arg_356_1.bgmTimer:Stop()

						arg_356_1.bgmTimer = nil
					end

					if arg_356_1.settingData.show_music_name == 1 then
						arg_356_1.musicController:SetSelectedState("show")
						arg_356_1.musicAnimator_:Play("open", 0, 0)

						if arg_356_1.settingData.music_time ~= 0 then
							arg_356_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_356_1.settingData.music_time), function()
								if arg_356_1 == nil or isNil(arg_356_1.bgmTxt_) then
									return
								end

								arg_356_1.musicController:SetSelectedState("hide")
								arg_356_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_356_1.frameCnt_ <= 1 then
				arg_356_1.dialog_:SetActive(false)
			end

			local var_359_19 = 4
			local var_359_20 = 1

			if 4 < arg_356_1.time_ and arg_356_1.time_ <= var_359_19 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0

				arg_356_1.dialog_:SetActive(true)

				arg_356_1.dialogCg_.alpha = 0

				local var_359_21 = LeanTween.value(arg_356_1.dialog_, 0, 1, 0.3)

				var_359_21:setOnUpdate(LuaHelper.FloatAction(function(arg_362_0)
					arg_356_1.dialogCg_.alpha = arg_362_0
				end))
				var_359_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_356_1.dialog_)
					var_359_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_356_1.duration_ = arg_356_1.duration_ + 0.3

				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_22 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(221061083).content)

				arg_356_1.text_.text = var_359_22

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_24 = 40 <= 0 and var_359_20 or var_359_20 * (utf8.len(var_359_22) / 40)

				if (40 <= 0 and var_359_20 or var_359_20 * (utf8.len(var_359_22) / 40)) > 0 and var_359_20 < var_359_24 then
					arg_356_1.talkMaxDuration = var_359_24
					var_359_19 = var_359_19 + 0.3

					if var_359_24 + var_359_19 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_24 + var_359_19
					end
				end

				arg_356_1.text_.text = var_359_22
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_25 = var_359_19 + 0.3
			local var_359_26 = math.max(var_359_20, arg_356_1.talkMaxDuration)

			if var_359_19 + 0.3 <= arg_356_1.time_ and arg_356_1.time_ < var_359_25 + var_359_26 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_25) / var_359_26

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_25 + var_359_26 and arg_356_1.time_ < var_359_25 + var_359_26 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play221061084 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 221061084
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play221061085(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.725

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(221061084).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 29 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 29)

				if (29 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 29)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play221061085 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 221061085
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play221061086(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 1.1

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(221061085).content)

				arg_368_1.text_.text = var_371_1

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_3 = 44 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 44)

				if (44 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 44)) > 0 and var_371_0 < var_371_3 then
					arg_368_1.talkMaxDuration = var_371_3

					if var_371_3 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_3 + 0
					end
				end

				arg_368_1.text_.text = var_371_1
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_4 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_4

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play221061086 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 221061086
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play221061087(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.725

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(221061086).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 29 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 29)

				if (29 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 29)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play221061087 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 221061087
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play221061088(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.9

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(221061087).content)

				arg_376_1.text_.text = var_379_1

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_3 = 36 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 36)

				if (36 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 36)) > 0 and var_379_0 < var_379_3 then
					arg_376_1.talkMaxDuration = var_379_3

					if var_379_3 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_3 + 0
					end
				end

				arg_376_1.text_.text = var_379_1
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_4 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_4 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_4

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_4 and arg_376_1.time_ < 0 + var_379_4 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play221061088 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 221061088
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play221061089(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.875

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(221061088).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 35 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 35)

				if (35 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 35)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play221061089 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 221061089
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play221061090(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.8

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_1 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(221061089).content)

				arg_384_1.text_.text = var_387_1

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_3 = 32 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 32)

				if (32 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 32)) > 0 and var_387_0 < var_387_3 then
					arg_384_1.talkMaxDuration = var_387_3

					if var_387_3 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_3 + 0
					end
				end

				arg_384_1.text_.text = var_387_1
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_4 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_4

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play221061090 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 221061090
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play221061091(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.1

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_1 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(221061090).content)

				arg_388_1.text_.text = var_391_1

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_3 = 4 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_1) / 4)

				if (4 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_1) / 4)) > 0 and var_391_0 < var_391_3 then
					arg_388_1.talkMaxDuration = var_391_3

					if var_391_3 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_3 + 0
					end
				end

				arg_388_1.text_.text = var_391_1
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_4 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_4

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play221061091 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 221061091
		arg_392_1.duration_ = 2.37

		local var_392_0 = {
			ja = 2.366,
			ko = 1.266,
			zh = 1.266
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play221061092(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1072ui_story = arg_392_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1072ui_story"].transform.position).z)
				arg_392_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1072ui_story"].transform.localEulerAngles = arg_392_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_392_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1072ui_story"].transform.position).z)
				arg_392_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1072ui_story"].transform.localEulerAngles = arg_392_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_395_1 = arg_392_1.actors_["1072ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_1) and arg_392_1.var_.characterEffect1072ui_story == nil then
				arg_392_1.var_.characterEffect1072ui_story = var_395_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_2 and not isNil(var_395_1) then
				if arg_392_1.var_.characterEffect1072ui_story and not isNil(var_395_1) then
					arg_392_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_2 and arg_392_1.time_ < 0 + var_395_2 + arg_395_0 and not isNil(var_395_1) and arg_392_1.var_.characterEffect1072ui_story then
				arg_392_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_395_4 = 0
			local var_395_5 = 0.075

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_6 = arg_392_1:GetWordFromCfg(221061091)
				local var_395_7 = arg_392_1:FormatText(var_395_6.content)

				arg_392_1.text_.text = var_395_7

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_9 = 3 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_7) / 3)

				if (3 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_7) / 3)) > 0 and var_395_5 < var_395_9 then
					arg_392_1.talkMaxDuration = var_395_9

					if var_395_9 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_9 + var_395_4
					end
				end

				arg_392_1.text_.text = var_395_7
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061091", "story_v_out_221061.awb") ~= 0 then
					local var_395_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061091", "story_v_out_221061.awb") / 1000

					if var_395_10 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_4
					end

					if var_395_6.prefab_name ~= "" and arg_392_1.actors_[var_395_6.prefab_name] ~= nil then
						local var_395_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_6.prefab_name].transform, "story_v_out_221061", "221061091", "story_v_out_221061.awb")

						arg_392_1:RecordAudio("221061091", var_395_11)
						arg_392_1:RecordAudio("221061091", var_395_11)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_221061", "221061091", "story_v_out_221061.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_221061", "221061091", "story_v_out_221061.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_12 = math.max(var_395_5, arg_392_1.talkMaxDuration)

			if var_395_4 <= arg_392_1.time_ and arg_392_1.time_ < var_395_4 + var_395_12 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_4) / var_395_12

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_4 + var_395_12 and arg_392_1.time_ < var_395_4 + var_395_12 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play221061092 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 221061092
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play221061093(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1072ui_story = arg_396_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_399_0 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 then
				arg_396_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_0)
				arg_396_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1072ui_story"].transform.position).z)
				arg_396_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["1072ui_story"].transform.localEulerAngles = arg_396_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 then
				arg_396_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1072ui_story"].transform.position).z)
				arg_396_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["1072ui_story"].transform.localEulerAngles = arg_396_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_399_1 = arg_396_1.actors_["1072ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_1) and arg_396_1.var_.characterEffect1072ui_story == nil then
				arg_396_1.var_.characterEffect1072ui_story = var_399_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_2 and not isNil(var_399_1) then
				if arg_396_1.var_.characterEffect1072ui_story and not isNil(var_399_1) then
					arg_396_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_2)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_2 and arg_396_1.time_ < 0 + var_399_2 + arg_399_0 and not isNil(var_399_1) and arg_396_1.var_.characterEffect1072ui_story then
				arg_396_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_399_3 = 0
			local var_399_4 = 1.675

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_5 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(221061092).content)

				arg_396_1.text_.text = var_399_5

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_7 = 67 <= 0 and var_399_4 or var_399_4 * (utf8.len(var_399_5) / 67)

				if (67 <= 0 and var_399_4 or var_399_4 * (utf8.len(var_399_5) / 67)) > 0 and var_399_4 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_3 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_3
					end
				end

				arg_396_1.text_.text = var_399_5
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_8 = math.max(var_399_4, arg_396_1.talkMaxDuration)

			if var_399_3 <= arg_396_1.time_ and arg_396_1.time_ < var_399_3 + var_399_8 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_3) / var_399_8

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_3 + var_399_8 and arg_396_1.time_ < var_399_3 + var_399_8 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play221061093 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 221061093
		arg_400_1.duration_ = 14.03

		local var_400_0 = {
			ja = 14.033,
			ko = 8.766,
			zh = 8.766
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play221061094(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1072ui_story = arg_400_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_403_0 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 then
				arg_400_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_400_1.time_ - 0) / var_403_0)
				arg_400_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1072ui_story"].transform.position).z)
				arg_400_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1072ui_story"].transform.localEulerAngles = arg_400_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 then
				arg_400_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_400_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1072ui_story"].transform.position).z)
				arg_400_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1072ui_story"].transform.localEulerAngles = arg_400_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_403_1 = arg_400_1.actors_["1072ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect1072ui_story == nil then
				arg_400_1.var_.characterEffect1072ui_story = var_403_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_2 and not isNil(var_403_1) then
				if arg_400_1.var_.characterEffect1072ui_story and not isNil(var_403_1) then
					arg_400_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_2 and arg_400_1.time_ < 0 + var_403_2 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect1072ui_story then
				arg_400_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_403_4 = 0
			local var_403_5 = 1.2

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_6 = arg_400_1:GetWordFromCfg(221061093)
				local var_403_7 = arg_400_1:FormatText(var_403_6.content)

				arg_400_1.text_.text = var_403_7

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 48 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 48)

				if (48 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 48)) > 0 and var_403_5 < var_403_9 then
					arg_400_1.talkMaxDuration = var_403_9

					if var_403_9 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_9 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_7
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061093", "story_v_out_221061.awb") ~= 0 then
					local var_403_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061093", "story_v_out_221061.awb") / 1000

					if var_403_10 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_4
					end

					if var_403_6.prefab_name ~= "" and arg_400_1.actors_[var_403_6.prefab_name] ~= nil then
						local var_403_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_6.prefab_name].transform, "story_v_out_221061", "221061093", "story_v_out_221061.awb")

						arg_400_1:RecordAudio("221061093", var_403_11)
						arg_400_1:RecordAudio("221061093", var_403_11)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_221061", "221061093", "story_v_out_221061.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_221061", "221061093", "story_v_out_221061.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_12 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_12 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_12

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_12 and arg_400_1.time_ < var_403_4 + var_403_12 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play221061094 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 221061094
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play221061095(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1072ui_story = arg_404_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).z)
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles = arg_404_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_404_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).z)
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles = arg_404_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1072ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1072ui_story == nil then
				arg_404_1.var_.characterEffect1072ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1072ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_2)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1072ui_story then
				arg_404_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_407_3 = 0
			local var_407_4 = 1.025

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_5 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(221061094).content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 41 <= 0 and var_407_4 or var_407_4 * (utf8.len(var_407_5) / 41)

				if (41 <= 0 and var_407_4 or var_407_4 * (utf8.len(var_407_5) / 41)) > 0 and var_407_4 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_3 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_3
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_8 = math.max(var_407_4, arg_404_1.talkMaxDuration)

			if var_407_3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_3 + var_407_8 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_3) / var_407_8

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_3 + var_407_8 and arg_404_1.time_ < var_407_3 + var_407_8 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play221061095 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 221061095
		arg_408_1.duration_ = 7.9

		local var_408_0 = {
			ja = 7.9,
			ko = 5.533,
			zh = 5.533
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
				arg_408_0:Play221061096(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos1072ui_story = arg_408_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_411_0 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 then
				arg_408_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_408_1.time_ - 0) / var_411_0)
				arg_408_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).z)
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles = arg_408_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 then
				arg_408_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_408_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).z)
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles = arg_408_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_411_1 = arg_408_1.actors_["1072ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1072ui_story == nil then
				arg_408_1.var_.characterEffect1072ui_story = var_411_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_2 and not isNil(var_411_1) then
				if arg_408_1.var_.characterEffect1072ui_story and not isNil(var_411_1) then
					arg_408_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= 0 + var_411_2 and arg_408_1.time_ < 0 + var_411_2 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1072ui_story then
				arg_408_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_411_4 = arg_408_1.actors_["1076ui_story"].transform

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos1076ui_story = var_411_4.localPosition
			end

			local var_411_5 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_5 then
				var_411_4.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_408_1.time_ - 0) / var_411_5)
				var_411_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_411_4.position).x, (manager.ui.mainCamera.transform.position - var_411_4.position).y, (manager.ui.mainCamera.transform.position - var_411_4.position).z)
				var_411_4.localEulerAngles.z = 0
				var_411_4.localEulerAngles.x = 0
				var_411_4.localEulerAngles = var_411_4.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_5 and arg_408_1.time_ < 0 + var_411_5 + arg_411_0 then
				var_411_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_411_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_411_4.position).x, (manager.ui.mainCamera.transform.position - var_411_4.position).y, (manager.ui.mainCamera.transform.position - var_411_4.position).z)
				var_411_4.localEulerAngles.z = 0
				var_411_4.localEulerAngles.x = 0
				var_411_4.localEulerAngles = var_411_4.localEulerAngles
			end

			local var_411_6 = arg_408_1.actors_["1076ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_6) and arg_408_1.var_.characterEffect1076ui_story == nil then
				arg_408_1.var_.characterEffect1076ui_story = var_411_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_7 = 0.0166666666666667

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 and not isNil(var_411_6) then
				if arg_408_1.var_.characterEffect1076ui_story and not isNil(var_411_6) then
					arg_408_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_7)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 and not isNil(var_411_6) and arg_408_1.var_.characterEffect1076ui_story then
				arg_408_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_411_8 = 0
			local var_411_9 = 0.775

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_8 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_10 = arg_408_1:GetWordFromCfg(221061095)
				local var_411_11 = arg_408_1:FormatText(var_411_10.content)

				arg_408_1.text_.text = var_411_11

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_13 = 31 <= 0 and var_411_9 or var_411_9 * (utf8.len(var_411_11) / 31)

				if (31 <= 0 and var_411_9 or var_411_9 * (utf8.len(var_411_11) / 31)) > 0 and var_411_9 < var_411_13 then
					arg_408_1.talkMaxDuration = var_411_13

					if var_411_13 + var_411_8 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_13 + var_411_8
					end
				end

				arg_408_1.text_.text = var_411_11
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061095", "story_v_out_221061.awb") ~= 0 then
					local var_411_14 = manager.audio:GetVoiceLength("story_v_out_221061", "221061095", "story_v_out_221061.awb") / 1000

					if var_411_14 + var_411_8 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_8
					end

					if var_411_10.prefab_name ~= "" and arg_408_1.actors_[var_411_10.prefab_name] ~= nil then
						local var_411_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_10.prefab_name].transform, "story_v_out_221061", "221061095", "story_v_out_221061.awb")

						arg_408_1:RecordAudio("221061095", var_411_15)
						arg_408_1:RecordAudio("221061095", var_411_15)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_221061", "221061095", "story_v_out_221061.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_221061", "221061095", "story_v_out_221061.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_16 = math.max(var_411_9, arg_408_1.talkMaxDuration)

			if var_411_8 <= arg_408_1.time_ and arg_408_1.time_ < var_411_8 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_8) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_8 + var_411_16 and arg_408_1.time_ < var_411_8 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play221061096 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 221061096
		arg_412_1.duration_ = 7.67

		local var_412_0 = {
			ja = 7.666,
			ko = 7.233,
			zh = 7.233
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
				arg_412_0:Play221061097(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1072ui_story = arg_412_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).z)
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles = arg_412_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_412_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).z)
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles = arg_412_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_415_1 = 0
			local var_415_2 = 0.825

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:GetWordFromCfg(221061096)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_6 = 33 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_4) / 33)

				if (33 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_4) / 33)) > 0 and var_415_2 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_1
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061096", "story_v_out_221061.awb") ~= 0 then
					local var_415_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061096", "story_v_out_221061.awb") / 1000

					if var_415_7 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_1
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_221061", "221061096", "story_v_out_221061.awb")

						arg_412_1:RecordAudio("221061096", var_415_8)
						arg_412_1:RecordAudio("221061096", var_415_8)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_221061", "221061096", "story_v_out_221061.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_221061", "221061096", "story_v_out_221061.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_9 = math.max(var_415_2, arg_412_1.talkMaxDuration)

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_9 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_1) / var_415_9

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_1 + var_415_9 and arg_412_1.time_ < var_415_1 + var_415_9 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play221061097 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 221061097
		arg_416_1.duration_ = 3.2

		local var_416_0 = {
			ja = 2.733,
			ko = 3.2,
			zh = 3.2
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play221061098(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1076ui_story = arg_416_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_419_0 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 then
				arg_416_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_416_1.time_ - 0) / var_419_0)
				arg_416_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1076ui_story"].transform.position).z)
				arg_416_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1076ui_story"].transform.localEulerAngles = arg_416_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 then
				arg_416_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_416_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1076ui_story"].transform.position).z)
				arg_416_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1076ui_story"].transform.localEulerAngles = arg_416_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_419_1 = arg_416_1.actors_["1076ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1076ui_story == nil then
				arg_416_1.var_.characterEffect1076ui_story = var_419_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_2 and not isNil(var_419_1) then
				if arg_416_1.var_.characterEffect1076ui_story and not isNil(var_419_1) then
					arg_416_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= 0 + var_419_2 and arg_416_1.time_ < 0 + var_419_2 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1076ui_story then
				arg_416_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_419_4 = arg_416_1.actors_["1072ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_4) and arg_416_1.var_.characterEffect1072ui_story == nil then
				arg_416_1.var_.characterEffect1072ui_story = var_419_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_5 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_5 and not isNil(var_419_4) then
				if arg_416_1.var_.characterEffect1072ui_story and not isNil(var_419_4) then
					arg_416_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_416_1.time_ - 0) / var_419_5)
				end
			end

			if arg_416_1.time_ >= 0 + var_419_5 and arg_416_1.time_ < 0 + var_419_5 + arg_419_0 and not isNil(var_419_4) and arg_416_1.var_.characterEffect1072ui_story then
				arg_416_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_419_6 = 0
			local var_419_7 = 0.3

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_8 = arg_416_1:GetWordFromCfg(221061097)
				local var_419_9 = arg_416_1:FormatText(var_419_8.content)

				arg_416_1.text_.text = var_419_9

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 12 <= 0 and var_419_7 or var_419_7 * (utf8.len(var_419_9) / 12)

				if (12 <= 0 and var_419_7 or var_419_7 * (utf8.len(var_419_9) / 12)) > 0 and var_419_7 < var_419_11 then
					arg_416_1.talkMaxDuration = var_419_11

					if var_419_11 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_11 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_9
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061097", "story_v_out_221061.awb") ~= 0 then
					local var_419_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061097", "story_v_out_221061.awb") / 1000

					if var_419_12 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_12 + var_419_6
					end

					if var_419_8.prefab_name ~= "" and arg_416_1.actors_[var_419_8.prefab_name] ~= nil then
						local var_419_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_8.prefab_name].transform, "story_v_out_221061", "221061097", "story_v_out_221061.awb")

						arg_416_1:RecordAudio("221061097", var_419_13)
						arg_416_1:RecordAudio("221061097", var_419_13)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_221061", "221061097", "story_v_out_221061.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_221061", "221061097", "story_v_out_221061.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_14 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_14 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_14

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_14 and arg_416_1.time_ < var_419_6 + var_419_14 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play221061098 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 221061098
		arg_420_1.duration_ = 11.5

		local var_420_0 = {
			ja = 11.5,
			ko = 7.5,
			zh = 7.5
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play221061099(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1076ui_story = arg_420_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1076ui_story"].transform.position).z)
				arg_420_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1076ui_story"].transform.localEulerAngles = arg_420_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_420_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1076ui_story"].transform.position).z)
				arg_420_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1076ui_story"].transform.localEulerAngles = arg_420_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_423_1 = arg_420_1.actors_["1076ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect1076ui_story == nil then
				arg_420_1.var_.characterEffect1076ui_story = var_423_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 and not isNil(var_423_1) then
				if arg_420_1.var_.characterEffect1076ui_story and not isNil(var_423_1) then
					arg_420_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect1076ui_story then
				arg_420_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_423_4 = 0
			local var_423_5 = 0.8

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_6 = arg_420_1:GetWordFromCfg(221061098)
				local var_423_7 = arg_420_1:FormatText(var_423_6.content)

				arg_420_1.text_.text = var_423_7

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_9 = 32 <= 0 and var_423_5 or var_423_5 * (utf8.len(var_423_7) / 32)

				if (32 <= 0 and var_423_5 or var_423_5 * (utf8.len(var_423_7) / 32)) > 0 and var_423_5 < var_423_9 then
					arg_420_1.talkMaxDuration = var_423_9

					if var_423_9 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_9 + var_423_4
					end
				end

				arg_420_1.text_.text = var_423_7
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061098", "story_v_out_221061.awb") ~= 0 then
					local var_423_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061098", "story_v_out_221061.awb") / 1000

					if var_423_10 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_10 + var_423_4
					end

					if var_423_6.prefab_name ~= "" and arg_420_1.actors_[var_423_6.prefab_name] ~= nil then
						local var_423_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_6.prefab_name].transform, "story_v_out_221061", "221061098", "story_v_out_221061.awb")

						arg_420_1:RecordAudio("221061098", var_423_11)
						arg_420_1:RecordAudio("221061098", var_423_11)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_221061", "221061098", "story_v_out_221061.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_221061", "221061098", "story_v_out_221061.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_12 = math.max(var_423_5, arg_420_1.talkMaxDuration)

			if var_423_4 <= arg_420_1.time_ and arg_420_1.time_ < var_423_4 + var_423_12 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_4) / var_423_12

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_4 + var_423_12 and arg_420_1.time_ < var_423_4 + var_423_12 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play221061099 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 221061099
		arg_424_1.duration_ = 9.13

		local var_424_0 = {
			ja = 8.933,
			ko = 9.133,
			zh = 9.133
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play221061100(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1072ui_story = arg_424_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1072ui_story"].transform.position).z)
				arg_424_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1072ui_story"].transform.localEulerAngles = arg_424_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_424_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1072ui_story"].transform.position).z)
				arg_424_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1072ui_story"].transform.localEulerAngles = arg_424_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1072ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1072ui_story == nil then
				arg_424_1.var_.characterEffect1072ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect1072ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1072ui_story then
				arg_424_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_427_4 = arg_424_1.actors_["1076ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.characterEffect1076ui_story == nil then
				arg_424_1.var_.characterEffect1076ui_story = var_427_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_5 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_5 and not isNil(var_427_4) then
				if arg_424_1.var_.characterEffect1076ui_story and not isNil(var_427_4) then
					arg_424_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_5)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_5 and arg_424_1.time_ < 0 + var_427_5 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.characterEffect1076ui_story then
				arg_424_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_427_6 = 0
			local var_427_7 = 1.2

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_8 = arg_424_1:GetWordFromCfg(221061099)
				local var_427_9 = arg_424_1:FormatText(var_427_8.content)

				arg_424_1.text_.text = var_427_9

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 48 <= 0 and var_427_7 or var_427_7 * (utf8.len(var_427_9) / 48)

				if (48 <= 0 and var_427_7 or var_427_7 * (utf8.len(var_427_9) / 48)) > 0 and var_427_7 < var_427_11 then
					arg_424_1.talkMaxDuration = var_427_11

					if var_427_11 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_11 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_9
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061099", "story_v_out_221061.awb") ~= 0 then
					local var_427_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061099", "story_v_out_221061.awb") / 1000

					if var_427_12 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_6
					end

					if var_427_8.prefab_name ~= "" and arg_424_1.actors_[var_427_8.prefab_name] ~= nil then
						local var_427_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_8.prefab_name].transform, "story_v_out_221061", "221061099", "story_v_out_221061.awb")

						arg_424_1:RecordAudio("221061099", var_427_13)
						arg_424_1:RecordAudio("221061099", var_427_13)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_221061", "221061099", "story_v_out_221061.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_221061", "221061099", "story_v_out_221061.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play221061100 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 221061100
		arg_428_1.duration_ = 5.8

		local var_428_0 = {
			ja = 5.8,
			ko = 5.6,
			zh = 5.6
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play221061101(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1072ui_story = arg_428_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1072ui_story"].transform.position).z)
				arg_428_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1072ui_story"].transform.localEulerAngles = arg_428_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_428_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1072ui_story"].transform.position).z)
				arg_428_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1072ui_story"].transform.localEulerAngles = arg_428_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_431_1 = 0
			local var_431_2 = 0.725

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_3 = arg_428_1:GetWordFromCfg(221061100)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_6 = 29 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_4) / 29)

				if (29 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_4) / 29)) > 0 and var_431_2 < var_431_6 then
					arg_428_1.talkMaxDuration = var_431_6

					if var_431_6 + var_431_1 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_6 + var_431_1
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061100", "story_v_out_221061.awb") ~= 0 then
					local var_431_7 = manager.audio:GetVoiceLength("story_v_out_221061", "221061100", "story_v_out_221061.awb") / 1000

					if var_431_7 + var_431_1 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_1
					end

					if var_431_3.prefab_name ~= "" and arg_428_1.actors_[var_431_3.prefab_name] ~= nil then
						local var_431_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_3.prefab_name].transform, "story_v_out_221061", "221061100", "story_v_out_221061.awb")

						arg_428_1:RecordAudio("221061100", var_431_8)
						arg_428_1:RecordAudio("221061100", var_431_8)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_221061", "221061100", "story_v_out_221061.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_221061", "221061100", "story_v_out_221061.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_9 = math.max(var_431_2, arg_428_1.talkMaxDuration)

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_9 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_1) / var_431_9

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_1 + var_431_9 and arg_428_1.time_ < var_431_1 + var_431_9 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play221061101 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 221061101
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play221061102(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos1072ui_story = arg_432_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_435_0 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 then
				arg_432_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_432_1.time_ - 0) / var_435_0)
				arg_432_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1072ui_story"].transform.position).z)
				arg_432_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1072ui_story"].transform.localEulerAngles = arg_432_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 then
				arg_432_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1072ui_story"].transform.position).z)
				arg_432_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1072ui_story"].transform.localEulerAngles = arg_432_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_435_1 = arg_432_1.actors_["1072ui_story"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_1) and arg_432_1.var_.characterEffect1072ui_story == nil then
				arg_432_1.var_.characterEffect1072ui_story = var_435_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_2 and not isNil(var_435_1) then
				if arg_432_1.var_.characterEffect1072ui_story and not isNil(var_435_1) then
					arg_432_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_2)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_2 and arg_432_1.time_ < 0 + var_435_2 + arg_435_0 and not isNil(var_435_1) and arg_432_1.var_.characterEffect1072ui_story then
				arg_432_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_435_3 = arg_432_1.actors_["1076ui_story"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos1076ui_story = var_435_3.localPosition
			end

			local var_435_4 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				var_435_3.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_432_1.time_ - 0) / var_435_4)
				var_435_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_435_3.position).x, (manager.ui.mainCamera.transform.position - var_435_3.position).y, (manager.ui.mainCamera.transform.position - var_435_3.position).z)
				var_435_3.localEulerAngles.z = 0
				var_435_3.localEulerAngles.x = 0
				var_435_3.localEulerAngles = var_435_3.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				var_435_3.localPosition = Vector3.New(0, 100, 0)
				var_435_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_435_3.position).x, (manager.ui.mainCamera.transform.position - var_435_3.position).y, (manager.ui.mainCamera.transform.position - var_435_3.position).z)
				var_435_3.localEulerAngles.z = 0
				var_435_3.localEulerAngles.x = 0
				var_435_3.localEulerAngles = var_435_3.localEulerAngles
			end

			local var_435_5 = arg_432_1.actors_["1076ui_story"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_5) and arg_432_1.var_.characterEffect1076ui_story == nil then
				arg_432_1.var_.characterEffect1076ui_story = var_435_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_6 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_6 and not isNil(var_435_5) then
				if arg_432_1.var_.characterEffect1076ui_story and not isNil(var_435_5) then
					arg_432_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_6)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_6 and arg_432_1.time_ < 0 + var_435_6 + arg_435_0 and not isNil(var_435_5) and arg_432_1.var_.characterEffect1076ui_story then
				arg_432_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_435_7 = 0
			local var_435_8 = 1.2

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_7 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_9 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(221061101).content)

				arg_432_1.text_.text = var_435_9

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_11 = 48 <= 0 and var_435_8 or var_435_8 * (utf8.len(var_435_9) / 48)

				if (48 <= 0 and var_435_8 or var_435_8 * (utf8.len(var_435_9) / 48)) > 0 and var_435_8 < var_435_11 then
					arg_432_1.talkMaxDuration = var_435_11

					if var_435_11 + var_435_7 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_11 + var_435_7
					end
				end

				arg_432_1.text_.text = var_435_9
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_12 = math.max(var_435_8, arg_432_1.talkMaxDuration)

			if var_435_7 <= arg_432_1.time_ and arg_432_1.time_ < var_435_7 + var_435_12 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_7) / var_435_12

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_7 + var_435_12 and arg_432_1.time_ < var_435_7 + var_435_12 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play221061102 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 221061102
		arg_436_1.duration_ = 11.77

		local var_436_0 = {
			ja = 11.766,
			ko = 9.566,
			zh = 9.566
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play221061103(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos1076ui_story = arg_436_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_439_0 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 then
				arg_436_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_436_1.time_ - 0) / var_439_0)
				arg_436_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1076ui_story"].transform.position).z)
				arg_436_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1076ui_story"].transform.localEulerAngles = arg_436_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 then
				arg_436_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_436_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1076ui_story"].transform.position).z)
				arg_436_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1076ui_story"].transform.localEulerAngles = arg_436_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_439_1 = arg_436_1.actors_["1076ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1076ui_story == nil then
				arg_436_1.var_.characterEffect1076ui_story = var_439_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_2 and not isNil(var_439_1) then
				if arg_436_1.var_.characterEffect1076ui_story and not isNil(var_439_1) then
					arg_436_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_2 and arg_436_1.time_ < 0 + var_439_2 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1076ui_story then
				arg_436_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_439_4 = 0
			local var_439_5 = 0.725

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(221061102)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 29 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 29)

				if (29 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 29)) > 0 and var_439_5 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061102", "story_v_out_221061.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061102", "story_v_out_221061.awb") / 1000

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end

					if var_439_6.prefab_name ~= "" and arg_436_1.actors_[var_439_6.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_6.prefab_name].transform, "story_v_out_221061", "221061102", "story_v_out_221061.awb")

						arg_436_1:RecordAudio("221061102", var_439_11)
						arg_436_1:RecordAudio("221061102", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_221061", "221061102", "story_v_out_221061.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_221061", "221061102", "story_v_out_221061.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_12 and arg_436_1.time_ < var_439_4 + var_439_12 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play221061103 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 221061103
		arg_440_1.duration_ = 2.9

		local var_440_0 = {
			ja = 2.766,
			ko = 2.9,
			zh = 2.9
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play221061104(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1072ui_story = arg_440_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1072ui_story"].transform.position).z)
				arg_440_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1072ui_story"].transform.localEulerAngles = arg_440_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_440_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1072ui_story"].transform.position).z)
				arg_440_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1072ui_story"].transform.localEulerAngles = arg_440_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["1072ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1072ui_story == nil then
				arg_440_1.var_.characterEffect1072ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1072ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1072ui_story then
				arg_440_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_443_4 = arg_440_1.actors_["1076ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_4) and arg_440_1.var_.characterEffect1076ui_story == nil then
				arg_440_1.var_.characterEffect1076ui_story = var_443_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_5 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_5 and not isNil(var_443_4) then
				if arg_440_1.var_.characterEffect1076ui_story and not isNil(var_443_4) then
					arg_440_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_5)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_5 and arg_440_1.time_ < 0 + var_443_5 + arg_443_0 and not isNil(var_443_4) and arg_440_1.var_.characterEffect1076ui_story then
				arg_440_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_443_6 = 0
			local var_443_7 = 0.2

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_8 = arg_440_1:GetWordFromCfg(221061103)
				local var_443_9 = arg_440_1:FormatText(var_443_8.content)

				arg_440_1.text_.text = var_443_9

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 8 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 8)

				if (8 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 8)) > 0 and var_443_7 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_9
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061103", "story_v_out_221061.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061103", "story_v_out_221061.awb") / 1000

					if var_443_12 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_6
					end

					if var_443_8.prefab_name ~= "" and arg_440_1.actors_[var_443_8.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_8.prefab_name].transform, "story_v_out_221061", "221061103", "story_v_out_221061.awb")

						arg_440_1:RecordAudio("221061103", var_443_13)
						arg_440_1:RecordAudio("221061103", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_221061", "221061103", "story_v_out_221061.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_221061", "221061103", "story_v_out_221061.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play221061104 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 221061104
		arg_444_1.duration_ = 8.8

		local var_444_0 = {
			ja = 8.8,
			ko = 4.366,
			zh = 4.366
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play221061105(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos1076ui_story = arg_444_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_447_0 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 then
				arg_444_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_444_1.time_ - 0) / var_447_0)
				arg_444_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1076ui_story"].transform.position).z)
				arg_444_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1076ui_story"].transform.localEulerAngles = arg_444_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 then
				arg_444_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_444_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1076ui_story"].transform.position).z)
				arg_444_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1076ui_story"].transform.localEulerAngles = arg_444_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_447_1 = arg_444_1.actors_["1076ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_1) and arg_444_1.var_.characterEffect1076ui_story == nil then
				arg_444_1.var_.characterEffect1076ui_story = var_447_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_2 and not isNil(var_447_1) then
				if arg_444_1.var_.characterEffect1076ui_story and not isNil(var_447_1) then
					arg_444_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_2 and arg_444_1.time_ < 0 + var_447_2 + arg_447_0 and not isNil(var_447_1) and arg_444_1.var_.characterEffect1076ui_story then
				arg_444_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_447_4 = arg_444_1.actors_["1072ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_4) and arg_444_1.var_.characterEffect1072ui_story == nil then
				arg_444_1.var_.characterEffect1072ui_story = var_447_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_5 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_5 and not isNil(var_447_4) then
				if arg_444_1.var_.characterEffect1072ui_story and not isNil(var_447_4) then
					arg_444_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_5)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_5 and arg_444_1.time_ < 0 + var_447_5 + arg_447_0 and not isNil(var_447_4) and arg_444_1.var_.characterEffect1072ui_story then
				arg_444_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_447_6 = 0
			local var_447_7 = 0.55

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_8 = arg_444_1:GetWordFromCfg(221061104)
				local var_447_9 = arg_444_1:FormatText(var_447_8.content)

				arg_444_1.text_.text = var_447_9

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 22 <= 0 and var_447_7 or var_447_7 * (utf8.len(var_447_9) / 22)

				if (22 <= 0 and var_447_7 or var_447_7 * (utf8.len(var_447_9) / 22)) > 0 and var_447_7 < var_447_11 then
					arg_444_1.talkMaxDuration = var_447_11

					if var_447_11 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_11 + var_447_6
					end
				end

				arg_444_1.text_.text = var_447_9
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061104", "story_v_out_221061.awb") ~= 0 then
					local var_447_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061104", "story_v_out_221061.awb") / 1000

					if var_447_12 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_12 + var_447_6
					end

					if var_447_8.prefab_name ~= "" and arg_444_1.actors_[var_447_8.prefab_name] ~= nil then
						local var_447_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_8.prefab_name].transform, "story_v_out_221061", "221061104", "story_v_out_221061.awb")

						arg_444_1:RecordAudio("221061104", var_447_13)
						arg_444_1:RecordAudio("221061104", var_447_13)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_221061", "221061104", "story_v_out_221061.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_221061", "221061104", "story_v_out_221061.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_14 and arg_444_1.time_ < var_447_6 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play221061105 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 221061105
		arg_448_1.duration_ = 4.1

		local var_448_0 = {
			ja = 4.1,
			ko = 2.3,
			zh = 2.3
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play221061106(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.15

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_1 = arg_448_1:GetWordFromCfg(221061105)
				local var_451_2 = arg_448_1:FormatText(var_451_1.content)

				arg_448_1.text_.text = var_451_2

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 6 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 6)

				if (6 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 6)) > 0 and var_451_0 < var_451_4 then
					arg_448_1.talkMaxDuration = var_451_4

					if var_451_4 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_4 + 0
					end
				end

				arg_448_1.text_.text = var_451_2
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061105", "story_v_out_221061.awb") ~= 0 then
					local var_451_5 = manager.audio:GetVoiceLength("story_v_out_221061", "221061105", "story_v_out_221061.awb") / 1000

					if var_451_5 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + 0
					end

					if var_451_1.prefab_name ~= "" and arg_448_1.actors_[var_451_1.prefab_name] ~= nil then
						local var_451_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_1.prefab_name].transform, "story_v_out_221061", "221061105", "story_v_out_221061.awb")

						arg_448_1:RecordAudio("221061105", var_451_6)
						arg_448_1:RecordAudio("221061105", var_451_6)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_221061", "221061105", "story_v_out_221061.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_221061", "221061105", "story_v_out_221061.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play221061106 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 221061106
		arg_452_1.duration_ = 9.13

		local var_452_0 = {
			ja = 7.033,
			ko = 9.133,
			zh = 9.133
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play221061107(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1072ui_story = arg_452_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_455_0 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 then
				arg_452_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_452_1.time_ - 0) / var_455_0)
				arg_452_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1072ui_story"].transform.position).z)
				arg_452_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1072ui_story"].transform.localEulerAngles = arg_452_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 then
				arg_452_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_452_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1072ui_story"].transform.position).z)
				arg_452_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1072ui_story"].transform.localEulerAngles = arg_452_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_455_1 = arg_452_1.actors_["1072ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1072ui_story == nil then
				arg_452_1.var_.characterEffect1072ui_story = var_455_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 and not isNil(var_455_1) then
				if arg_452_1.var_.characterEffect1072ui_story and not isNil(var_455_1) then
					arg_452_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1072ui_story then
				arg_452_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_455_4 = arg_452_1.actors_["1076ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_4) and arg_452_1.var_.characterEffect1076ui_story == nil then
				arg_452_1.var_.characterEffect1076ui_story = var_455_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_5 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_5 and not isNil(var_455_4) then
				if arg_452_1.var_.characterEffect1076ui_story and not isNil(var_455_4) then
					arg_452_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_5)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_5 and arg_452_1.time_ < 0 + var_455_5 + arg_455_0 and not isNil(var_455_4) and arg_452_1.var_.characterEffect1076ui_story then
				arg_452_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_455_6 = 0
			local var_455_7 = 0.8

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_8 = arg_452_1:GetWordFromCfg(221061106)
				local var_455_9 = arg_452_1:FormatText(var_455_8.content)

				arg_452_1.text_.text = var_455_9

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 32 <= 0 and var_455_7 or var_455_7 * (utf8.len(var_455_9) / 32)

				if (32 <= 0 and var_455_7 or var_455_7 * (utf8.len(var_455_9) / 32)) > 0 and var_455_7 < var_455_11 then
					arg_452_1.talkMaxDuration = var_455_11

					if var_455_11 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_11 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_9
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061106", "story_v_out_221061.awb") ~= 0 then
					local var_455_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061106", "story_v_out_221061.awb") / 1000

					if var_455_12 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_12 + var_455_6
					end

					if var_455_8.prefab_name ~= "" and arg_452_1.actors_[var_455_8.prefab_name] ~= nil then
						local var_455_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_8.prefab_name].transform, "story_v_out_221061", "221061106", "story_v_out_221061.awb")

						arg_452_1:RecordAudio("221061106", var_455_13)
						arg_452_1:RecordAudio("221061106", var_455_13)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_221061", "221061106", "story_v_out_221061.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_221061", "221061106", "story_v_out_221061.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_14 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_6 <= arg_452_1.time_ and arg_452_1.time_ < var_455_6 + var_455_14 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_6) / var_455_14

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_6 + var_455_14 and arg_452_1.time_ < var_455_6 + var_455_14 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play221061107 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 221061107
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play221061108(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["1072ui_story"]) and arg_456_1.var_.characterEffect1072ui_story == nil then
				arg_456_1.var_.characterEffect1072ui_story = arg_456_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_0 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["1072ui_story"]) then
				if arg_456_1.var_.characterEffect1072ui_story and not isNil(arg_456_1.actors_["1072ui_story"]) then
					arg_456_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_456_1.time_ - 0) / var_459_0)
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["1072ui_story"]) and arg_456_1.var_.characterEffect1072ui_story then
				arg_456_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_459_1 = arg_456_1.actors_["1076ui_story"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1076ui_story = var_459_1.localPosition
			end

			local var_459_2 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_2 then
				var_459_1.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_456_1.time_ - 0) / var_459_2)
				var_459_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_1.position).x, (manager.ui.mainCamera.transform.position - var_459_1.position).y, (manager.ui.mainCamera.transform.position - var_459_1.position).z)
				var_459_1.localEulerAngles.z = 0
				var_459_1.localEulerAngles.x = 0
				var_459_1.localEulerAngles = var_459_1.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_2 and arg_456_1.time_ < 0 + var_459_2 + arg_459_0 then
				var_459_1.localPosition = Vector3.New(0, 100, 0)
				var_459_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_1.position).x, (manager.ui.mainCamera.transform.position - var_459_1.position).y, (manager.ui.mainCamera.transform.position - var_459_1.position).z)
				var_459_1.localEulerAngles.z = 0
				var_459_1.localEulerAngles.x = 0
				var_459_1.localEulerAngles = var_459_1.localEulerAngles
			end

			local var_459_3 = arg_456_1.actors_["1072ui_story"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1072ui_story = var_459_3.localPosition
			end

			local var_459_4 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				var_459_3.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_456_1.time_ - 0) / var_459_4)
				var_459_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_3.position).x, (manager.ui.mainCamera.transform.position - var_459_3.position).y, (manager.ui.mainCamera.transform.position - var_459_3.position).z)
				var_459_3.localEulerAngles.z = 0
				var_459_3.localEulerAngles.x = 0
				var_459_3.localEulerAngles = var_459_3.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				var_459_3.localPosition = Vector3.New(0, 100, 0)
				var_459_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_3.position).x, (manager.ui.mainCamera.transform.position - var_459_3.position).y, (manager.ui.mainCamera.transform.position - var_459_3.position).z)
				var_459_3.localEulerAngles.z = 0
				var_459_3.localEulerAngles.x = 0
				var_459_3.localEulerAngles = var_459_3.localEulerAngles
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_firework", "")
			end

			local var_459_6 = 0
			local var_459_7 = 0.7

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_8 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(221061107).content)

				arg_456_1.text_.text = var_459_8

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_10 = 28 <= 0 and var_459_7 or var_459_7 * (utf8.len(var_459_8) / 28)

				if (28 <= 0 and var_459_7 or var_459_7 * (utf8.len(var_459_8) / 28)) > 0 and var_459_7 < var_459_10 then
					arg_456_1.talkMaxDuration = var_459_10

					if var_459_10 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_8
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_11 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_11 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_11

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_11 and arg_456_1.time_ < var_459_6 + var_459_11 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play221061108 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 221061108
		arg_460_1.duration_ = 6.13

		local var_460_0 = {
			ja = 6.133,
			ko = 3.6,
			zh = 3.6
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play221061109(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1072ui_story = arg_460_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_463_0 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 then
				arg_460_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_460_1.time_ - 0) / var_463_0)
				arg_460_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1072ui_story"].transform.position).z)
				arg_460_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1072ui_story"].transform.localEulerAngles = arg_460_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 then
				arg_460_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_460_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1072ui_story"].transform.position).z)
				arg_460_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1072ui_story"].transform.localEulerAngles = arg_460_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_463_1 = arg_460_1.actors_["1072ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1072ui_story == nil then
				arg_460_1.var_.characterEffect1072ui_story = var_463_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_2 and not isNil(var_463_1) then
				if arg_460_1.var_.characterEffect1072ui_story and not isNil(var_463_1) then
					arg_460_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_2 and arg_460_1.time_ < 0 + var_463_2 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1072ui_story then
				arg_460_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_463_4 = 0
			local var_463_5 = 0.275

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_6 = arg_460_1:GetWordFromCfg(221061108)
				local var_463_7 = arg_460_1:FormatText(var_463_6.content)

				arg_460_1.text_.text = var_463_7

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_9 = 11 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 11)

				if (11 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 11)) > 0 and var_463_5 < var_463_9 then
					arg_460_1.talkMaxDuration = var_463_9

					if var_463_9 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_9 + var_463_4
					end
				end

				arg_460_1.text_.text = var_463_7
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061108", "story_v_out_221061.awb") ~= 0 then
					local var_463_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061108", "story_v_out_221061.awb") / 1000

					if var_463_10 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_10 + var_463_4
					end

					if var_463_6.prefab_name ~= "" and arg_460_1.actors_[var_463_6.prefab_name] ~= nil then
						local var_463_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_6.prefab_name].transform, "story_v_out_221061", "221061108", "story_v_out_221061.awb")

						arg_460_1:RecordAudio("221061108", var_463_11)
						arg_460_1:RecordAudio("221061108", var_463_11)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_221061", "221061108", "story_v_out_221061.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_221061", "221061108", "story_v_out_221061.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_12 = math.max(var_463_5, arg_460_1.talkMaxDuration)

			if var_463_4 <= arg_460_1.time_ and arg_460_1.time_ < var_463_4 + var_463_12 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_4) / var_463_12

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_4 + var_463_12 and arg_460_1.time_ < var_463_4 + var_463_12 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play221061109 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 221061109
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play221061110(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1072ui_story"]) and arg_464_1.var_.characterEffect1072ui_story == nil then
				arg_464_1.var_.characterEffect1072ui_story = arg_464_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1072ui_story"]) then
				if arg_464_1.var_.characterEffect1072ui_story and not isNil(arg_464_1.actors_["1072ui_story"]) then
					arg_464_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1072ui_story"]) and arg_464_1.var_.characterEffect1072ui_story then
				arg_464_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_467_1 = arg_464_1.actors_["1072ui_story"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1072ui_story = var_467_1.localPosition
			end

			local var_467_2 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_2 then
				var_467_1.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_464_1.time_ - 0) / var_467_2)
				var_467_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_467_1.position).x, (manager.ui.mainCamera.transform.position - var_467_1.position).y, (manager.ui.mainCamera.transform.position - var_467_1.position).z)
				var_467_1.localEulerAngles.z = 0
				var_467_1.localEulerAngles.x = 0
				var_467_1.localEulerAngles = var_467_1.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_2 and arg_464_1.time_ < 0 + var_467_2 + arg_467_0 then
				var_467_1.localPosition = Vector3.New(0, 100, 0)
				var_467_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_467_1.position).x, (manager.ui.mainCamera.transform.position - var_467_1.position).y, (manager.ui.mainCamera.transform.position - var_467_1.position).z)
				var_467_1.localEulerAngles.z = 0
				var_467_1.localEulerAngles.x = 0
				var_467_1.localEulerAngles = var_467_1.localEulerAngles
			end

			local var_467_3 = 0
			local var_467_4 = 1.125

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_3 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_5 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(221061109).content)

				arg_464_1.text_.text = var_467_5

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_7 = 45 <= 0 and var_467_4 or var_467_4 * (utf8.len(var_467_5) / 45)

				if (45 <= 0 and var_467_4 or var_467_4 * (utf8.len(var_467_5) / 45)) > 0 and var_467_4 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_3 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_3
					end
				end

				arg_464_1.text_.text = var_467_5
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_8 = math.max(var_467_4, arg_464_1.talkMaxDuration)

			if var_467_3 <= arg_464_1.time_ and arg_464_1.time_ < var_467_3 + var_467_8 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_3) / var_467_8

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_3 + var_467_8 and arg_464_1.time_ < var_467_3 + var_467_8 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play221061110 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 221061110
		arg_468_1.duration_ = 10

		local var_468_0 = {
			ja = 9.033,
			ko = 10,
			zh = 10
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play221061111(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos1072ui_story = arg_468_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_471_0 = 0.001

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 then
				arg_468_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_468_1.time_ - 0) / var_471_0)
				arg_468_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1072ui_story"].transform.position).z)
				arg_468_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1072ui_story"].transform.localEulerAngles = arg_468_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 then
				arg_468_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_468_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1072ui_story"].transform.position).z)
				arg_468_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1072ui_story"].transform.localEulerAngles = arg_468_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_471_1 = arg_468_1.actors_["1072ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1072ui_story == nil then
				arg_468_1.var_.characterEffect1072ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect1072ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1072ui_story then
				arg_468_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_471_4 = 0
			local var_471_5 = 0.95

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_6 = arg_468_1:GetWordFromCfg(221061110)
				local var_471_7 = arg_468_1:FormatText(var_471_6.content)

				arg_468_1.text_.text = var_471_7

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 38 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 38)

				if (38 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 38)) > 0 and var_471_5 < var_471_9 then
					arg_468_1.talkMaxDuration = var_471_9

					if var_471_9 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_9 + var_471_4
					end
				end

				arg_468_1.text_.text = var_471_7
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061110", "story_v_out_221061.awb") ~= 0 then
					local var_471_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061110", "story_v_out_221061.awb") / 1000

					if var_471_10 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_4
					end

					if var_471_6.prefab_name ~= "" and arg_468_1.actors_[var_471_6.prefab_name] ~= nil then
						local var_471_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_6.prefab_name].transform, "story_v_out_221061", "221061110", "story_v_out_221061.awb")

						arg_468_1:RecordAudio("221061110", var_471_11)
						arg_468_1:RecordAudio("221061110", var_471_11)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_221061", "221061110", "story_v_out_221061.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_221061", "221061110", "story_v_out_221061.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_12 = math.max(var_471_5, arg_468_1.talkMaxDuration)

			if var_471_4 <= arg_468_1.time_ and arg_468_1.time_ < var_471_4 + var_471_12 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_4) / var_471_12

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_4 + var_471_12 and arg_468_1.time_ < var_471_4 + var_471_12 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_468_1:InitPlayNodeList()
	end,
	Play221061111 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 221061111
		arg_472_1.duration_ = 3.93

		local var_472_0 = {
			ja = 3.833,
			ko = 3.933,
			zh = 3.933
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play221061112(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_475_0 = 0
			local var_475_1 = 0.375

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_2 = arg_472_1:GetWordFromCfg(221061111)
				local var_475_3 = arg_472_1:FormatText(var_475_2.content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 15 <= 0 and var_475_1 or var_475_1 * (utf8.len(var_475_3) / 15)

				if (15 <= 0 and var_475_1 or var_475_1 * (utf8.len(var_475_3) / 15)) > 0 and var_475_1 < var_475_5 then
					arg_472_1.talkMaxDuration = var_475_5

					if var_475_5 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061111", "story_v_out_221061.awb") ~= 0 then
					local var_475_6 = manager.audio:GetVoiceLength("story_v_out_221061", "221061111", "story_v_out_221061.awb") / 1000

					if var_475_6 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_0
					end

					if var_475_2.prefab_name ~= "" and arg_472_1.actors_[var_475_2.prefab_name] ~= nil then
						local var_475_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_2.prefab_name].transform, "story_v_out_221061", "221061111", "story_v_out_221061.awb")

						arg_472_1:RecordAudio("221061111", var_475_7)
						arg_472_1:RecordAudio("221061111", var_475_7)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_221061", "221061111", "story_v_out_221061.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_221061", "221061111", "story_v_out_221061.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_8 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_8 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_8

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_8 and arg_472_1.time_ < var_475_0 + var_475_8 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play221061112 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 221061112
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play221061113(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1072ui_story"]) and arg_476_1.var_.characterEffect1072ui_story == nil then
				arg_476_1.var_.characterEffect1072ui_story = arg_476_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1072ui_story"]) then
				if arg_476_1.var_.characterEffect1072ui_story and not isNil(arg_476_1.actors_["1072ui_story"]) then
					arg_476_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1072ui_story"]) and arg_476_1.var_.characterEffect1072ui_story then
				arg_476_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_479_1 = arg_476_1.actors_["1072ui_story"].transform

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos1072ui_story = var_479_1.localPosition
			end

			local var_479_2 = 0.001

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_2 then
				var_479_1.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_476_1.time_ - 0) / var_479_2)
				var_479_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_479_1.position).x, (manager.ui.mainCamera.transform.position - var_479_1.position).y, (manager.ui.mainCamera.transform.position - var_479_1.position).z)
				var_479_1.localEulerAngles.z = 0
				var_479_1.localEulerAngles.x = 0
				var_479_1.localEulerAngles = var_479_1.localEulerAngles
			end

			if arg_476_1.time_ >= 0 + var_479_2 and arg_476_1.time_ < 0 + var_479_2 + arg_479_0 then
				var_479_1.localPosition = Vector3.New(0, 100, 0)
				var_479_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_479_1.position).x, (manager.ui.mainCamera.transform.position - var_479_1.position).y, (manager.ui.mainCamera.transform.position - var_479_1.position).z)
				var_479_1.localEulerAngles.z = 0
				var_479_1.localEulerAngles.x = 0
				var_479_1.localEulerAngles = var_479_1.localEulerAngles
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_firework_loop", "")
			end

			local var_479_4 = 0
			local var_479_5 = 1.2

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_4 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_6 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(221061112).content)

				arg_476_1.text_.text = var_479_6

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_8 = 48 <= 0 and var_479_5 or var_479_5 * (utf8.len(var_479_6) / 48)

				if (48 <= 0 and var_479_5 or var_479_5 * (utf8.len(var_479_6) / 48)) > 0 and var_479_5 < var_479_8 then
					arg_476_1.talkMaxDuration = var_479_8

					if var_479_8 + var_479_4 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_8 + var_479_4
					end
				end

				arg_476_1.text_.text = var_479_6
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_9 = math.max(var_479_5, arg_476_1.talkMaxDuration)

			if var_479_4 <= arg_476_1.time_ and arg_476_1.time_ < var_479_4 + var_479_9 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_4) / var_479_9

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_4 + var_479_9 and arg_476_1.time_ < var_479_4 + var_479_9 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play221061113 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 221061113
		arg_480_1.duration_ = 7.33

		local var_480_0 = {
			ja = 7.333,
			ko = 5.933,
			zh = 5.933
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play221061114(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1072ui_story = arg_480_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_483_0 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 then
				arg_480_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_480_1.time_ - 0) / var_483_0)
				arg_480_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1072ui_story"].transform.position).z)
				arg_480_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1072ui_story"].transform.localEulerAngles = arg_480_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 then
				arg_480_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_480_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1072ui_story"].transform.position).z)
				arg_480_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1072ui_story"].transform.localEulerAngles = arg_480_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_483_1 = arg_480_1.actors_["1072ui_story"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect1072ui_story == nil then
				arg_480_1.var_.characterEffect1072ui_story = var_483_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_2 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_2 and not isNil(var_483_1) then
				if arg_480_1.var_.characterEffect1072ui_story and not isNil(var_483_1) then
					arg_480_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= 0 + var_483_2 and arg_480_1.time_ < 0 + var_483_2 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect1072ui_story then
				arg_480_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_483_4 = 0
			local var_483_5 = 0.75

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_6 = arg_480_1:GetWordFromCfg(221061113)
				local var_483_7 = arg_480_1:FormatText(var_483_6.content)

				arg_480_1.text_.text = var_483_7

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_9 = 30 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_7) / 30)

				if (30 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_7) / 30)) > 0 and var_483_5 < var_483_9 then
					arg_480_1.talkMaxDuration = var_483_9

					if var_483_9 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_9 + var_483_4
					end
				end

				arg_480_1.text_.text = var_483_7
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061113", "story_v_out_221061.awb") ~= 0 then
					local var_483_10 = manager.audio:GetVoiceLength("story_v_out_221061", "221061113", "story_v_out_221061.awb") / 1000

					if var_483_10 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_4
					end

					if var_483_6.prefab_name ~= "" and arg_480_1.actors_[var_483_6.prefab_name] ~= nil then
						local var_483_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_6.prefab_name].transform, "story_v_out_221061", "221061113", "story_v_out_221061.awb")

						arg_480_1:RecordAudio("221061113", var_483_11)
						arg_480_1:RecordAudio("221061113", var_483_11)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_221061", "221061113", "story_v_out_221061.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_221061", "221061113", "story_v_out_221061.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_12 = math.max(var_483_5, arg_480_1.talkMaxDuration)

			if var_483_4 <= arg_480_1.time_ and arg_480_1.time_ < var_483_4 + var_483_12 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_4) / var_483_12

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_4 + var_483_12 and arg_480_1.time_ < var_483_4 + var_483_12 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play221061114 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 221061114
		arg_484_1.duration_ = 11.77

		local var_484_0 = {
			ja = 11.766,
			ko = 9.566,
			zh = 9.566
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play221061115(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.var_.moveOldPos1076ui_story = arg_484_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_487_0 = 0.001

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 then
				arg_484_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_484_1.time_ - 0) / var_487_0)
				arg_484_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_484_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1076ui_story"].transform.position).z)
				arg_484_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_484_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_484_1.actors_["1076ui_story"].transform.localEulerAngles = arg_484_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 then
				arg_484_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_484_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_484_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1076ui_story"].transform.position).z)
				arg_484_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_484_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_484_1.actors_["1076ui_story"].transform.localEulerAngles = arg_484_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_487_1 = arg_484_1.actors_["1076ui_story"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_1) and arg_484_1.var_.characterEffect1076ui_story == nil then
				arg_484_1.var_.characterEffect1076ui_story = var_487_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_2 and not isNil(var_487_1) then
				if arg_484_1.var_.characterEffect1076ui_story and not isNil(var_487_1) then
					arg_484_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= 0 + var_487_2 and arg_484_1.time_ < 0 + var_487_2 + arg_487_0 and not isNil(var_487_1) and arg_484_1.var_.characterEffect1076ui_story then
				arg_484_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action7_1")
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_487_4 = arg_484_1.actors_["1072ui_story"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_4) and arg_484_1.var_.characterEffect1072ui_story == nil then
				arg_484_1.var_.characterEffect1072ui_story = var_487_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_5 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_5 and not isNil(var_487_4) then
				if arg_484_1.var_.characterEffect1072ui_story and not isNil(var_487_4) then
					arg_484_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_484_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_484_1.time_ - 0) / var_487_5)
				end
			end

			if arg_484_1.time_ >= 0 + var_487_5 and arg_484_1.time_ < 0 + var_487_5 + arg_487_0 and not isNil(var_487_4) and arg_484_1.var_.characterEffect1072ui_story then
				arg_484_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_484_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_487_6 = 0
			local var_487_7 = 0.725

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_8 = arg_484_1:GetWordFromCfg(221061114)
				local var_487_9 = arg_484_1:FormatText(var_487_8.content)

				arg_484_1.text_.text = var_487_9

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_11 = 29 <= 0 and var_487_7 or var_487_7 * (utf8.len(var_487_9) / 29)

				if (29 <= 0 and var_487_7 or var_487_7 * (utf8.len(var_487_9) / 29)) > 0 and var_487_7 < var_487_11 then
					arg_484_1.talkMaxDuration = var_487_11

					if var_487_11 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_11 + var_487_6
					end
				end

				arg_484_1.text_.text = var_487_9
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061114", "story_v_out_221061.awb") ~= 0 then
					local var_487_12 = manager.audio:GetVoiceLength("story_v_out_221061", "221061114", "story_v_out_221061.awb") / 1000

					if var_487_12 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_12 + var_487_6
					end

					if var_487_8.prefab_name ~= "" and arg_484_1.actors_[var_487_8.prefab_name] ~= nil then
						local var_487_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_8.prefab_name].transform, "story_v_out_221061", "221061114", "story_v_out_221061.awb")

						arg_484_1:RecordAudio("221061114", var_487_13)
						arg_484_1:RecordAudio("221061114", var_487_13)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_221061", "221061114", "story_v_out_221061.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_221061", "221061114", "story_v_out_221061.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_14 = math.max(var_487_7, arg_484_1.talkMaxDuration)

			if var_487_6 <= arg_484_1.time_ and arg_484_1.time_ < var_487_6 + var_487_14 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_6) / var_487_14

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_6 + var_487_14 and arg_484_1.time_ < var_487_6 + var_487_14 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_484_1:InitPlayNodeList()
	end,
	Play221061115 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 221061115
		arg_488_1.duration_ = 10.07

		local var_488_0 = {
			ja = 8.7,
			ko = 10.066,
			zh = 10.066
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play221061116(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["1076ui_story"]) and arg_488_1.var_.characterEffect1076ui_story == nil then
				arg_488_1.var_.characterEffect1076ui_story = arg_488_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["1076ui_story"]) then
				if arg_488_1.var_.characterEffect1076ui_story and not isNil(arg_488_1.actors_["1076ui_story"]) then
					arg_488_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_488_1.time_ - 0) / var_491_0)
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["1076ui_story"]) and arg_488_1.var_.characterEffect1076ui_story then
				arg_488_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:AudioAction("stop", "effect", "se_story_221_00", "se_story_221_00_firework_loop", "")
			end

			local var_491_2 = 0
			local var_491_3 = 0.825

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_2 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_4 = arg_488_1:GetWordFromCfg(221061115)
				local var_491_5 = arg_488_1:FormatText(var_491_4.content)

				arg_488_1.text_.text = var_491_5

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_7 = 33 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_5) / 33)

				if (33 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_5) / 33)) > 0 and var_491_3 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_2
					end
				end

				arg_488_1.text_.text = var_491_5
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221061", "221061115", "story_v_out_221061.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_out_221061", "221061115", "story_v_out_221061.awb") / 1000

					if var_491_8 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_2
					end

					if var_491_4.prefab_name ~= "" and arg_488_1.actors_[var_491_4.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_4.prefab_name].transform, "story_v_out_221061", "221061115", "story_v_out_221061.awb")

						arg_488_1:RecordAudio("221061115", var_491_9)
						arg_488_1:RecordAudio("221061115", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_221061", "221061115", "story_v_out_221061.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_221061", "221061115", "story_v_out_221061.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_3, arg_488_1.talkMaxDuration)

			if var_491_2 <= arg_488_1.time_ and arg_488_1.time_ < var_491_2 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_2) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_2 + var_491_10 and arg_488_1.time_ < var_491_2 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play221061116 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 221061116
		arg_492_1.duration_ = 4.8

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
			arg_492_1.auto_ = false
		end

		function arg_492_1.playNext_(arg_494_0)
			arg_492_1.onStoryFinished_()
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 2 < arg_492_1.time_ and arg_492_1.time_ <= 2 + arg_495_0 then
				local var_495_0 = arg_492_1.bgs_.STblack

				arg_492_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_495_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_495_1 = var_495_0:GetComponent("SpriteRenderer")

				if var_495_1 and var_495_1.sprite then
					local var_495_2 = 2 * (var_495_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_495_0.transform.localScale = Vector3.New(var_495_2 / var_495_1.sprite.bounds.size.y < var_495_2 * manager.ui.mainCameraCom_.aspect / var_495_1.sprite.bounds.size.x and var_495_2 * manager.ui.mainCameraCom_.aspect / var_495_1.sprite.bounds.size.x or var_495_2 / var_495_1.sprite.bounds.size.y, var_495_2 / var_495_1.sprite.bounds.size.y < var_495_2 * manager.ui.mainCameraCom_.aspect / var_495_1.sprite.bounds.size.x and var_495_2 * manager.ui.mainCameraCom_.aspect / var_495_1.sprite.bounds.size.x or var_495_2 / var_495_1.sprite.bounds.size.y, 0)
				end

				for iter_495_0, iter_495_1 in pairs(arg_492_1.bgs_) do
					if iter_495_0 ~= "STblack" then
						iter_495_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_495_3 = 0

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_3 + arg_495_0 then
				arg_492_1.mask_.enabled = true
				arg_492_1.mask_.raycastTarget = true

				arg_492_1:SetGaussion(false)
			end

			local var_495_4 = 2

			if var_495_3 <= arg_492_1.time_ and arg_492_1.time_ < var_495_3 + var_495_4 then
				local var_495_5 = Color.New(0, 0, 0)

				var_495_5.a = Mathf.Lerp(0, 1, (arg_492_1.time_ - var_495_3) / var_495_4)
				arg_492_1.mask_.color = var_495_5
			end

			if arg_492_1.time_ >= var_495_3 + var_495_4 and arg_492_1.time_ < var_495_3 + var_495_4 + arg_495_0 then
				local var_495_6 = Color.New(0, 0, 0)

				var_495_6.a = 1
				arg_492_1.mask_.color = var_495_6
			end

			local var_495_7 = 2

			if 2 < arg_492_1.time_ and arg_492_1.time_ <= var_495_7 + arg_495_0 then
				arg_492_1.mask_.enabled = true
				arg_492_1.mask_.raycastTarget = true

				arg_492_1:SetGaussion(false)
			end

			local var_495_8 = 2

			if var_495_7 <= arg_492_1.time_ and arg_492_1.time_ < var_495_7 + var_495_8 then
				local var_495_9 = Color.New(0, 0, 0)

				var_495_9.a = Mathf.Lerp(1, 0, (arg_492_1.time_ - var_495_7) / var_495_8)
				arg_492_1.mask_.color = var_495_9
			end

			if arg_492_1.time_ >= var_495_7 + var_495_8 and arg_492_1.time_ < var_495_7 + var_495_8 + arg_495_0 then
				local var_495_10 = Color.New(0, 0, 0)

				arg_492_1.mask_.enabled = false
				var_495_10.a = 0
				arg_492_1.mask_.color = var_495_10
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.fswbg_:SetActive(true)
				arg_492_1.dialog_:SetActive(false)

				arg_492_1.fswtw_.percent = 0
				arg_492_1.fswt_.text = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(221061116).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.fswt_)

				arg_492_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_492_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_492_1.fswtw_:SetDirty()

				arg_492_1.typewritterCharCountI18N = 0

				SetActive(arg_492_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_492_1:ShowNextGo(false)
			end

			local var_495_11 = 2

			if 2 < arg_492_1.time_ and arg_492_1.time_ <= var_495_11 + arg_495_0 then
				arg_492_1.var_.oldValueTypewriter = arg_492_1.fswtw_.percent

				SetActive(arg_492_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_492_1:ShowNextGo(false)
			end

			local var_495_12 = 18
			local var_495_13 = 1.2
			local var_495_14, var_495_15 = arg_492_1:GetPercentByPara(arg_492_1:FormatText(arg_492_1:GetWordFromCfg(221061116).content), 1)

			if var_495_11 < arg_492_1.time_ and arg_492_1.time_ <= var_495_11 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0

				local var_495_16 = var_495_12 <= 0 and var_495_13 or var_495_13 * ((var_495_15 - arg_492_1.typewritterCharCountI18N) / var_495_12)

				if (var_495_12 <= 0 and var_495_13 or var_495_13 * ((var_495_15 - arg_492_1.typewritterCharCountI18N) / var_495_12)) > 0 and var_495_13 < var_495_16 then
					arg_492_1.talkMaxDuration = var_495_16

					if var_495_16 + var_495_11 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_16 + var_495_11
					end
				end
			end

			local var_495_17 = math.max(1.2, arg_492_1.talkMaxDuration)

			if var_495_11 <= arg_492_1.time_ and arg_492_1.time_ < var_495_11 + var_495_17 then
				arg_492_1.fswtw_.percent = Mathf.Lerp(arg_492_1.var_.oldValueTypewriter, var_495_14, (arg_492_1.time_ - var_495_11) / var_495_17)
				arg_492_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_492_1.fswtw_:SetDirty()
			end

			if arg_492_1.time_ >= var_495_11 + var_495_17 and arg_492_1.time_ < var_495_11 + var_495_17 + arg_495_0 then
				arg_492_1.fswtw_.percent = var_495_14

				arg_492_1.fswtw_:SetDirty()
				arg_492_1:ShowNextGo(true)

				arg_492_1.typewritterCharCountI18N = var_495_15
			end

			local var_495_18 = arg_492_1.actors_["1072ui_story"].transform

			if 1.966 < arg_492_1.time_ and arg_492_1.time_ <= 1.966 + arg_495_0 then
				arg_492_1.var_.moveOldPos1072ui_story = var_495_18.localPosition
			end

			local var_495_19 = 0.001

			if 1.966 <= arg_492_1.time_ and arg_492_1.time_ < 1.966 + var_495_19 then
				var_495_18.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_492_1.time_ - 1.966) / var_495_19)
				var_495_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_495_18.position).x, (manager.ui.mainCamera.transform.position - var_495_18.position).y, (manager.ui.mainCamera.transform.position - var_495_18.position).z)
				var_495_18.localEulerAngles.z = 0
				var_495_18.localEulerAngles.x = 0
				var_495_18.localEulerAngles = var_495_18.localEulerAngles
			end

			if arg_492_1.time_ >= 1.966 + var_495_19 and arg_492_1.time_ < 1.966 + var_495_19 + arg_495_0 then
				var_495_18.localPosition = Vector3.New(0, 100, 0)
				var_495_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_495_18.position).x, (manager.ui.mainCamera.transform.position - var_495_18.position).y, (manager.ui.mainCamera.transform.position - var_495_18.position).z)
				var_495_18.localEulerAngles.z = 0
				var_495_18.localEulerAngles.x = 0
				var_495_18.localEulerAngles = var_495_18.localEulerAngles
			end

			local var_495_20 = arg_492_1.actors_["1076ui_story"].transform

			if 1.966 < arg_492_1.time_ and arg_492_1.time_ <= 1.966 + arg_495_0 then
				arg_492_1.var_.moveOldPos1076ui_story = var_495_20.localPosition
			end

			local var_495_21 = 0.001

			if 1.966 <= arg_492_1.time_ and arg_492_1.time_ < 1.966 + var_495_21 then
				var_495_20.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_492_1.time_ - 1.966) / var_495_21)
				var_495_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_495_20.position).x, (manager.ui.mainCamera.transform.position - var_495_20.position).y, (manager.ui.mainCamera.transform.position - var_495_20.position).z)
				var_495_20.localEulerAngles.z = 0
				var_495_20.localEulerAngles.x = 0
				var_495_20.localEulerAngles = var_495_20.localEulerAngles
			end

			if arg_492_1.time_ >= 1.966 + var_495_21 and arg_492_1.time_ < 1.966 + var_495_21 + arg_495_0 then
				var_495_20.localPosition = Vector3.New(0, 100, 0)
				var_495_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_495_20.position).x, (manager.ui.mainCamera.transform.position - var_495_20.position).y, (manager.ui.mainCamera.transform.position - var_495_20.position).z)
				var_495_20.localEulerAngles.z = 0
				var_495_20.localEulerAngles.x = 0
				var_495_20.localEulerAngles = var_495_20.localEulerAngles
			end

			if 2 < arg_492_1.time_ and arg_492_1.time_ <= 2 + arg_495_0 then
				local var_495_22 = arg_492_1.fswbg_.transform:Find("textbox/adapt/content") or arg_492_1.fswbg_.transform:Find("textbox/content")
				local var_495_23 = arg_492_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_495_24 = var_495_22:GetComponent("RectTransform")

				var_495_22:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_495_24.offsetMin = Vector2.New(0, 0)
				var_495_24.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST39",
		"TextureConfig/Background/XH0801",
		"TextureConfig/Background/XH0802",
		"TextureConfig/Background/XH0804",
		"TextureConfig/Background/XH0805",
		"TextureConfig/Background/XH0807",
		"TextureConfig/Background/XH0808",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0404",
		"TextureConfig/Background/ST31a"
	},
	voices = {
		"story_v_out_221061.awb"
	}
}
