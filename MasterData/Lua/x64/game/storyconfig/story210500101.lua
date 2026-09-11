return {
	Play1105001001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105001001
		arg_1_1.duration_ = 9.43

		local var_1_0 = {
			zh = 7.333,
			ja = 9.433
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
				arg_1_0:Play1105001002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K05f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_4_0.name = "K05f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K05f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K05f

				arg_1_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K05f" then
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

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
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
			local var_4_24 = 0.775

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(1105001001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 31 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 31)

				if (31 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 31)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001001", "story_v_side_new_1105001.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001001", "story_v_side_new_1105001.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_side_new_1105001", "1105001001", "story_v_side_new_1105001.awb")

						arg_1_1:RecordAudio("1105001001", var_4_31)
						arg_1_1:RecordAudio("1105001001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001001", "story_v_side_new_1105001.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001001", "story_v_side_new_1105001.awb")
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
	Play1105001002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105001002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1105001003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1050ui_story"]) and arg_9_1.var_.characterEffect1050ui_story == nil then
				arg_9_1.var_.characterEffect1050ui_story = arg_9_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1050ui_story"]) then
				if arg_9_1.var_.characterEffect1050ui_story and not isNil(arg_9_1.actors_["1050ui_story"]) then
					arg_9_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1050ui_story"]) and arg_9_1.var_.characterEffect1050ui_story then
				arg_9_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1105001002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 28 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 28)

				if (28 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 28)) > 0 and var_12_2 < var_12_5 then
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
	Play1105001003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105001003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105001004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.85

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1105001003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)) > 0 and var_16_0 < var_16_3 then
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
	Play1105001004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105001004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1105001005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1050ui_story = arg_17_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1050ui_story"].transform.position).z)
				arg_17_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1050ui_story"].transform.localEulerAngles = arg_17_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1050ui_story"].transform.position).z)
				arg_17_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1050ui_story"].transform.localEulerAngles = arg_17_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_20_1 = 0
			local var_20_2 = 0.85

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1105001004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 34 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 34)

				if (34 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 34)) > 0 and var_20_2 < var_20_5 then
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

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play1105001005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105001005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105001006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.725

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1105001005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 29 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 29)

				if (29 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 29)) > 0 and var_24_0 < var_24_3 then
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
	Play1105001006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105001006
		arg_25_1.duration_ = 6.97

		local var_25_0 = {
			zh = 5.4,
			ja = 6.966
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
				arg_25_0:Play1105001007(arg_25_1)
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
			local var_28_5 = 0.7

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

				local var_28_6 = arg_25_1:GetWordFromCfg(1105001006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 28 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 28)

				if (28 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 28)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001006", "story_v_side_new_1105001.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001006", "story_v_side_new_1105001.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_new_1105001", "1105001006", "story_v_side_new_1105001.awb")

						arg_25_1:RecordAudio("1105001006", var_28_11)
						arg_25_1:RecordAudio("1105001006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001006", "story_v_side_new_1105001.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001006", "story_v_side_new_1105001.awb")
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
	Play1105001007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105001007
		arg_29_1.duration_ = 11.2

		local var_29_0 = {
			zh = 9.933,
			ja = 11.2
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
				arg_29_0:Play1105001008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1050ui_story = arg_29_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).z)
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles = arg_29_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_29_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).z)
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles = arg_29_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1050ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1050ui_story == nil then
				arg_29_1.var_.characterEffect1050ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1050ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1050ui_story then
				arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action424")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_32_4 = 0
			local var_32_5 = 1.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
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

				local var_32_6 = arg_29_1:GetWordFromCfg(1105001007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 49 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 49)

				if (49 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 49)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001007", "story_v_side_new_1105001.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001007", "story_v_side_new_1105001.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_side_new_1105001", "1105001007", "story_v_side_new_1105001.awb")

						arg_29_1:RecordAudio("1105001007", var_32_11)
						arg_29_1:RecordAudio("1105001007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001007", "story_v_side_new_1105001.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001007", "story_v_side_new_1105001.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play1105001008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105001008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1105001009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1050ui_story"]) and arg_33_1.var_.characterEffect1050ui_story == nil then
				arg_33_1.var_.characterEffect1050ui_story = arg_33_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1050ui_story"]) then
				if arg_33_1.var_.characterEffect1050ui_story and not isNil(arg_33_1.actors_["1050ui_story"]) then
					arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1050ui_story"]) and arg_33_1.var_.characterEffect1050ui_story then
				arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1105001008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 16 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 16)

				if (16 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 16)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1105001009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105001009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105001010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.5

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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1105001009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 20 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 20)

				if (20 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 20)) > 0 and var_40_0 < var_40_3 then
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
	Play1105001010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105001010
		arg_41_1.duration_ = 6.53

		local var_41_0 = {
			zh = 6.533,
			ja = 5.433
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
				arg_41_0:Play1105001011(arg_41_1)
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
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.65

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

				local var_44_6 = arg_41_1:GetWordFromCfg(1105001010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 26 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 26)

				if (26 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 26)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001010", "story_v_side_new_1105001.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001010", "story_v_side_new_1105001.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1105001", "1105001010", "story_v_side_new_1105001.awb")

						arg_41_1:RecordAudio("1105001010", var_44_11)
						arg_41_1:RecordAudio("1105001010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001010", "story_v_side_new_1105001.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001010", "story_v_side_new_1105001.awb")
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
	Play1105001011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105001011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1105001012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1050ui_story"]) and arg_45_1.var_.characterEffect1050ui_story == nil then
				arg_45_1.var_.characterEffect1050ui_story = arg_45_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1050ui_story"]) then
				if arg_45_1.var_.characterEffect1050ui_story and not isNil(arg_45_1.actors_["1050ui_story"]) then
					arg_45_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1050ui_story"]) and arg_45_1.var_.characterEffect1050ui_story then
				arg_45_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.325

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1105001011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 13 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 13)

				if (13 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 13)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105001012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105001012
		arg_49_1.duration_ = 8.4

		local var_49_0 = {
			zh = 5.8,
			ja = 8.4
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
				arg_49_0:Play1105001013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1050ui_story = arg_49_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).z)
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles = arg_49_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_49_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).z)
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles = arg_49_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1050ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1050ui_story == nil then
				arg_49_1.var_.characterEffect1050ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1050ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1050ui_story then
				arg_49_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.675

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(1105001012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 27 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 27)

				if (27 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 27)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001012", "story_v_side_new_1105001.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001012", "story_v_side_new_1105001.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_new_1105001", "1105001012", "story_v_side_new_1105001.awb")

						arg_49_1:RecordAudio("1105001012", var_52_11)
						arg_49_1:RecordAudio("1105001012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001012", "story_v_side_new_1105001.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001012", "story_v_side_new_1105001.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play1105001013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105001013
		arg_53_1.duration_ = 11.6

		local var_53_0 = {
			zh = 10.766,
			ja = 11.6
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
				arg_53_0:Play1105001014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.075

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(1105001013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 43 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 43)

				if (43 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 43)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001013", "story_v_side_new_1105001.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001013", "story_v_side_new_1105001.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_side_new_1105001", "1105001013", "story_v_side_new_1105001.awb")

						arg_53_1:RecordAudio("1105001013", var_56_6)
						arg_53_1:RecordAudio("1105001013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001013", "story_v_side_new_1105001.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001013", "story_v_side_new_1105001.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1105001014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1105001014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1105001015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1050ui_story"]) and arg_57_1.var_.characterEffect1050ui_story == nil then
				arg_57_1.var_.characterEffect1050ui_story = arg_57_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1050ui_story"]) then
				if arg_57_1.var_.characterEffect1050ui_story and not isNil(arg_57_1.actors_["1050ui_story"]) then
					arg_57_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1050ui_story"]) and arg_57_1.var_.characterEffect1050ui_story then
				arg_57_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(1105001014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 28 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 28)

				if (28 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 28)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1105001015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1105001015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1105001016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1105001015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 60 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 60)

				if (60 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 60)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1105001016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1105001016
		arg_65_1.duration_ = 9.77

		local var_65_0 = {
			zh = 6.233,
			ja = 9.766
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
				arg_65_0:Play1105001017(arg_65_1)
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
				arg_65_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.85

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

				local var_68_6 = arg_65_1:GetWordFromCfg(1105001016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 34 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 34)

				if (34 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 34)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001016", "story_v_side_new_1105001.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001016", "story_v_side_new_1105001.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_new_1105001", "1105001016", "story_v_side_new_1105001.awb")

						arg_65_1:RecordAudio("1105001016", var_68_11)
						arg_65_1:RecordAudio("1105001016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001016", "story_v_side_new_1105001.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001016", "story_v_side_new_1105001.awb")
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
	Play1105001017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1105001017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1105001018(arg_69_1)
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
			local var_72_2 = 0.625

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

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1105001017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 25 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 25)

				if (25 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 25)) > 0 and var_72_2 < var_72_5 then
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
	Play1105001018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1105001018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1105001019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1050ui_story = arg_73_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).z)
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles = arg_73_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).z)
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles = arg_73_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_76_1 = 0
			local var_76_2 = 0.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1105001018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 26 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 26)

				if (26 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 26)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play1105001019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1105001019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1105001020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1105001019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 15 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 15)

				if (15 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 15)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1105001020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1105001020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1105001021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.075

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1105001020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 43 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 43)

				if (43 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 43)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1105001021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1105001021
		arg_85_1.duration_ = 9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1105001022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.bgs_.K06f == nil then
				local var_88_0 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06f")
				var_88_0.name = "K06f"
				var_88_0.transform.parent = arg_85_1.stage_.transform
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_.K06f = var_88_0
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				local var_88_1 = arg_85_1.bgs_.K06f

				arg_85_1.bgs_.K06f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_2 = var_88_1:GetComponent("SpriteRenderer")

				if var_88_2 and var_88_2.sprite then
					local var_88_3 = 2 * (var_88_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_1.transform.localScale = Vector3.New(var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "K06f" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_4 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_5 = 2

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_5 then
				local var_88_6 = Color.New(0, 0, 0)

				var_88_6.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_4) / var_88_5)
				arg_85_1.mask_.color = var_88_6
			end

			if arg_85_1.time_ >= var_88_4 + var_88_5 and arg_85_1.time_ < var_88_4 + var_88_5 + arg_88_0 then
				local var_88_7 = Color.New(0, 0, 0)

				var_88_7.a = 1
				arg_85_1.mask_.color = var_88_7
			end

			local var_88_8 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_9 = 2

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 then
				local var_88_10 = Color.New(0, 0, 0)

				var_88_10.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_8) / var_88_9)
				arg_85_1.mask_.color = var_88_10
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 then
				local var_88_11 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_11.a = 0
				arg_85_1.mask_.color = var_88_11
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_12 = 4
			local var_88_13 = 0.75

			if 4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_14 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_14:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_15 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1105001021).content)

				arg_85_1.text_.text = var_88_15

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_17 = 30 <= 0 and var_88_13 or var_88_13 * (utf8.len(var_88_15) / 30)

				if (30 <= 0 and var_88_13 or var_88_13 * (utf8.len(var_88_15) / 30)) > 0 and var_88_13 < var_88_17 then
					arg_85_1.talkMaxDuration = var_88_17
					var_88_12 = var_88_12 + 0.3

					if var_88_17 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_12
					end
				end

				arg_85_1.text_.text = var_88_15
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = var_88_12 + 0.3
			local var_88_19 = math.max(var_88_13, arg_85_1.talkMaxDuration)

			if var_88_12 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_19 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_18) / var_88_19

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_18 + var_88_19 and arg_85_1.time_ < var_88_18 + var_88_19 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1105001022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1105001022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1105001023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.5

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1105001022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 60 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 60)

				if (60 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 60)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1105001023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1105001023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1105001024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.675

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1105001023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 27 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 27)

				if (27 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 27)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1105001024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1105001024
		arg_99_1.duration_ = 6.07

		local var_99_0 = {
			zh = 5.766,
			ja = 6.066
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1105001025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.6

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[482].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(1105001024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 24 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 24)

				if (24 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 24)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001024", "story_v_side_new_1105001.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001024", "story_v_side_new_1105001.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_side_new_1105001", "1105001024", "story_v_side_new_1105001.awb")

						arg_99_1:RecordAudio("1105001024", var_102_6)
						arg_99_1:RecordAudio("1105001024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001024", "story_v_side_new_1105001.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001024", "story_v_side_new_1105001.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1105001025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1105001025
		arg_103_1.duration_ = 12.77

		local var_103_0 = {
			zh = 12.766,
			ja = 9.033
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1105001026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.25

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[483].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(1105001025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 50 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 50)

				if (50 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 50)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001025", "story_v_side_new_1105001.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001025", "story_v_side_new_1105001.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_side_new_1105001", "1105001025", "story_v_side_new_1105001.awb")

						arg_103_1:RecordAudio("1105001025", var_106_6)
						arg_103_1:RecordAudio("1105001025", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001025", "story_v_side_new_1105001.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001025", "story_v_side_new_1105001.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1105001026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1105001026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1105001027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1050ui_story = arg_107_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1050ui_story"].transform.position).z)
				arg_107_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1050ui_story"].transform.localEulerAngles = arg_107_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_107_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1050ui_story"].transform.position).z)
				arg_107_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1050ui_story"].transform.localEulerAngles = arg_107_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1050ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1050ui_story == nil then
				arg_107_1.var_.characterEffect1050ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.0166666666666667

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1050ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_2)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1050ui_story then
				arg_107_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_110_3 = 0
			local var_110_4 = 1.625

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1105001026).content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 65 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 65)

				if (65 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 65)) > 0 and var_110_4 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_8 and arg_107_1.time_ < var_110_3 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play1105001027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1105001027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1105001028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.35

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1105001027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 54 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 54)

				if (54 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 54)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1105001028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1105001028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1105001029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			local var_118_0 = 0
			local var_118_1 = 0.55

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_2 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1105001028).content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 22 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_2) / 22)

				if (22 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_2) / 22)) > 0 and var_118_1 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_5 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_5 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_5

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_5 and arg_115_1.time_ < var_118_0 + var_118_5 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1105001029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1105001029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1105001030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_122_0 = 0
			local var_122_1 = 0.775

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1105001029).content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 31 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_2) / 31)

				if (31 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_2) / 31)) > 0 and var_122_1 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_5 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_5 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_5

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_5 and arg_119_1.time_ < var_122_0 + var_122_5 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1105001030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1105001030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1105001031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.25

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1105001030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 10 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 10)

				if (10 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 10)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1105001031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1105001031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1105001032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.7

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1105001031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 28 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 28)

				if (28 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 28)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1105001032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1105001032
		arg_131_1.duration_ = 10.57

		local var_131_0 = {
			zh = 5.333,
			ja = 10.566
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
				arg_131_0:Play1105001033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.75

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[483].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:GetWordFromCfg(1105001032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 30 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 30)

				if (30 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 30)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001032", "story_v_side_new_1105001.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001032", "story_v_side_new_1105001.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_side_new_1105001", "1105001032", "story_v_side_new_1105001.awb")

						arg_131_1:RecordAudio("1105001032", var_134_6)
						arg_131_1:RecordAudio("1105001032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001032", "story_v_side_new_1105001.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001032", "story_v_side_new_1105001.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1105001033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1105001033
		arg_135_1.duration_ = 3.3

		local var_135_0 = {
			zh = 3.1,
			ja = 3.3
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
				arg_135_0:Play1105001034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.325

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[482].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(1105001033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 13 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 13)

				if (13 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 13)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001033", "story_v_side_new_1105001.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001033", "story_v_side_new_1105001.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_side_new_1105001", "1105001033", "story_v_side_new_1105001.awb")

						arg_135_1:RecordAudio("1105001033", var_138_6)
						arg_135_1:RecordAudio("1105001033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001033", "story_v_side_new_1105001.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001033", "story_v_side_new_1105001.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1105001034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1105001034
		arg_139_1.duration_ = 10

		local var_139_0 = {
			zh = 10,
			ja = 8.1
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
				arg_139_0:Play1105001035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.975

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[483].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:GetWordFromCfg(1105001034)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 39 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 39)

				if (39 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 39)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001034", "story_v_side_new_1105001.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001034", "story_v_side_new_1105001.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_side_new_1105001", "1105001034", "story_v_side_new_1105001.awb")

						arg_139_1:RecordAudio("1105001034", var_142_6)
						arg_139_1:RecordAudio("1105001034", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001034", "story_v_side_new_1105001.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001034", "story_v_side_new_1105001.awb")
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
	Play1105001035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1105001035
		arg_143_1.duration_ = 8.53

		local var_143_0 = {
			zh = 8.533,
			ja = 7.6
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1105001036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.85

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[483].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(1105001035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 34 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 34)

				if (34 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 34)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001035", "story_v_side_new_1105001.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001035", "story_v_side_new_1105001.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_side_new_1105001", "1105001035", "story_v_side_new_1105001.awb")

						arg_143_1:RecordAudio("1105001035", var_146_6)
						arg_143_1:RecordAudio("1105001035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001035", "story_v_side_new_1105001.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001035", "story_v_side_new_1105001.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1105001036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1105001036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1105001037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1050ui_story = arg_147_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1050ui_story"].transform.position).z)
				arg_147_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1050ui_story"].transform.localEulerAngles = arg_147_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1050ui_story"].transform.position).z)
				arg_147_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1050ui_story"].transform.localEulerAngles = arg_147_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_150_1 = 0
			local var_150_2 = 0.975

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1105001036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 39 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 39)

				if (39 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 39)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play1105001037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1105001037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1105001038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.575

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1105001037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 23 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 23)

				if (23 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 23)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1105001038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1105001038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1105001039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.575

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

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1105001038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 23 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 23)

				if (23 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 23)) > 0 and var_158_0 < var_158_3 then
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
	Play1105001039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1105001039
		arg_159_1.duration_ = 4.63

		local var_159_0 = {
			zh = 2.566,
			ja = 4.633
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
				arg_159_0:Play1105001040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.125

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[630].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_a")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(1105001039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 5 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 5)

				if (5 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 5)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001039", "story_v_side_new_1105001.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001039", "story_v_side_new_1105001.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_side_new_1105001", "1105001039", "story_v_side_new_1105001.awb")

						arg_159_1:RecordAudio("1105001039", var_162_6)
						arg_159_1:RecordAudio("1105001039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001039", "story_v_side_new_1105001.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001039", "story_v_side_new_1105001.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1105001040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1105001040
		arg_163_1.duration_ = 5.13

		local var_163_0 = {
			zh = 2.1,
			ja = 5.133
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
				arg_163_0:Play1105001041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1050ui_story = arg_163_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1050ui_story"].transform.position).z)
				arg_163_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1050ui_story"].transform.localEulerAngles = arg_163_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_163_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1050ui_story"].transform.position).z)
				arg_163_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1050ui_story"].transform.localEulerAngles = arg_163_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1050ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1050ui_story == nil then
				arg_163_1.var_.characterEffect1050ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1050ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1050ui_story then
				arg_163_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.275

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(1105001040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 11 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 11)

				if (11 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 11)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001040", "story_v_side_new_1105001.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001040", "story_v_side_new_1105001.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_side_new_1105001", "1105001040", "story_v_side_new_1105001.awb")

						arg_163_1:RecordAudio("1105001040", var_166_11)
						arg_163_1:RecordAudio("1105001040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001040", "story_v_side_new_1105001.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001040", "story_v_side_new_1105001.awb")
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
				actorName = "1050ui_story",
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
	Play1105001041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1105001041
		arg_167_1.duration_ = 7.27

		local var_167_0 = {
			zh = 3.6,
			ja = 7.266
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
				arg_167_0:Play1105001042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(1105001041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 17)

				if (17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 17)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001041", "story_v_side_new_1105001.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001041", "story_v_side_new_1105001.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_side_new_1105001", "1105001041", "story_v_side_new_1105001.awb")

						arg_167_1:RecordAudio("1105001041", var_170_6)
						arg_167_1:RecordAudio("1105001041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001041", "story_v_side_new_1105001.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001041", "story_v_side_new_1105001.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1105001042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1105001042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1105001043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1050ui_story"]) and arg_171_1.var_.characterEffect1050ui_story == nil then
				arg_171_1.var_.characterEffect1050ui_story = arg_171_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1050ui_story"]) then
				if arg_171_1.var_.characterEffect1050ui_story and not isNil(arg_171_1.actors_["1050ui_story"]) then
					arg_171_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1050ui_story"]) and arg_171_1.var_.characterEffect1050ui_story then
				arg_171_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.6

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1105001042).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 24 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 24)

				if (24 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 24)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1105001043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1105001043
		arg_175_1.duration_ = 8.93

		local var_175_0 = {
			zh = 8.933,
			ja = 8.733
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
				arg_175_0:Play1105001044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.075

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[630].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_a")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(1105001043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 43 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 43)

				if (43 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 43)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001043", "story_v_side_new_1105001.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001043", "story_v_side_new_1105001.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_side_new_1105001", "1105001043", "story_v_side_new_1105001.awb")

						arg_175_1:RecordAudio("1105001043", var_178_6)
						arg_175_1:RecordAudio("1105001043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001043", "story_v_side_new_1105001.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001043", "story_v_side_new_1105001.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1105001044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1105001044
		arg_179_1.duration_ = 7.4

		local var_179_0 = {
			zh = 7.4,
			ja = 6.3
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
				arg_179_0:Play1105001045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1050ui_story = arg_179_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1050ui_story"].transform.position).z)
				arg_179_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1050ui_story"].transform.localEulerAngles = arg_179_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_179_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1050ui_story"].transform.position).z)
				arg_179_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1050ui_story"].transform.localEulerAngles = arg_179_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1050ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1050ui_story == nil then
				arg_179_1.var_.characterEffect1050ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1050ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1050ui_story then
				arg_179_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.975

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(1105001044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 39 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 39)

				if (39 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 39)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001044", "story_v_side_new_1105001.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001044", "story_v_side_new_1105001.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_side_new_1105001", "1105001044", "story_v_side_new_1105001.awb")

						arg_179_1:RecordAudio("1105001044", var_182_11)
						arg_179_1:RecordAudio("1105001044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001044", "story_v_side_new_1105001.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001044", "story_v_side_new_1105001.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play1105001045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1105001045
		arg_183_1.duration_ = 8

		local var_183_0 = {
			zh = 8,
			ja = 6.733
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1105001046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1050ui_story"]) and arg_183_1.var_.characterEffect1050ui_story == nil then
				arg_183_1.var_.characterEffect1050ui_story = arg_183_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1050ui_story"]) then
				if arg_183_1.var_.characterEffect1050ui_story and not isNil(arg_183_1.actors_["1050ui_story"]) then
					arg_183_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1050ui_story"]) and arg_183_1.var_.characterEffect1050ui_story then
				arg_183_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.625

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[630].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_a")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(1105001045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 25 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_4) / 25)

				if (25 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_4) / 25)) > 0 and var_186_2 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001045", "story_v_side_new_1105001.awb") ~= 0 then
					local var_186_7 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001045", "story_v_side_new_1105001.awb") / 1000

					if var_186_7 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_1
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_side_new_1105001", "1105001045", "story_v_side_new_1105001.awb")

						arg_183_1:RecordAudio("1105001045", var_186_8)
						arg_183_1:RecordAudio("1105001045", var_186_8)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001045", "story_v_side_new_1105001.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001045", "story_v_side_new_1105001.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_9 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_9 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_9

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_9 and arg_183_1.time_ < var_186_1 + var_186_9 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1105001046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1105001046
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1105001047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1050ui_story = arg_187_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1050ui_story"].transform.position).z)
				arg_187_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1050ui_story"].transform.localEulerAngles = arg_187_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_187_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1050ui_story"].transform.position).z)
				arg_187_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1050ui_story"].transform.localEulerAngles = arg_187_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1050ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1050ui_story == nil then
				arg_187_1.var_.characterEffect1050ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1050ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1050ui_story then
				arg_187_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_190_4 = 0
			local var_190_5 = 0.075

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(1105001046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 3 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 3)

				if (3 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 3)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001046", "story_v_side_new_1105001.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001046", "story_v_side_new_1105001.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_side_new_1105001", "1105001046", "story_v_side_new_1105001.awb")

						arg_187_1:RecordAudio("1105001046", var_190_11)
						arg_187_1:RecordAudio("1105001046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001046", "story_v_side_new_1105001.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001046", "story_v_side_new_1105001.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play1105001047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1105001047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1105001048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1050ui_story"]) and arg_191_1.var_.characterEffect1050ui_story == nil then
				arg_191_1.var_.characterEffect1050ui_story = arg_191_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1050ui_story"]) then
				if arg_191_1.var_.characterEffect1050ui_story and not isNil(arg_191_1.actors_["1050ui_story"]) then
					arg_191_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1050ui_story"]) and arg_191_1.var_.characterEffect1050ui_story then
				arg_191_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 1.075

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1105001047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 43 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 43)

				if (43 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 43)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1105001048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1105001048
		arg_195_1.duration_ = 7.5

		local var_195_0 = {
			zh = 7.5,
			ja = 3.833
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1105001049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.825

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[630].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_a")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(1105001048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 33 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 33)

				if (33 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 33)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001048", "story_v_side_new_1105001.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001048", "story_v_side_new_1105001.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_side_new_1105001", "1105001048", "story_v_side_new_1105001.awb")

						arg_195_1:RecordAudio("1105001048", var_198_6)
						arg_195_1:RecordAudio("1105001048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001048", "story_v_side_new_1105001.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001048", "story_v_side_new_1105001.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1105001049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1105001049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1105001050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1

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

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1105001049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 40 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 40)

				if (40 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 40)) > 0 and var_202_0 < var_202_3 then
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
	Play1105001050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1105001050
		arg_203_1.duration_ = 3.37

		local var_203_0 = {
			zh = 2.766,
			ja = 3.366
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
				arg_203_0:Play1105001051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1050ui_story = arg_203_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1050ui_story"].transform.position).z)
				arg_203_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1050ui_story"].transform.localEulerAngles = arg_203_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_203_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1050ui_story"].transform.position).z)
				arg_203_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1050ui_story"].transform.localEulerAngles = arg_203_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1050ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1050ui_story == nil then
				arg_203_1.var_.characterEffect1050ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1050ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1050ui_story then
				arg_203_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_2")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(1105001050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 19 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 19)

				if (19 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 19)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001050", "story_v_side_new_1105001.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001050", "story_v_side_new_1105001.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_side_new_1105001", "1105001050", "story_v_side_new_1105001.awb")

						arg_203_1:RecordAudio("1105001050", var_206_11)
						arg_203_1:RecordAudio("1105001050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001050", "story_v_side_new_1105001.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001050", "story_v_side_new_1105001.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play1105001051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1105001051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1105001052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1050ui_story"]) and arg_207_1.var_.characterEffect1050ui_story == nil then
				arg_207_1.var_.characterEffect1050ui_story = arg_207_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1050ui_story"]) then
				if arg_207_1.var_.characterEffect1050ui_story and not isNil(arg_207_1.actors_["1050ui_story"]) then
					arg_207_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1050ui_story"]) and arg_207_1.var_.characterEffect1050ui_story then
				arg_207_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.775

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1105001051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 31 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 31)

				if (31 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 31)) > 0 and var_210_2 < var_210_5 then
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
	Play1105001052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1105001052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1105001053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.425

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1105001052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 17 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 17)

				if (17 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 17)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1105001053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1105001053
		arg_215_1.duration_ = 3.8

		local var_215_0 = {
			zh = 3.8,
			ja = 1.999999999999
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
				arg_215_0:Play1105001054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1050ui_story = arg_215_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1050ui_story"].transform.position).z)
				arg_215_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1050ui_story"].transform.localEulerAngles = arg_215_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_215_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1050ui_story"].transform.position).z)
				arg_215_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1050ui_story"].transform.localEulerAngles = arg_215_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1050ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1050ui_story == nil then
				arg_215_1.var_.characterEffect1050ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1050ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1050ui_story then
				arg_215_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.425

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(1105001053)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 17 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 17)

				if (17 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 17)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001053", "story_v_side_new_1105001.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001053", "story_v_side_new_1105001.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_side_new_1105001", "1105001053", "story_v_side_new_1105001.awb")

						arg_215_1:RecordAudio("1105001053", var_218_11)
						arg_215_1:RecordAudio("1105001053", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001053", "story_v_side_new_1105001.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001053", "story_v_side_new_1105001.awb")
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
				actorName = "1050ui_story",
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
	Play1105001054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1105001054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1105001055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1050ui_story"]) and arg_219_1.var_.characterEffect1050ui_story == nil then
				arg_219_1.var_.characterEffect1050ui_story = arg_219_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1050ui_story"]) then
				if arg_219_1.var_.characterEffect1050ui_story and not isNil(arg_219_1.actors_["1050ui_story"]) then
					arg_219_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1050ui_story"]) and arg_219_1.var_.characterEffect1050ui_story then
				arg_219_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.15

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

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1105001054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 6 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 6)

				if (6 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 6)) > 0 and var_222_2 < var_222_5 then
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
	Play1105001055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1105001055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1105001056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.575

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1105001055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 23 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 23)

				if (23 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 23)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1105001056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1105001056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1105001057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_230_0 = 0
			local var_230_1 = 0.8

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1105001056).content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 32 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_2) / 32)

				if (32 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_2) / 32)) > 0 and var_230_1 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_5 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_5 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_5

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_5 and arg_227_1.time_ < var_230_0 + var_230_5 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1105001057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1105001057
		arg_231_1.duration_ = 5.27

		local var_231_0 = {
			zh = 5.266,
			ja = 4.033
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1105001058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1050ui_story = arg_231_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1050ui_story"].transform.position).z)
				arg_231_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1050ui_story"].transform.localEulerAngles = arg_231_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_231_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1050ui_story"].transform.position).z)
				arg_231_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1050ui_story"].transform.localEulerAngles = arg_231_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1050ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1050ui_story == nil then
				arg_231_1.var_.characterEffect1050ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1050ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1050ui_story then
				arg_231_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_234_4 = 0
			local var_234_5 = 0.8

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(1105001057)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 32 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 32)

				if (32 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 32)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001057", "story_v_side_new_1105001.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001057", "story_v_side_new_1105001.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_side_new_1105001", "1105001057", "story_v_side_new_1105001.awb")

						arg_231_1:RecordAudio("1105001057", var_234_11)
						arg_231_1:RecordAudio("1105001057", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001057", "story_v_side_new_1105001.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001057", "story_v_side_new_1105001.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play1105001058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1105001058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1105001059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1050ui_story"]) and arg_235_1.var_.characterEffect1050ui_story == nil then
				arg_235_1.var_.characterEffect1050ui_story = arg_235_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1050ui_story"]) then
				if arg_235_1.var_.characterEffect1050ui_story and not isNil(arg_235_1.actors_["1050ui_story"]) then
					arg_235_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1050ui_story"]) and arg_235_1.var_.characterEffect1050ui_story then
				arg_235_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.525

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(1105001058).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 21 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 21)

				if (21 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 21)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1105001059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1105001059
		arg_239_1.duration_ = 1

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"

			SetActive(arg_239_1.choicesGo_, true)

			for iter_240_0, iter_240_1 in ipairs(arg_239_1.choices_) do
				SetActive(iter_240_1.go, iter_240_0 <= 2)
			end

			arg_239_1.choices_[1].txt.text = arg_239_1:FormatText(StoryChoiceCfg[632].name)
			arg_239_1.choices_[2].txt.text = arg_239_1:FormatText(StoryChoiceCfg[633].name)
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1105001060(arg_239_1)
			end

			if arg_241_0 == 2 then
				arg_239_0:Play1105001061(arg_239_1)
			end

			arg_239_1:RecordChoiceLog(1105001059, 632, 633)
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			if arg_239_1.time_ >= 0 + 0.5 and arg_239_1.time_ < 0 + 0.5 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1105001060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1105001060
		arg_243_1.duration_ = 4.37

		local var_243_0 = {
			zh = 4.366,
			ja = 2.2
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1105001061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1050ui_story = arg_243_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1050ui_story"].transform.position).z)
				arg_243_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1050ui_story"].transform.localEulerAngles = arg_243_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_243_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1050ui_story"].transform.position).z)
				arg_243_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1050ui_story"].transform.localEulerAngles = arg_243_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1050ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1050ui_story == nil then
				arg_243_1.var_.characterEffect1050ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1050ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1050ui_story then
				arg_243_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_246_4 = 0
			local var_246_5 = 0.225

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(1105001060)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 9 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 9)

				if (9 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 9)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001060", "story_v_side_new_1105001.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001060", "story_v_side_new_1105001.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_side_new_1105001", "1105001060", "story_v_side_new_1105001.awb")

						arg_243_1:RecordAudio("1105001060", var_246_11)
						arg_243_1:RecordAudio("1105001060", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001060", "story_v_side_new_1105001.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001060", "story_v_side_new_1105001.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play1105001061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1105001061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1105001062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1050ui_story"]) and arg_247_1.var_.characterEffect1050ui_story == nil then
				arg_247_1.var_.characterEffect1050ui_story = arg_247_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1050ui_story"]) then
				if arg_247_1.var_.characterEffect1050ui_story and not isNil(arg_247_1.actors_["1050ui_story"]) then
					arg_247_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1050ui_story"]) and arg_247_1.var_.characterEffect1050ui_story then
				arg_247_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.475

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1105001061).content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 19 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 19)

				if (19 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 19)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_6 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_6 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_6

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_6 and arg_247_1.time_ < var_250_1 + var_250_6 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1105001062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1105001062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1105001063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.2

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1105001062).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 48 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 48)

				if (48 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 48)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1105001063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1105001063
		arg_255_1.duration_ = 9.6

		local var_255_0 = {
			zh = 7.533,
			ja = 9.6
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
				arg_255_0:Play1105001064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(1105001063)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 40 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 40)

				if (40 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 40)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001063", "story_v_side_new_1105001.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001063", "story_v_side_new_1105001.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_side_new_1105001", "1105001063", "story_v_side_new_1105001.awb")

						arg_255_1:RecordAudio("1105001063", var_258_6)
						arg_255_1:RecordAudio("1105001063", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001063", "story_v_side_new_1105001.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001063", "story_v_side_new_1105001.awb")
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
	Play1105001064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1105001064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1105001065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.425

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1105001064).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 57 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 57)

				if (57 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 57)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1105001065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1105001065
		arg_263_1.duration_ = 10.1

		local var_263_0 = {
			zh = 7.066,
			ja = 10.1
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1105001066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.95

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_1 = arg_263_1:GetWordFromCfg(1105001065)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 38 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 38)

				if (38 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 38)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001065", "story_v_side_new_1105001.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001065", "story_v_side_new_1105001.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_side_new_1105001", "1105001065", "story_v_side_new_1105001.awb")

						arg_263_1:RecordAudio("1105001065", var_266_6)
						arg_263_1:RecordAudio("1105001065", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001065", "story_v_side_new_1105001.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001065", "story_v_side_new_1105001.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1105001066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1105001066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1105001067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.3

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

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1105001066).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 52 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 52)

				if (52 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 52)) > 0 and var_270_0 < var_270_3 then
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
	Play1105001067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1105001067
		arg_271_1.duration_ = 2.3

		local var_271_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_271_0:Play1105001068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1050ui_story = arg_271_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1050ui_story"].transform.position).z)
				arg_271_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1050ui_story"].transform.localEulerAngles = arg_271_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_271_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1050ui_story"].transform.position).z)
				arg_271_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1050ui_story"].transform.localEulerAngles = arg_271_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1050ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1050ui_story == nil then
				arg_271_1.var_.characterEffect1050ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1050ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1050ui_story then
				arg_271_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_274_4 = 0
			local var_274_5 = 0.125

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(1105001067)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 5 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 5)

				if (5 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 5)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001067", "story_v_side_new_1105001.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001067", "story_v_side_new_1105001.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_side_new_1105001", "1105001067", "story_v_side_new_1105001.awb")

						arg_271_1:RecordAudio("1105001067", var_274_11)
						arg_271_1:RecordAudio("1105001067", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001067", "story_v_side_new_1105001.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001067", "story_v_side_new_1105001.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play1105001068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1105001068
		arg_275_1.duration_ = 4.23

		local var_275_0 = {
			zh = 3.633,
			ja = 4.233
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
				arg_275_0:Play1105001069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1050ui_story = arg_275_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1050ui_story"].transform.position).z)
				arg_275_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1050ui_story"].transform.localEulerAngles = arg_275_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_275_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1050ui_story"].transform.position).z)
				arg_275_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1050ui_story"].transform.localEulerAngles = arg_275_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_278_1 = 0
			local var_278_2 = 0.275

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:GetWordFromCfg(1105001068)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 11 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_4) / 11)

				if (11 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_4) / 11)) > 0 and var_278_2 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001068", "story_v_side_new_1105001.awb") ~= 0 then
					local var_278_7 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001068", "story_v_side_new_1105001.awb") / 1000

					if var_278_7 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_1
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_side_new_1105001", "1105001068", "story_v_side_new_1105001.awb")

						arg_275_1:RecordAudio("1105001068", var_278_8)
						arg_275_1:RecordAudio("1105001068", var_278_8)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001068", "story_v_side_new_1105001.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001068", "story_v_side_new_1105001.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_9 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_9 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_9

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_9 and arg_275_1.time_ < var_278_1 + var_278_9 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play1105001069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1105001069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1105001070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1050ui_story"]) and arg_279_1.var_.characterEffect1050ui_story == nil then
				arg_279_1.var_.characterEffect1050ui_story = arg_279_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1050ui_story"]) then
				if arg_279_1.var_.characterEffect1050ui_story and not isNil(arg_279_1.actors_["1050ui_story"]) then
					arg_279_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1050ui_story"]) and arg_279_1.var_.characterEffect1050ui_story then
				arg_279_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 1.025

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

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1105001069).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 41 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 41)

				if (41 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 41)) > 0 and var_282_2 < var_282_5 then
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
	Play1105001070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1105001070
		arg_283_1.duration_ = 2.3

		local var_283_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1105001071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1050ui_story = arg_283_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1050ui_story"].transform.position).z)
				arg_283_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1050ui_story"].transform.localEulerAngles = arg_283_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_283_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1050ui_story"].transform.position).z)
				arg_283_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1050ui_story"].transform.localEulerAngles = arg_283_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1050ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1050ui_story == nil then
				arg_283_1.var_.characterEffect1050ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1050ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1050ui_story then
				arg_283_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_4 = 0
			local var_286_5 = 0.175

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(1105001070)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 7 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 7)

				if (7 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 7)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001070", "story_v_side_new_1105001.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001070", "story_v_side_new_1105001.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_side_new_1105001", "1105001070", "story_v_side_new_1105001.awb")

						arg_283_1:RecordAudio("1105001070", var_286_11)
						arg_283_1:RecordAudio("1105001070", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001070", "story_v_side_new_1105001.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001070", "story_v_side_new_1105001.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play1105001071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1105001071
		arg_287_1.duration_ = 5.8

		local var_287_0 = {
			zh = 2.933,
			ja = 5.8
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1105001072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.25

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(1105001071)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 10 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 10)

				if (10 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 10)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001071", "story_v_side_new_1105001.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001071", "story_v_side_new_1105001.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_side_new_1105001", "1105001071", "story_v_side_new_1105001.awb")

						arg_287_1:RecordAudio("1105001071", var_290_6)
						arg_287_1:RecordAudio("1105001071", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001071", "story_v_side_new_1105001.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001071", "story_v_side_new_1105001.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1105001072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1105001072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1105001073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1050ui_story"]) and arg_291_1.var_.characterEffect1050ui_story == nil then
				arg_291_1.var_.characterEffect1050ui_story = arg_291_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1050ui_story"]) then
				if arg_291_1.var_.characterEffect1050ui_story and not isNil(arg_291_1.actors_["1050ui_story"]) then
					arg_291_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1050ui_story"]) and arg_291_1.var_.characterEffect1050ui_story then
				arg_291_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.675

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1105001072).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 27 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 27)

				if (27 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 27)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1105001073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1105001073
		arg_295_1.duration_ = 5.7

		local var_295_0 = {
			zh = 5.7,
			ja = 5.333
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1105001074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.65

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(1105001073)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 27 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 27)

				if (27 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 27)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001073", "story_v_side_new_1105001.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001073", "story_v_side_new_1105001.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_side_new_1105001", "1105001073", "story_v_side_new_1105001.awb")

						arg_295_1:RecordAudio("1105001073", var_298_6)
						arg_295_1:RecordAudio("1105001073", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001073", "story_v_side_new_1105001.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001073", "story_v_side_new_1105001.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1105001074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1105001074
		arg_299_1.duration_ = 10.77

		local var_299_0 = {
			zh = 8.766,
			ja = 10.766
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1105001075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if arg_299_1.bgs_.ST59 == nil then
				local var_302_0 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST59")
				var_302_0.name = "ST59"
				var_302_0.transform.parent = arg_299_1.stage_.transform
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_.ST59 = var_302_0
			end

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= 2 + arg_302_0 then
				local var_302_1 = arg_299_1.bgs_.ST59

				arg_299_1.bgs_.ST59.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_2 = var_302_1:GetComponent("SpriteRenderer")

				if var_302_2 and var_302_2.sprite then
					local var_302_3 = 2 * (var_302_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_1.transform.localScale = Vector3.New(var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "ST59" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_4 = 0

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_5 = 2

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_5 then
				local var_302_6 = Color.New(0, 0, 0)

				var_302_6.a = Mathf.Lerp(0, 1, (arg_299_1.time_ - var_302_4) / var_302_5)
				arg_299_1.mask_.color = var_302_6
			end

			if arg_299_1.time_ >= var_302_4 + var_302_5 and arg_299_1.time_ < var_302_4 + var_302_5 + arg_302_0 then
				local var_302_7 = Color.New(0, 0, 0)

				var_302_7.a = 1
				arg_299_1.mask_.color = var_302_7
			end

			local var_302_8 = 2

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_9 = 2

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_9 then
				local var_302_10 = Color.New(0, 0, 0)

				var_302_10.a = Mathf.Lerp(1, 0, (arg_299_1.time_ - var_302_8) / var_302_9)
				arg_299_1.mask_.color = var_302_10
			end

			if arg_299_1.time_ >= var_302_8 + var_302_9 and arg_299_1.time_ < var_302_8 + var_302_9 + arg_302_0 then
				local var_302_11 = Color.New(0, 0, 0)

				arg_299_1.mask_.enabled = false
				var_302_11.a = 0
				arg_299_1.mask_.color = var_302_11
			end

			local var_302_12 = arg_299_1.actors_["1050ui_story"].transform

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= 2 + arg_302_0 then
				arg_299_1.var_.moveOldPos1050ui_story = var_302_12.localPosition
			end

			local var_302_13 = 0.001

			if 2 <= arg_299_1.time_ and arg_299_1.time_ < 2 + var_302_13 then
				var_302_12.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 2) / var_302_13)
				var_302_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_12.position).x, (manager.ui.mainCamera.transform.position - var_302_12.position).y, (manager.ui.mainCamera.transform.position - var_302_12.position).z)
				var_302_12.localEulerAngles.z = 0
				var_302_12.localEulerAngles.x = 0
				var_302_12.localEulerAngles = var_302_12.localEulerAngles
			end

			if arg_299_1.time_ >= 2 + var_302_13 and arg_299_1.time_ < 2 + var_302_13 + arg_302_0 then
				var_302_12.localPosition = Vector3.New(0, 100, 0)
				var_302_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_12.position).x, (manager.ui.mainCamera.transform.position - var_302_12.position).y, (manager.ui.mainCamera.transform.position - var_302_12.position).z)
				var_302_12.localEulerAngles.z = 0
				var_302_12.localEulerAngles.x = 0
				var_302_12.localEulerAngles = var_302_12.localEulerAngles
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_14 = 4
			local var_302_15 = 0.45

			if 4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_16 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_16:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_17 = arg_299_1:GetWordFromCfg(1105001074)
				local var_302_18 = arg_299_1:FormatText(var_302_17.content)

				arg_299_1.text_.text = var_302_18

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 18 <= 0 and var_302_15 or var_302_15 * (utf8.len(var_302_18) / 18)

				if (18 <= 0 and var_302_15 or var_302_15 * (utf8.len(var_302_18) / 18)) > 0 and var_302_15 < var_302_20 then
					arg_299_1.talkMaxDuration = var_302_20
					var_302_14 = var_302_14 + 0.3

					if var_302_20 + var_302_14 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_14
					end
				end

				arg_299_1.text_.text = var_302_18
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001074", "story_v_side_new_1105001.awb") ~= 0 then
					local var_302_21 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001074", "story_v_side_new_1105001.awb") / 1000

					if var_302_21 + var_302_14 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_21 + var_302_14
					end

					if var_302_17.prefab_name ~= "" and arg_299_1.actors_[var_302_17.prefab_name] ~= nil then
						local var_302_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_17.prefab_name].transform, "story_v_side_new_1105001", "1105001074", "story_v_side_new_1105001.awb")

						arg_299_1:RecordAudio("1105001074", var_302_22)
						arg_299_1:RecordAudio("1105001074", var_302_22)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001074", "story_v_side_new_1105001.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001074", "story_v_side_new_1105001.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_23 = var_302_14 + 0.3
			local var_302_24 = math.max(var_302_15, arg_299_1.talkMaxDuration)

			if var_302_14 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_23 + var_302_24 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_23) / var_302_24

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_23 + var_302_24 and arg_299_1.time_ < var_302_23 + var_302_24 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play1105001075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1105001075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1105001076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.575

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1105001075).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 23 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 23)

				if (23 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 23)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1105001076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1105001076
		arg_309_1.duration_ = 11.6

		local var_309_0 = {
			zh = 11.433,
			ja = 11.6
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
				arg_309_0:Play1105001077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1050ui_story = arg_309_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1050ui_story"].transform.position).z)
				arg_309_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1050ui_story"].transform.localEulerAngles = arg_309_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_309_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1050ui_story"].transform.position).z)
				arg_309_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1050ui_story"].transform.localEulerAngles = arg_309_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1050ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1050ui_story == nil then
				arg_309_1.var_.characterEffect1050ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1050ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1050ui_story then
				arg_309_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_312_4 = 0
			local var_312_5 = 1.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(1105001076)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 53 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 53)

				if (53 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 53)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001076", "story_v_side_new_1105001.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001076", "story_v_side_new_1105001.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_side_new_1105001", "1105001076", "story_v_side_new_1105001.awb")

						arg_309_1:RecordAudio("1105001076", var_312_11)
						arg_309_1:RecordAudio("1105001076", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001076", "story_v_side_new_1105001.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001076", "story_v_side_new_1105001.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play1105001077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1105001077
		arg_313_1.duration_ = 9.6

		local var_313_0 = {
			zh = 9.6,
			ja = 5.933
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1105001078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1050ui_story = arg_313_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1050ui_story"].transform.position).z)
				arg_313_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1050ui_story"].transform.localEulerAngles = arg_313_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_313_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1050ui_story"].transform.position).z)
				arg_313_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1050ui_story"].transform.localEulerAngles = arg_313_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1050ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1050ui_story == nil then
				arg_313_1.var_.characterEffect1050ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1050ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1050ui_story then
				arg_313_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action454")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= 2 + arg_316_0 then
				arg_313_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_316_4 = 0
			local var_316_5 = 1.025

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(1105001077)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 41 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 41)

				if (41 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 41)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001077", "story_v_side_new_1105001.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001077", "story_v_side_new_1105001.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_new_1105001", "1105001077", "story_v_side_new_1105001.awb")

						arg_313_1:RecordAudio("1105001077", var_316_11)
						arg_313_1:RecordAudio("1105001077", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001077", "story_v_side_new_1105001.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001077", "story_v_side_new_1105001.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play1105001078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1105001078
		arg_317_1.duration_ = 8.5

		local var_317_0 = {
			zh = 5.433,
			ja = 8.5
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1105001079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1050ui_story = arg_317_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1050ui_story"].transform.position).z)
				arg_317_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1050ui_story"].transform.localEulerAngles = arg_317_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_317_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1050ui_story"].transform.position).z)
				arg_317_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1050ui_story"].transform.localEulerAngles = arg_317_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1050ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1050ui_story == nil then
				arg_317_1.var_.characterEffect1050ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1050ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1050ui_story then
				arg_317_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_320_4 = 0
			local var_320_5 = 0.35

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(1105001078)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 14 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 14)

				if (14 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 14)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001078", "story_v_side_new_1105001.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001078", "story_v_side_new_1105001.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_side_new_1105001", "1105001078", "story_v_side_new_1105001.awb")

						arg_317_1:RecordAudio("1105001078", var_320_11)
						arg_317_1:RecordAudio("1105001078", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001078", "story_v_side_new_1105001.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001078", "story_v_side_new_1105001.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play1105001079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1105001079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1105001080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1050ui_story"]) and arg_321_1.var_.characterEffect1050ui_story == nil then
				arg_321_1.var_.characterEffect1050ui_story = arg_321_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1050ui_story"]) then
				if arg_321_1.var_.characterEffect1050ui_story and not isNil(arg_321_1.actors_["1050ui_story"]) then
					arg_321_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1050ui_story"]) and arg_321_1.var_.characterEffect1050ui_story then
				arg_321_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 1.325

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(1105001079).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 53 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 53)

				if (53 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 53)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1105001080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1105001080
		arg_325_1.duration_ = 4.03

		local var_325_0 = {
			zh = 4.033,
			ja = 3.4
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1105001081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.4

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(1105001080)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 16 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 16)

				if (16 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 16)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001080", "story_v_side_new_1105001.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001080", "story_v_side_new_1105001.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_side_new_1105001", "1105001080", "story_v_side_new_1105001.awb")

						arg_325_1:RecordAudio("1105001080", var_328_6)
						arg_325_1:RecordAudio("1105001080", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001080", "story_v_side_new_1105001.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001080", "story_v_side_new_1105001.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1105001081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1105001081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1105001082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 1.175

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1105001081).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 47 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 47)

				if (47 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 47)) > 0 and var_332_0 < var_332_3 then
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
	Play1105001082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1105001082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1105001083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.55

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

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1105001082).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 22 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 22)

				if (22 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 22)) > 0 and var_336_0 < var_336_3 then
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
	Play1105001083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1105001083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1105001084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.875

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1105001083).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 35 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 35)

				if (35 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 35)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1105001084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1105001084
		arg_341_1.duration_ = 9.9

		local var_341_0 = {
			zh = 5.133,
			ja = 9.9
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1105001085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1050ui_story = arg_341_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1050ui_story"].transform.position).z)
				arg_341_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1050ui_story"].transform.localEulerAngles = arg_341_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_341_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1050ui_story"].transform.position).z)
				arg_341_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1050ui_story"].transform.localEulerAngles = arg_341_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1050ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1050ui_story == nil then
				arg_341_1.var_.characterEffect1050ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1050ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1050ui_story then
				arg_341_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_344_4 = 0
			local var_344_5 = 0.5

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(1105001084)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 20 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 20)

				if (20 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 20)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001084", "story_v_side_new_1105001.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001084", "story_v_side_new_1105001.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_side_new_1105001", "1105001084", "story_v_side_new_1105001.awb")

						arg_341_1:RecordAudio("1105001084", var_344_11)
						arg_341_1:RecordAudio("1105001084", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001084", "story_v_side_new_1105001.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001084", "story_v_side_new_1105001.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play1105001085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1105001085
		arg_345_1.duration_ = 10.23

		local var_345_0 = {
			zh = 4.466,
			ja = 10.233
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1105001086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_0 = 0
			local var_348_1 = 0.425

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_2 = arg_345_1:GetWordFromCfg(1105001085)
				local var_348_3 = arg_345_1:FormatText(var_348_2.content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 17 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_3) / 17)

				if (17 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_3) / 17)) > 0 and var_348_1 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001085", "story_v_side_new_1105001.awb") ~= 0 then
					local var_348_6 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001085", "story_v_side_new_1105001.awb") / 1000

					if var_348_6 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_0
					end

					if var_348_2.prefab_name ~= "" and arg_345_1.actors_[var_348_2.prefab_name] ~= nil then
						local var_348_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_2.prefab_name].transform, "story_v_side_new_1105001", "1105001085", "story_v_side_new_1105001.awb")

						arg_345_1:RecordAudio("1105001085", var_348_7)
						arg_345_1:RecordAudio("1105001085", var_348_7)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001085", "story_v_side_new_1105001.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001085", "story_v_side_new_1105001.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_8 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_8 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_8

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_8 and arg_345_1.time_ < var_348_0 + var_348_8 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1105001086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1105001086
		arg_349_1.duration_ = 5.63

		local var_349_0 = {
			zh = 5.3,
			ja = 5.633
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
				arg_349_0:Play1105001087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1050ui_story"]) and arg_349_1.var_.characterEffect1050ui_story == nil then
				arg_349_1.var_.characterEffect1050ui_story = arg_349_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1050ui_story"]) then
				if arg_349_1.var_.characterEffect1050ui_story and not isNil(arg_349_1.actors_["1050ui_story"]) then
					arg_349_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1050ui_story"]) and arg_349_1.var_.characterEffect1050ui_story then
				arg_349_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 0.675

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(1105001086)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_6 = 27 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_4) / 27)

				if (27 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_4) / 27)) > 0 and var_352_2 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001086", "story_v_side_new_1105001.awb") ~= 0 then
					local var_352_7 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001086", "story_v_side_new_1105001.awb") / 1000

					if var_352_7 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_1
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_side_new_1105001", "1105001086", "story_v_side_new_1105001.awb")

						arg_349_1:RecordAudio("1105001086", var_352_8)
						arg_349_1:RecordAudio("1105001086", var_352_8)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001086", "story_v_side_new_1105001.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001086", "story_v_side_new_1105001.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_9 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_9 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_9

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_9 and arg_349_1.time_ < var_352_1 + var_352_9 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1105001087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1105001087
		arg_353_1.duration_ = 4.6

		local var_353_0 = {
			zh = 4.1,
			ja = 4.6
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1105001088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:GetWordFromCfg(1105001087)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 11 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 11)

				if (11 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 11)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001087", "story_v_side_new_1105001.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001087", "story_v_side_new_1105001.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_side_new_1105001", "1105001087", "story_v_side_new_1105001.awb")

						arg_353_1:RecordAudio("1105001087", var_356_6)
						arg_353_1:RecordAudio("1105001087", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001087", "story_v_side_new_1105001.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001087", "story_v_side_new_1105001.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1105001088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1105001088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1105001089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.225

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(1105001088).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 49 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 49)

				if (49 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 49)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1105001089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1105001089
		arg_361_1.duration_ = 4.6

		local var_361_0 = {
			zh = 4.6,
			ja = 1.999999999999
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1105001090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1050ui_story = arg_361_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1050ui_story"].transform.position).z)
				arg_361_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1050ui_story"].transform.localEulerAngles = arg_361_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_361_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1050ui_story"].transform.position).z)
				arg_361_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1050ui_story"].transform.localEulerAngles = arg_361_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_364_1 = arg_361_1.actors_["1050ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1050ui_story == nil then
				arg_361_1.var_.characterEffect1050ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect1050ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1050ui_story then
				arg_361_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_2")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_364_4 = 0
			local var_364_5 = 0.275

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_6 = arg_361_1:GetWordFromCfg(1105001089)
				local var_364_7 = arg_361_1:FormatText(var_364_6.content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 11 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 11)

				if (11 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 11)) > 0 and var_364_5 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_4
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001089", "story_v_side_new_1105001.awb") ~= 0 then
					local var_364_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001089", "story_v_side_new_1105001.awb") / 1000

					if var_364_10 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_4
					end

					if var_364_6.prefab_name ~= "" and arg_361_1.actors_[var_364_6.prefab_name] ~= nil then
						local var_364_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_6.prefab_name].transform, "story_v_side_new_1105001", "1105001089", "story_v_side_new_1105001.awb")

						arg_361_1:RecordAudio("1105001089", var_364_11)
						arg_361_1:RecordAudio("1105001089", var_364_11)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001089", "story_v_side_new_1105001.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001089", "story_v_side_new_1105001.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_12 = math.max(var_364_5, arg_361_1.talkMaxDuration)

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_12 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_4) / var_364_12

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_4 + var_364_12 and arg_361_1.time_ < var_364_4 + var_364_12 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play1105001090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1105001090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1105001091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1050ui_story"]) and arg_365_1.var_.characterEffect1050ui_story == nil then
				arg_365_1.var_.characterEffect1050ui_story = arg_365_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1050ui_story"]) then
				if arg_365_1.var_.characterEffect1050ui_story and not isNil(arg_365_1.actors_["1050ui_story"]) then
					arg_365_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_0)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1050ui_story"]) and arg_365_1.var_.characterEffect1050ui_story then
				arg_365_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_368_1 = 0
			local var_368_2 = 0.65

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1105001090).content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 26 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 26)

				if (26 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 26)) > 0 and var_368_2 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_1
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_6 = math.max(var_368_2, arg_365_1.talkMaxDuration)

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_6 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_1) / var_368_6

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_1 + var_368_6 and arg_365_1.time_ < var_368_1 + var_368_6 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1105001091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1105001091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1105001092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.95

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1105001091).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 38 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 38)

				if (38 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 38)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1105001092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1105001092
		arg_373_1.duration_ = 8.37

		local var_373_0 = {
			zh = 8.366,
			ja = 4.166
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1105001093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1050ui_story = arg_373_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1050ui_story"].transform.position).z)
				arg_373_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1050ui_story"].transform.localEulerAngles = arg_373_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_373_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1050ui_story"].transform.position).z)
				arg_373_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1050ui_story"].transform.localEulerAngles = arg_373_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["1050ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1050ui_story == nil then
				arg_373_1.var_.characterEffect1050ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect1050ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1050ui_story then
				arg_373_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_376_4 = 0
			local var_376_5 = 0.975

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_6 = arg_373_1:GetWordFromCfg(1105001092)
				local var_376_7 = arg_373_1:FormatText(var_376_6.content)

				arg_373_1.text_.text = var_376_7

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_9 = 39 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 39)

				if (39 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 39)) > 0 and var_376_5 < var_376_9 then
					arg_373_1.talkMaxDuration = var_376_9

					if var_376_9 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_9 + var_376_4
					end
				end

				arg_373_1.text_.text = var_376_7
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001092", "story_v_side_new_1105001.awb") ~= 0 then
					local var_376_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001092", "story_v_side_new_1105001.awb") / 1000

					if var_376_10 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_4
					end

					if var_376_6.prefab_name ~= "" and arg_373_1.actors_[var_376_6.prefab_name] ~= nil then
						local var_376_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_6.prefab_name].transform, "story_v_side_new_1105001", "1105001092", "story_v_side_new_1105001.awb")

						arg_373_1:RecordAudio("1105001092", var_376_11)
						arg_373_1:RecordAudio("1105001092", var_376_11)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001092", "story_v_side_new_1105001.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001092", "story_v_side_new_1105001.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_12 = math.max(var_376_5, arg_373_1.talkMaxDuration)

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_12 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_4) / var_376_12

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_4 + var_376_12 and arg_373_1.time_ < var_376_4 + var_376_12 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play1105001093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1105001093
		arg_377_1.duration_ = 9.77

		local var_377_0 = {
			zh = 9.766,
			ja = 8.666
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
				arg_377_0:Play1105001094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1050ui_story"]) and arg_377_1.var_.characterEffect1050ui_story == nil then
				arg_377_1.var_.characterEffect1050ui_story = arg_377_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1050ui_story"]) then
				if arg_377_1.var_.characterEffect1050ui_story and not isNil(arg_377_1.actors_["1050ui_story"]) then
					arg_377_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1050ui_story"]) and arg_377_1.var_.characterEffect1050ui_story then
				arg_377_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 1.175

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[631].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(1105001093)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_6 = 47 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_4) / 47)

				if (47 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_4) / 47)) > 0 and var_380_2 < var_380_6 then
					arg_377_1.talkMaxDuration = var_380_6

					if var_380_6 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001093", "story_v_side_new_1105001.awb") ~= 0 then
					local var_380_7 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001093", "story_v_side_new_1105001.awb") / 1000

					if var_380_7 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_1
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_side_new_1105001", "1105001093", "story_v_side_new_1105001.awb")

						arg_377_1:RecordAudio("1105001093", var_380_8)
						arg_377_1:RecordAudio("1105001093", var_380_8)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001093", "story_v_side_new_1105001.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001093", "story_v_side_new_1105001.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_9 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_9 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_9

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_9 and arg_377_1.time_ < var_380_1 + var_380_9 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1105001094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1105001094
		arg_381_1.duration_ = 4.5

		local var_381_0 = {
			zh = 4.5,
			ja = 4.233
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
				arg_381_0:Play1105001095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1050ui_story = arg_381_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1050ui_story"].transform.position).z)
				arg_381_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1050ui_story"].transform.localEulerAngles = arg_381_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_381_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1050ui_story"].transform.position).z)
				arg_381_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1050ui_story"].transform.localEulerAngles = arg_381_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1050ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1050ui_story == nil then
				arg_381_1.var_.characterEffect1050ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1050ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1050ui_story then
				arg_381_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_384_4 = 0
			local var_384_5 = 0.25

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(1105001094)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 10 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 10)

				if (10 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 10)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001094", "story_v_side_new_1105001.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001094", "story_v_side_new_1105001.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_side_new_1105001", "1105001094", "story_v_side_new_1105001.awb")

						arg_381_1:RecordAudio("1105001094", var_384_11)
						arg_381_1:RecordAudio("1105001094", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001094", "story_v_side_new_1105001.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001094", "story_v_side_new_1105001.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_12 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_12 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_12

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_12 and arg_381_1.time_ < var_384_4 + var_384_12 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play1105001095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1105001095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1105001096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1050ui_story"]) and arg_385_1.var_.characterEffect1050ui_story == nil then
				arg_385_1.var_.characterEffect1050ui_story = arg_385_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1050ui_story"]) then
				if arg_385_1.var_.characterEffect1050ui_story and not isNil(arg_385_1.actors_["1050ui_story"]) then
					arg_385_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1050ui_story"]) and arg_385_1.var_.characterEffect1050ui_story then
				arg_385_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.85

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1105001095).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 34 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 34)

				if (34 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 34)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1105001096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1105001096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1105001097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1050ui_story = arg_389_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1050ui_story"].transform.position).z)
				arg_389_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1050ui_story"].transform.localEulerAngles = arg_389_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1050ui_story"].transform.position).z)
				arg_389_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1050ui_story"].transform.localEulerAngles = arg_389_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_392_1 = 0
			local var_392_2 = 0.725

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(1105001096).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 29 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 29)

				if (29 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 29)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play1105001097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1105001097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1105001098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.975

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1105001097).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 40 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 40)

				if (40 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 40)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1105001098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1105001098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1105001099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.7

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1105001098).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 28 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 28)

				if (28 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 28)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1105001099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1105001099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1105001100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.475

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1105001099).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 19 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 19)

				if (19 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 19)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1105001100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1105001100
		arg_405_1.duration_ = 6.57

		local var_405_0 = {
			zh = 6.566,
			ja = 5
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1105001101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1050ui_story = arg_405_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1050ui_story"].transform.position).z)
				arg_405_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1050ui_story"].transform.localEulerAngles = arg_405_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_405_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1050ui_story"].transform.position).z)
				arg_405_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1050ui_story"].transform.localEulerAngles = arg_405_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1050ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1050ui_story == nil then
				arg_405_1.var_.characterEffect1050ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1050ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1050ui_story then
				arg_405_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_408_4 = 0
			local var_408_5 = 0.775

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(1105001100)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 31 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 31)

				if (31 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 31)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001100", "story_v_side_new_1105001.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001100", "story_v_side_new_1105001.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_side_new_1105001", "1105001100", "story_v_side_new_1105001.awb")

						arg_405_1:RecordAudio("1105001100", var_408_11)
						arg_405_1:RecordAudio("1105001100", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001100", "story_v_side_new_1105001.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001100", "story_v_side_new_1105001.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play1105001101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1105001101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1105001102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1050ui_story"]) and arg_409_1.var_.characterEffect1050ui_story == nil then
				arg_409_1.var_.characterEffect1050ui_story = arg_409_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1050ui_story"]) then
				if arg_409_1.var_.characterEffect1050ui_story and not isNil(arg_409_1.actors_["1050ui_story"]) then
					arg_409_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1050ui_story"]) and arg_409_1.var_.characterEffect1050ui_story then
				arg_409_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.25

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1105001101).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 10 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 10)

				if (10 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 10)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1105001102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1105001102
		arg_413_1.duration_ = 11.2

		local var_413_0 = {
			zh = 11.2,
			ja = 7.133
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1105001103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1050ui_story = arg_413_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1050ui_story"].transform.position).z)
				arg_413_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1050ui_story"].transform.localEulerAngles = arg_413_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_413_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1050ui_story"].transform.position).z)
				arg_413_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1050ui_story"].transform.localEulerAngles = arg_413_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1050ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1050ui_story == nil then
				arg_413_1.var_.characterEffect1050ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1050ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1050ui_story then
				arg_413_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_416_4 = 0
			local var_416_5 = 1.125

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(1105001102)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 45 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 45)

				if (45 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 45)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001102", "story_v_side_new_1105001.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001102", "story_v_side_new_1105001.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_side_new_1105001", "1105001102", "story_v_side_new_1105001.awb")

						arg_413_1:RecordAudio("1105001102", var_416_11)
						arg_413_1:RecordAudio("1105001102", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001102", "story_v_side_new_1105001.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001102", "story_v_side_new_1105001.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play1105001103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1105001103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1105001104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1050ui_story"]) and arg_417_1.var_.characterEffect1050ui_story == nil then
				arg_417_1.var_.characterEffect1050ui_story = arg_417_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1050ui_story"]) then
				if arg_417_1.var_.characterEffect1050ui_story and not isNil(arg_417_1.actors_["1050ui_story"]) then
					arg_417_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1050ui_story"]) and arg_417_1.var_.characterEffect1050ui_story then
				arg_417_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_420_1 = arg_417_1.actors_["1050ui_story"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1050ui_story = var_420_1.localPosition
			end

			local var_420_2 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 then
				var_420_1.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_417_1.time_ - 0) / var_420_2)
				var_420_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_420_1.position).x, (manager.ui.mainCamera.transform.position - var_420_1.position).y, (manager.ui.mainCamera.transform.position - var_420_1.position).z)
				var_420_1.localEulerAngles.z = 0
				var_420_1.localEulerAngles.x = 0
				var_420_1.localEulerAngles = var_420_1.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 then
				var_420_1.localPosition = Vector3.New(0, 100, 0)
				var_420_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_420_1.position).x, (manager.ui.mainCamera.transform.position - var_420_1.position).y, (manager.ui.mainCamera.transform.position - var_420_1.position).z)
				var_420_1.localEulerAngles.z = 0
				var_420_1.localEulerAngles.x = 0
				var_420_1.localEulerAngles = var_420_1.localEulerAngles
			end

			local var_420_3 = 0
			local var_420_4 = 1.05

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_5 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1105001103).content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 42 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 42)

				if (42 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 42)) > 0 and var_420_4 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_3 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_3
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_4, arg_417_1.talkMaxDuration)

			if var_420_3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_3 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_3) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_3 + var_420_8 and arg_417_1.time_ < var_420_3 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
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

		arg_417_1:InitPlayNodeList()
	end,
	Play1105001104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1105001104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1105001105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.625

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1105001104).content)

				arg_421_1.text_.text = var_424_1

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_3 = 25 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 25)

				if (25 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 25)) > 0 and var_424_0 < var_424_3 then
					arg_421_1.talkMaxDuration = var_424_3

					if var_424_3 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_3 + 0
					end
				end

				arg_421_1.text_.text = var_424_1
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_4 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_4 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_4

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_4 and arg_421_1.time_ < 0 + var_424_4 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1105001105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1105001105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1105001106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.55

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1105001105).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 23 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 23)

				if (23 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 23)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1105001106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1105001106
		arg_429_1.duration_ = 8

		local var_429_0 = {
			zh = 6.4,
			ja = 8
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1105001107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if arg_429_1.bgs_.ST06b == nil then
				local var_432_0 = Object.Instantiate(arg_429_1.paintGo_)

				var_432_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06b")
				var_432_0.name = "ST06b"
				var_432_0.transform.parent = arg_429_1.stage_.transform
				var_432_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.bgs_.ST06b = var_432_0
			end

			if 2 < arg_429_1.time_ and arg_429_1.time_ <= 2 + arg_432_0 then
				local var_432_1 = arg_429_1.bgs_.ST06b

				arg_429_1.bgs_.ST06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_432_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_2 = var_432_1:GetComponent("SpriteRenderer")

				if var_432_2 and var_432_2.sprite then
					local var_432_3 = 2 * (var_432_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_432_1.transform.localScale = Vector3.New(var_432_3 / var_432_2.sprite.bounds.size.y < var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x and var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x or var_432_3 / var_432_2.sprite.bounds.size.y, var_432_3 / var_432_2.sprite.bounds.size.y < var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x and var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x or var_432_3 / var_432_2.sprite.bounds.size.y, 0)
				end

				for iter_432_0, iter_432_1 in pairs(arg_429_1.bgs_) do
					if iter_432_0 ~= "ST06b" then
						iter_432_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_432_4 = 0

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_5 = 2

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_5 then
				local var_432_6 = Color.New(0, 0, 0)

				var_432_6.a = Mathf.Lerp(0, 1, (arg_429_1.time_ - var_432_4) / var_432_5)
				arg_429_1.mask_.color = var_432_6
			end

			if arg_429_1.time_ >= var_432_4 + var_432_5 and arg_429_1.time_ < var_432_4 + var_432_5 + arg_432_0 then
				local var_432_7 = Color.New(0, 0, 0)

				var_432_7.a = 1
				arg_429_1.mask_.color = var_432_7
			end

			local var_432_8 = 2

			if 2 < arg_429_1.time_ and arg_429_1.time_ <= var_432_8 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_9 = 2

			if var_432_8 <= arg_429_1.time_ and arg_429_1.time_ < var_432_8 + var_432_9 then
				local var_432_10 = Color.New(0, 0, 0)

				var_432_10.a = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_8) / var_432_9)
				arg_429_1.mask_.color = var_432_10
			end

			if arg_429_1.time_ >= var_432_8 + var_432_9 and arg_429_1.time_ < var_432_8 + var_432_9 + arg_432_0 then
				local var_432_11 = Color.New(0, 0, 0)

				arg_429_1.mask_.enabled = false
				var_432_11.a = 0
				arg_429_1.mask_.color = var_432_11
			end

			local var_432_12 = arg_429_1.actors_["1050ui_story"].transform

			if 4 < arg_429_1.time_ and arg_429_1.time_ <= 4 + arg_432_0 then
				arg_429_1.var_.moveOldPos1050ui_story = var_432_12.localPosition
			end

			local var_432_13 = 0.001

			if 4 <= arg_429_1.time_ and arg_429_1.time_ < 4 + var_432_13 then
				var_432_12.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_429_1.time_ - 4) / var_432_13)
				var_432_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_12.position).x, (manager.ui.mainCamera.transform.position - var_432_12.position).y, (manager.ui.mainCamera.transform.position - var_432_12.position).z)
				var_432_12.localEulerAngles.z = 0
				var_432_12.localEulerAngles.x = 0
				var_432_12.localEulerAngles = var_432_12.localEulerAngles
			end

			if arg_429_1.time_ >= 4 + var_432_13 and arg_429_1.time_ < 4 + var_432_13 + arg_432_0 then
				var_432_12.localPosition = Vector3.New(0, -1, -6.1)
				var_432_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_12.position).x, (manager.ui.mainCamera.transform.position - var_432_12.position).y, (manager.ui.mainCamera.transform.position - var_432_12.position).z)
				var_432_12.localEulerAngles.z = 0
				var_432_12.localEulerAngles.x = 0
				var_432_12.localEulerAngles = var_432_12.localEulerAngles
			end

			local var_432_14 = arg_429_1.actors_["1050ui_story"]

			if 4 < arg_429_1.time_ and arg_429_1.time_ <= 4 + arg_432_0 and not isNil(var_432_14) and arg_429_1.var_.characterEffect1050ui_story == nil then
				arg_429_1.var_.characterEffect1050ui_story = var_432_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_15 = 0.200000002980232

			if 4 <= arg_429_1.time_ and arg_429_1.time_ < 4 + var_432_15 and not isNil(var_432_14) then
				if arg_429_1.var_.characterEffect1050ui_story and not isNil(var_432_14) then
					arg_429_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 4 + var_432_15 and arg_429_1.time_ < 4 + var_432_15 + arg_432_0 and not isNil(var_432_14) and arg_429_1.var_.characterEffect1050ui_story then
				arg_429_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 4 < arg_429_1.time_ and arg_429_1.time_ <= 4 + arg_432_0 then
				arg_429_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 4 < arg_429_1.time_ and arg_429_1.time_ <= 4 + arg_432_0 then
				arg_429_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_432_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_429_1.bgmTxt_.text ~= var_432_19 and arg_429_1.bgmTxt_.text ~= "" then
						if arg_429_1.bgmTxt2_.text ~= "" then
							arg_429_1.bgmTxt_.text = arg_429_1.bgmTxt2_.text
						end

						arg_429_1.bgmTxt2_.text = var_432_19

						arg_429_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_429_1.bgmTxt_.text = var_432_19
						arg_429_1.bgmTxt2_.text = var_432_19
					end

					if arg_429_1.bgmTimer then
						arg_429_1.bgmTimer:Stop()

						arg_429_1.bgmTimer = nil
					end

					if arg_429_1.settingData.show_music_name == 1 then
						arg_429_1.musicController:SetSelectedState("show")
						arg_429_1.musicAnimator_:Play("open", 0, 0)

						if arg_429_1.settingData.music_time ~= 0 then
							arg_429_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_429_1.settingData.music_time), function()
								if arg_429_1 == nil or isNil(arg_429_1.bgmTxt_) then
									return
								end

								arg_429_1.musicController:SetSelectedState("hide")
								arg_429_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_429_1.time_ and arg_429_1.time_ <= 0.266666666666667 + arg_432_0 then
				arg_429_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_432_22 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_429_1.bgmTxt_.text ~= var_432_22 and arg_429_1.bgmTxt_.text ~= "" then
						if arg_429_1.bgmTxt2_.text ~= "" then
							arg_429_1.bgmTxt_.text = arg_429_1.bgmTxt2_.text
						end

						arg_429_1.bgmTxt2_.text = var_432_22

						arg_429_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_429_1.bgmTxt_.text = var_432_22
						arg_429_1.bgmTxt2_.text = var_432_22
					end

					if arg_429_1.bgmTimer then
						arg_429_1.bgmTimer:Stop()

						arg_429_1.bgmTimer = nil
					end

					if arg_429_1.settingData.show_music_name == 1 then
						arg_429_1.musicController:SetSelectedState("show")
						arg_429_1.musicAnimator_:Play("open", 0, 0)

						if arg_429_1.settingData.music_time ~= 0 then
							arg_429_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_429_1.settingData.music_time), function()
								if arg_429_1 == nil or isNil(arg_429_1.bgmTxt_) then
									return
								end

								arg_429_1.musicController:SetSelectedState("hide")
								arg_429_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_429_1.frameCnt_ <= 1 then
				arg_429_1.dialog_:SetActive(false)
			end

			local var_432_23 = 4
			local var_432_24 = 0.2

			if 4 < arg_429_1.time_ and arg_429_1.time_ <= var_432_23 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_25 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_25:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_429_1.dialogCg_.alpha = arg_435_0
				end))
				var_432_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_26 = arg_429_1:GetWordFromCfg(1105001106)
				local var_432_27 = arg_429_1:FormatText(var_432_26.content)

				arg_429_1.text_.text = var_432_27

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_29 = 8 <= 0 and var_432_24 or var_432_24 * (utf8.len(var_432_27) / 8)

				if (8 <= 0 and var_432_24 or var_432_24 * (utf8.len(var_432_27) / 8)) > 0 and var_432_24 < var_432_29 then
					arg_429_1.talkMaxDuration = var_432_29
					var_432_23 = var_432_23 + 0.3

					if var_432_29 + var_432_23 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_29 + var_432_23
					end
				end

				arg_429_1.text_.text = var_432_27
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001106", "story_v_side_new_1105001.awb") ~= 0 then
					local var_432_30 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001106", "story_v_side_new_1105001.awb") / 1000

					if var_432_30 + var_432_23 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_30 + var_432_23
					end

					if var_432_26.prefab_name ~= "" and arg_429_1.actors_[var_432_26.prefab_name] ~= nil then
						local var_432_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_26.prefab_name].transform, "story_v_side_new_1105001", "1105001106", "story_v_side_new_1105001.awb")

						arg_429_1:RecordAudio("1105001106", var_432_31)
						arg_429_1:RecordAudio("1105001106", var_432_31)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001106", "story_v_side_new_1105001.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001106", "story_v_side_new_1105001.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_32 = var_432_23 + 0.3
			local var_432_33 = math.max(var_432_24, arg_429_1.talkMaxDuration)

			if var_432_23 + 0.3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_32 + var_432_33 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_32) / var_432_33

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_32 + var_432_33 and arg_429_1.time_ < var_432_32 + var_432_33 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play1105001107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1105001107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1105001108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1050ui_story"]) and arg_437_1.var_.characterEffect1050ui_story == nil then
				arg_437_1.var_.characterEffect1050ui_story = arg_437_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1050ui_story"]) then
				if arg_437_1.var_.characterEffect1050ui_story and not isNil(arg_437_1.actors_["1050ui_story"]) then
					arg_437_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1050ui_story"]) and arg_437_1.var_.characterEffect1050ui_story then
				arg_437_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.925

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1105001107).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 38 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 38)

				if (38 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 38)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1105001108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1105001108
		arg_441_1.duration_ = 6.27

		local var_441_0 = {
			zh = 6.266,
			ja = 5.466
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1105001109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1050ui_story = arg_441_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1050ui_story"].transform.position).z)
				arg_441_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1050ui_story"].transform.localEulerAngles = arg_441_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_441_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1050ui_story"].transform.position).z)
				arg_441_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1050ui_story"].transform.localEulerAngles = arg_441_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["1050ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1050ui_story == nil then
				arg_441_1.var_.characterEffect1050ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect1050ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1050ui_story then
				arg_441_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_444_4 = 0
			local var_444_5 = 0.625

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_6 = arg_441_1:GetWordFromCfg(1105001108)
				local var_444_7 = arg_441_1:FormatText(var_444_6.content)

				arg_441_1.text_.text = var_444_7

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_9 = 26 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 26)

				if (26 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 26)) > 0 and var_444_5 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_4
					end
				end

				arg_441_1.text_.text = var_444_7
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001108", "story_v_side_new_1105001.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001108", "story_v_side_new_1105001.awb") / 1000

					if var_444_10 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_4
					end

					if var_444_6.prefab_name ~= "" and arg_441_1.actors_[var_444_6.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_6.prefab_name].transform, "story_v_side_new_1105001", "1105001108", "story_v_side_new_1105001.awb")

						arg_441_1:RecordAudio("1105001108", var_444_11)
						arg_441_1:RecordAudio("1105001108", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001108", "story_v_side_new_1105001.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001108", "story_v_side_new_1105001.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_5, arg_441_1.talkMaxDuration)

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_4) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_4 + var_444_12 and arg_441_1.time_ < var_444_4 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
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

		arg_441_1:InitPlayNodeList()
	end,
	Play1105001109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1105001109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1105001110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1050ui_story"]) and arg_445_1.var_.characterEffect1050ui_story == nil then
				arg_445_1.var_.characterEffect1050ui_story = arg_445_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1050ui_story"]) then
				if arg_445_1.var_.characterEffect1050ui_story and not isNil(arg_445_1.actors_["1050ui_story"]) then
					arg_445_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1050ui_story"]) and arg_445_1.var_.characterEffect1050ui_story then
				arg_445_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 1.175

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1105001109).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 47 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 47)

				if (47 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 47)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1105001110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1105001110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1105001111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.75

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1105001110).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 30 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 30)

				if (30 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 30)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1105001111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1105001111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1105001112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.9

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1105001111).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 36 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 36)

				if (36 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 36)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1105001112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1105001112
		arg_457_1.duration_ = 10.4

		local var_457_0 = {
			zh = 10.4,
			ja = 9.866
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1105001113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1050ui_story = arg_457_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1050ui_story"].transform.position).z)
				arg_457_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1050ui_story"].transform.localEulerAngles = arg_457_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_457_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1050ui_story"].transform.position).z)
				arg_457_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1050ui_story"].transform.localEulerAngles = arg_457_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1050ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1050ui_story == nil then
				arg_457_1.var_.characterEffect1050ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1050ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1050ui_story then
				arg_457_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_460_4 = 0
			local var_460_5 = 1.025

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(1105001112)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 41 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 41)

				if (41 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 41)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001112", "story_v_side_new_1105001.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001112", "story_v_side_new_1105001.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_side_new_1105001", "1105001112", "story_v_side_new_1105001.awb")

						arg_457_1:RecordAudio("1105001112", var_460_11)
						arg_457_1:RecordAudio("1105001112", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001112", "story_v_side_new_1105001.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001112", "story_v_side_new_1105001.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
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

		arg_457_1:InitPlayNodeList()
	end,
	Play1105001113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1105001113
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1105001114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1050ui_story"]) and arg_461_1.var_.characterEffect1050ui_story == nil then
				arg_461_1.var_.characterEffect1050ui_story = arg_461_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1050ui_story"]) then
				if arg_461_1.var_.characterEffect1050ui_story and not isNil(arg_461_1.actors_["1050ui_story"]) then
					arg_461_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1050ui_story"]) and arg_461_1.var_.characterEffect1050ui_story then
				arg_461_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 1.625

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1105001113).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 65 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 65)

				if (65 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 65)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1105001114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1105001114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1105001115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1050ui_story = arg_465_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1050ui_story"].transform.position).z)
				arg_465_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1050ui_story"].transform.localEulerAngles = arg_465_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1050ui_story"].transform.position).z)
				arg_465_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1050ui_story"].transform.localEulerAngles = arg_465_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_468_1 = 0
			local var_468_2 = 0.95

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1105001114).content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 38 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 38)

				if (38 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 38)) > 0 and var_468_2 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_6 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_6 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_6

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_6 and arg_465_1.time_ < var_468_1 + var_468_6 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
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

		arg_465_1:InitPlayNodeList()
	end,
	Play1105001115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1105001115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1105001116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.925

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1105001115).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 37 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 37)

				if (37 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 37)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1105001116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1105001116
		arg_473_1.duration_ = 2

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1105001117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1050ui_story = arg_473_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1050ui_story"].transform.position).z)
				arg_473_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1050ui_story"].transform.localEulerAngles = arg_473_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_473_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1050ui_story"].transform.position).z)
				arg_473_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1050ui_story"].transform.localEulerAngles = arg_473_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1050ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1050ui_story == nil then
				arg_473_1.var_.characterEffect1050ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1050ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1050ui_story then
				arg_473_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_476_4 = 0
			local var_476_5 = 0.075

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(1105001116)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 3 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 3)

				if (3 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 3)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001116", "story_v_side_new_1105001.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001116", "story_v_side_new_1105001.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_side_new_1105001", "1105001116", "story_v_side_new_1105001.awb")

						arg_473_1:RecordAudio("1105001116", var_476_11)
						arg_473_1:RecordAudio("1105001116", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001116", "story_v_side_new_1105001.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001116", "story_v_side_new_1105001.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
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

		arg_473_1:InitPlayNodeList()
	end,
	Play1105001117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1105001117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1105001118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1050ui_story"]) and arg_477_1.var_.characterEffect1050ui_story == nil then
				arg_477_1.var_.characterEffect1050ui_story = arg_477_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1050ui_story"]) then
				if arg_477_1.var_.characterEffect1050ui_story and not isNil(arg_477_1.actors_["1050ui_story"]) then
					arg_477_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1050ui_story"]) and arg_477_1.var_.characterEffect1050ui_story then
				arg_477_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.1

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1105001117).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 4 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 4)

				if (4 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 4)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1105001118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1105001118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1105001119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 1.15

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(1105001118).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 46 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 46)

				if (46 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 46)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1105001119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1105001119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1105001120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.7

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1105001119).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 28 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 28)

				if (28 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 28)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1105001120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1105001120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1105001121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.75

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1105001120).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 30 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 30)

				if (30 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 30)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1105001121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1105001121
		arg_493_1.duration_ = 3.97

		local var_493_0 = {
			zh = 3.966,
			ja = 1.999999999999
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1105001122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1050ui_story = arg_493_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1050ui_story"].transform.position).z)
				arg_493_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1050ui_story"].transform.localEulerAngles = arg_493_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_493_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1050ui_story"].transform.position).z)
				arg_493_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1050ui_story"].transform.localEulerAngles = arg_493_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1050ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1050ui_story == nil then
				arg_493_1.var_.characterEffect1050ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1050ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1050ui_story then
				arg_493_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_496_4 = 0
			local var_496_5 = 0.425

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(1105001121)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 17 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 17)

				if (17 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 17)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001121", "story_v_side_new_1105001.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001121", "story_v_side_new_1105001.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_side_new_1105001", "1105001121", "story_v_side_new_1105001.awb")

						arg_493_1:RecordAudio("1105001121", var_496_11)
						arg_493_1:RecordAudio("1105001121", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001121", "story_v_side_new_1105001.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001121", "story_v_side_new_1105001.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play1105001122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1105001122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1105001123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1050ui_story"]) and arg_497_1.var_.characterEffect1050ui_story == nil then
				arg_497_1.var_.characterEffect1050ui_story = arg_497_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1050ui_story"]) then
				if arg_497_1.var_.characterEffect1050ui_story and not isNil(arg_497_1.actors_["1050ui_story"]) then
					arg_497_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_0)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1050ui_story"]) and arg_497_1.var_.characterEffect1050ui_story then
				arg_497_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_500_1 = 0
			local var_500_2 = 1.1

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1105001122).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 44 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 44)

				if (44 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 44)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1105001123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1105001123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1105001124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.9

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1105001123).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 36 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 36)

				if (36 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 36)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1105001124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1105001124
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1105001125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 1.275

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1105001124).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 51 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 51)

				if (51 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 51)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1105001125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1105001125
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1105001126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.8

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(1105001125).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 32 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 32)

				if (32 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 32)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1105001126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1105001126
		arg_513_1.duration_ = 5.2

		local var_513_0 = {
			zh = 3.2,
			ja = 5.2
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1105001127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos1050ui_story = arg_513_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_516_0 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 then
				arg_513_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_513_1.time_ - 0) / var_516_0)
				arg_513_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1050ui_story"].transform.position).z)
				arg_513_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["1050ui_story"].transform.localEulerAngles = arg_513_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 then
				arg_513_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_513_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1050ui_story"].transform.position).z)
				arg_513_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["1050ui_story"].transform.localEulerAngles = arg_513_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_516_1 = arg_513_1.actors_["1050ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect1050ui_story == nil then
				arg_513_1.var_.characterEffect1050ui_story = var_516_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_2 and not isNil(var_516_1) then
				if arg_513_1.var_.characterEffect1050ui_story and not isNil(var_516_1) then
					arg_513_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_2 and arg_513_1.time_ < 0 + var_516_2 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect1050ui_story then
				arg_513_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_516_4 = 0
			local var_516_5 = 0.275

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_6 = arg_513_1:GetWordFromCfg(1105001126)
				local var_516_7 = arg_513_1:FormatText(var_516_6.content)

				arg_513_1.text_.text = var_516_7

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 11 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 11)

				if (11 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 11)) > 0 and var_516_5 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_7
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001126", "story_v_side_new_1105001.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001126", "story_v_side_new_1105001.awb") / 1000

					if var_516_10 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_4
					end

					if var_516_6.prefab_name ~= "" and arg_513_1.actors_[var_516_6.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_6.prefab_name].transform, "story_v_side_new_1105001", "1105001126", "story_v_side_new_1105001.awb")

						arg_513_1:RecordAudio("1105001126", var_516_11)
						arg_513_1:RecordAudio("1105001126", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001126", "story_v_side_new_1105001.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001126", "story_v_side_new_1105001.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_12 = math.max(var_516_5, arg_513_1.talkMaxDuration)

			if var_516_4 <= arg_513_1.time_ and arg_513_1.time_ < var_516_4 + var_516_12 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_4) / var_516_12

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_4 + var_516_12 and arg_513_1.time_ < var_516_4 + var_516_12 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
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

		arg_513_1:InitPlayNodeList()
	end,
	Play1105001127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1105001127
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1105001128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1050ui_story"]) and arg_517_1.var_.characterEffect1050ui_story == nil then
				arg_517_1.var_.characterEffect1050ui_story = arg_517_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1050ui_story"]) then
				if arg_517_1.var_.characterEffect1050ui_story and not isNil(arg_517_1.actors_["1050ui_story"]) then
					arg_517_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_517_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_517_1.time_ - 0) / var_520_0)
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1050ui_story"]) and arg_517_1.var_.characterEffect1050ui_story then
				arg_517_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_517_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_520_1 = 0
			local var_520_2 = 0.65

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1105001127).content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 26 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_3) / 26)

				if (26 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_3) / 26)) > 0 and var_520_2 < var_520_5 then
					arg_517_1.talkMaxDuration = var_520_5

					if var_520_5 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_6 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_6 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_6

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_6 and arg_517_1.time_ < var_520_1 + var_520_6 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1105001128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1105001128
		arg_521_1.duration_ = 11

		local var_521_0 = {
			zh = 9.033,
			ja = 11
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1105001129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.var_.moveOldPos1050ui_story = arg_521_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_524_0 = 0.001

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 then
				arg_521_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_521_1.time_ - 0) / var_524_0)
				arg_521_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1050ui_story"].transform.position).z)
				arg_521_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1050ui_story"].transform.localEulerAngles = arg_521_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 then
				arg_521_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_521_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1050ui_story"].transform.position).z)
				arg_521_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1050ui_story"].transform.localEulerAngles = arg_521_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_524_1 = arg_521_1.actors_["1050ui_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1050ui_story == nil then
				arg_521_1.var_.characterEffect1050ui_story = var_524_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_2 and not isNil(var_524_1) then
				if arg_521_1.var_.characterEffect1050ui_story and not isNil(var_524_1) then
					arg_521_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_2 and arg_521_1.time_ < 0 + var_524_2 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1050ui_story then
				arg_521_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_524_4 = 0
			local var_524_5 = 0.775

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(1105001128)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 31 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 31)

				if (31 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 31)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001128", "story_v_side_new_1105001.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001128", "story_v_side_new_1105001.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_side_new_1105001", "1105001128", "story_v_side_new_1105001.awb")

						arg_521_1:RecordAudio("1105001128", var_524_11)
						arg_521_1:RecordAudio("1105001128", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001128", "story_v_side_new_1105001.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001128", "story_v_side_new_1105001.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
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

		arg_521_1:InitPlayNodeList()
	end,
	Play1105001129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1105001129
		arg_525_1.duration_ = 13.63

		local var_525_0 = {
			zh = 11.233,
			ja = 13.633
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1105001130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 1.2

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(1105001129)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 48 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 48)

				if (48 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 48)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001129", "story_v_side_new_1105001.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001129", "story_v_side_new_1105001.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_side_new_1105001", "1105001129", "story_v_side_new_1105001.awb")

						arg_525_1:RecordAudio("1105001129", var_528_6)
						arg_525_1:RecordAudio("1105001129", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001129", "story_v_side_new_1105001.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001129", "story_v_side_new_1105001.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1105001130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1105001130
		arg_529_1.duration_ = 16.4

		local var_529_0 = {
			zh = 13.733,
			ja = 16.4
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1105001131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 1.55

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:GetWordFromCfg(1105001130)
				local var_532_2 = arg_529_1:FormatText(var_532_1.content)

				arg_529_1.text_.text = var_532_2

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 62 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 62)

				if (62 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 62)) > 0 and var_532_0 < var_532_4 then
					arg_529_1.talkMaxDuration = var_532_4

					if var_532_4 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_4 + 0
					end
				end

				arg_529_1.text_.text = var_532_2
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001130", "story_v_side_new_1105001.awb") ~= 0 then
					local var_532_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001130", "story_v_side_new_1105001.awb") / 1000

					if var_532_5 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + 0
					end

					if var_532_1.prefab_name ~= "" and arg_529_1.actors_[var_532_1.prefab_name] ~= nil then
						local var_532_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_1.prefab_name].transform, "story_v_side_new_1105001", "1105001130", "story_v_side_new_1105001.awb")

						arg_529_1:RecordAudio("1105001130", var_532_6)
						arg_529_1:RecordAudio("1105001130", var_532_6)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001130", "story_v_side_new_1105001.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001130", "story_v_side_new_1105001.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1105001131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1105001131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1105001132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["1050ui_story"]) and arg_533_1.var_.characterEffect1050ui_story == nil then
				arg_533_1.var_.characterEffect1050ui_story = arg_533_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["1050ui_story"]) then
				if arg_533_1.var_.characterEffect1050ui_story and not isNil(arg_533_1.actors_["1050ui_story"]) then
					arg_533_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_0)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["1050ui_story"]) and arg_533_1.var_.characterEffect1050ui_story then
				arg_533_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_536_1 = 0
			local var_536_2 = 0.075

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1105001131).content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 3 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 3)

				if (3 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 3)) > 0 and var_536_2 < var_536_5 then
					arg_533_1.talkMaxDuration = var_536_5

					if var_536_5 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_6 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_6 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_6

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_6 and arg_533_1.time_ < var_536_1 + var_536_6 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1105001132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1105001132
		arg_537_1.duration_ = 5.73

		local var_537_0 = {
			zh = 5.733,
			ja = 4.766
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1105001133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1050ui_story = arg_537_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_540_0 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				arg_537_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1050ui_story"].transform.position).z)
				arg_537_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1050ui_story"].transform.localEulerAngles = arg_537_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				arg_537_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_537_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1050ui_story"].transform.position).z)
				arg_537_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1050ui_story"].transform.localEulerAngles = arg_537_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_540_1 = arg_537_1.actors_["1050ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect1050ui_story == nil then
				arg_537_1.var_.characterEffect1050ui_story = var_540_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_2 and not isNil(var_540_1) then
				if arg_537_1.var_.characterEffect1050ui_story and not isNil(var_540_1) then
					arg_537_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_2 and arg_537_1.time_ < 0 + var_540_2 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect1050ui_story then
				arg_537_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_540_4 = 0
			local var_540_5 = 0.775

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_4 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_6 = arg_537_1:GetWordFromCfg(1105001132)
				local var_540_7 = arg_537_1:FormatText(var_540_6.content)

				arg_537_1.text_.text = var_540_7

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_9 = 31 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 31)

				if (31 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 31)) > 0 and var_540_5 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_4
					end
				end

				arg_537_1.text_.text = var_540_7
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001132", "story_v_side_new_1105001.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001132", "story_v_side_new_1105001.awb") / 1000

					if var_540_10 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_4
					end

					if var_540_6.prefab_name ~= "" and arg_537_1.actors_[var_540_6.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_6.prefab_name].transform, "story_v_side_new_1105001", "1105001132", "story_v_side_new_1105001.awb")

						arg_537_1:RecordAudio("1105001132", var_540_11)
						arg_537_1:RecordAudio("1105001132", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001132", "story_v_side_new_1105001.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001132", "story_v_side_new_1105001.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_5, arg_537_1.talkMaxDuration)

			if var_540_4 <= arg_537_1.time_ and arg_537_1.time_ < var_540_4 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_4) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_4 + var_540_12 and arg_537_1.time_ < var_540_4 + var_540_12 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play1105001133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1105001133
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1105001134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1050ui_story"]) and arg_541_1.var_.characterEffect1050ui_story == nil then
				arg_541_1.var_.characterEffect1050ui_story = arg_541_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_0 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1050ui_story"]) then
				if arg_541_1.var_.characterEffect1050ui_story and not isNil(arg_541_1.actors_["1050ui_story"]) then
					arg_541_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_541_1.time_ - 0) / var_544_0)
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1050ui_story"]) and arg_541_1.var_.characterEffect1050ui_story then
				arg_541_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_544_1 = 0
			local var_544_2 = 0.375

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(1105001133).content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 15 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 15)

				if (15 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 15)) > 0 and var_544_2 < var_544_5 then
					arg_541_1.talkMaxDuration = var_544_5

					if var_544_5 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_6 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_6 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_6

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_6 and arg_541_1.time_ < var_544_1 + var_544_6 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1105001134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1105001134
		arg_545_1.duration_ = 2

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1105001135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1050ui_story = arg_545_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1050ui_story"].transform.position).z)
				arg_545_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1050ui_story"].transform.localEulerAngles = arg_545_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_545_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1050ui_story"].transform.position).z)
				arg_545_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1050ui_story"].transform.localEulerAngles = arg_545_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_548_1 = arg_545_1.actors_["1050ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1050ui_story == nil then
				arg_545_1.var_.characterEffect1050ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1050ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1050ui_story then
				arg_545_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action453")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_548_4 = 0
			local var_548_5 = 0.1

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(1105001134)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 4 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 4)

				if (4 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 4)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001134", "story_v_side_new_1105001.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001134", "story_v_side_new_1105001.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_side_new_1105001", "1105001134", "story_v_side_new_1105001.awb")

						arg_545_1:RecordAudio("1105001134", var_548_11)
						arg_545_1:RecordAudio("1105001134", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001134", "story_v_side_new_1105001.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001134", "story_v_side_new_1105001.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_12 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_12 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_12

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_12 and arg_545_1.time_ < var_548_4 + var_548_12 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
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

		arg_545_1:InitPlayNodeList()
	end,
	Play1105001135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1105001135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1105001136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["1050ui_story"]) and arg_549_1.var_.characterEffect1050ui_story == nil then
				arg_549_1.var_.characterEffect1050ui_story = arg_549_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_0 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["1050ui_story"]) then
				if arg_549_1.var_.characterEffect1050ui_story and not isNil(arg_549_1.actors_["1050ui_story"]) then
					arg_549_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_0)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["1050ui_story"]) and arg_549_1.var_.characterEffect1050ui_story then
				arg_549_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_552_1 = 0
			local var_552_2 = 0.925

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1105001135).content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 37 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 37)

				if (37 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 37)) > 0 and var_552_2 < var_552_5 then
					arg_549_1.talkMaxDuration = var_552_5

					if var_552_5 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_6 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_6 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_6

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_6 and arg_549_1.time_ < var_552_1 + var_552_6 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1105001136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1105001136
		arg_553_1.duration_ = 12

		local var_553_0 = {
			zh = 6.3,
			ja = 12
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1105001137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1050ui_story = arg_553_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_556_0 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 then
				arg_553_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_553_1.time_ - 0) / var_556_0)
				arg_553_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1050ui_story"].transform.position).z)
				arg_553_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1050ui_story"].transform.localEulerAngles = arg_553_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 then
				arg_553_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_553_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1050ui_story"].transform.position).z)
				arg_553_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1050ui_story"].transform.localEulerAngles = arg_553_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_556_1 = arg_553_1.actors_["1050ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1050ui_story == nil then
				arg_553_1.var_.characterEffect1050ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect1050ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1050ui_story then
				arg_553_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_556_4 = 0
			local var_556_5 = 0.7

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_6 = arg_553_1:GetWordFromCfg(1105001136)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 28 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 28)

				if (28 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 28)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001136", "story_v_side_new_1105001.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001136", "story_v_side_new_1105001.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_side_new_1105001", "1105001136", "story_v_side_new_1105001.awb")

						arg_553_1:RecordAudio("1105001136", var_556_11)
						arg_553_1:RecordAudio("1105001136", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001136", "story_v_side_new_1105001.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001136", "story_v_side_new_1105001.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_5, arg_553_1.talkMaxDuration)

			if var_556_4 <= arg_553_1.time_ and arg_553_1.time_ < var_556_4 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_4) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_4 + var_556_12 and arg_553_1.time_ < var_556_4 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
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

		arg_553_1:InitPlayNodeList()
	end,
	Play1105001137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1105001137
		arg_557_1.duration_ = 4.47

		local var_557_0 = {
			zh = 3.8,
			ja = 4.466
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1105001138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.35

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:GetWordFromCfg(1105001137)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 14 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 14)

				if (14 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 14)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001137", "story_v_side_new_1105001.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001137", "story_v_side_new_1105001.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_side_new_1105001", "1105001137", "story_v_side_new_1105001.awb")

						arg_557_1:RecordAudio("1105001137", var_560_6)
						arg_557_1:RecordAudio("1105001137", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001137", "story_v_side_new_1105001.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001137", "story_v_side_new_1105001.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1105001138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1105001138
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1105001139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["1050ui_story"]) and arg_561_1.var_.characterEffect1050ui_story == nil then
				arg_561_1.var_.characterEffect1050ui_story = arg_561_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_0 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["1050ui_story"]) then
				if arg_561_1.var_.characterEffect1050ui_story and not isNil(arg_561_1.actors_["1050ui_story"]) then
					arg_561_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_561_1.time_ - 0) / var_564_0)
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["1050ui_story"]) and arg_561_1.var_.characterEffect1050ui_story then
				arg_561_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_564_1 = 0
			local var_564_2 = 0.325

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(1105001138).content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 13 <= 0 and var_564_2 or var_564_2 * (utf8.len(var_564_3) / 13)

				if (13 <= 0 and var_564_2 or var_564_2 * (utf8.len(var_564_3) / 13)) > 0 and var_564_2 < var_564_5 then
					arg_561_1.talkMaxDuration = var_564_5

					if var_564_5 + var_564_1 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + var_564_1
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_6 = math.max(var_564_2, arg_561_1.talkMaxDuration)

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_6 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_1) / var_564_6

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_1 + var_564_6 and arg_561_1.time_ < var_564_1 + var_564_6 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1105001139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1105001139
		arg_565_1.duration_ = 10.53

		local var_565_0 = {
			zh = 9.833,
			ja = 10.533
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1105001140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos1050ui_story = arg_565_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_568_0 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 then
				arg_565_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_565_1.time_ - 0) / var_568_0)
				arg_565_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1050ui_story"].transform.position).z)
				arg_565_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1050ui_story"].transform.localEulerAngles = arg_565_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 then
				arg_565_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_565_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1050ui_story"].transform.position).z)
				arg_565_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1050ui_story"].transform.localEulerAngles = arg_565_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_568_1 = arg_565_1.actors_["1050ui_story"]

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(var_568_1) and arg_565_1.var_.characterEffect1050ui_story == nil then
				arg_565_1.var_.characterEffect1050ui_story = var_568_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_2 and not isNil(var_568_1) then
				if arg_565_1.var_.characterEffect1050ui_story and not isNil(var_568_1) then
					arg_565_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= 0 + var_568_2 and arg_565_1.time_ < 0 + var_568_2 + arg_568_0 and not isNil(var_568_1) and arg_565_1.var_.characterEffect1050ui_story then
				arg_565_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_568_4 = 0
			local var_568_5 = 1.15

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_6 = arg_565_1:GetWordFromCfg(1105001139)
				local var_568_7 = arg_565_1:FormatText(var_568_6.content)

				arg_565_1.text_.text = var_568_7

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_9 = 46 <= 0 and var_568_5 or var_568_5 * (utf8.len(var_568_7) / 46)

				if (46 <= 0 and var_568_5 or var_568_5 * (utf8.len(var_568_7) / 46)) > 0 and var_568_5 < var_568_9 then
					arg_565_1.talkMaxDuration = var_568_9

					if var_568_9 + var_568_4 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_9 + var_568_4
					end
				end

				arg_565_1.text_.text = var_568_7
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001139", "story_v_side_new_1105001.awb") ~= 0 then
					local var_568_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001139", "story_v_side_new_1105001.awb") / 1000

					if var_568_10 + var_568_4 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_10 + var_568_4
					end

					if var_568_6.prefab_name ~= "" and arg_565_1.actors_[var_568_6.prefab_name] ~= nil then
						local var_568_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_6.prefab_name].transform, "story_v_side_new_1105001", "1105001139", "story_v_side_new_1105001.awb")

						arg_565_1:RecordAudio("1105001139", var_568_11)
						arg_565_1:RecordAudio("1105001139", var_568_11)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001139", "story_v_side_new_1105001.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001139", "story_v_side_new_1105001.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_12 = math.max(var_568_5, arg_565_1.talkMaxDuration)

			if var_568_4 <= arg_565_1.time_ and arg_565_1.time_ < var_568_4 + var_568_12 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_4) / var_568_12

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_4 + var_568_12 and arg_565_1.time_ < var_568_4 + var_568_12 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
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

		arg_565_1:InitPlayNodeList()
	end,
	Play1105001140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1105001140
		arg_569_1.duration_ = 6.67

		local var_569_0 = {
			zh = 6.666,
			ja = 5.733
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1105001141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.725

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:GetWordFromCfg(1105001140)
				local var_572_2 = arg_569_1:FormatText(var_572_1.content)

				arg_569_1.text_.text = var_572_2

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 29 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 29)

				if (29 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 29)) > 0 and var_572_0 < var_572_4 then
					arg_569_1.talkMaxDuration = var_572_4

					if var_572_4 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_4 + 0
					end
				end

				arg_569_1.text_.text = var_572_2
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001140", "story_v_side_new_1105001.awb") ~= 0 then
					local var_572_5 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001140", "story_v_side_new_1105001.awb") / 1000

					if var_572_5 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + 0
					end

					if var_572_1.prefab_name ~= "" and arg_569_1.actors_[var_572_1.prefab_name] ~= nil then
						local var_572_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_1.prefab_name].transform, "story_v_side_new_1105001", "1105001140", "story_v_side_new_1105001.awb")

						arg_569_1:RecordAudio("1105001140", var_572_6)
						arg_569_1:RecordAudio("1105001140", var_572_6)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001140", "story_v_side_new_1105001.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001140", "story_v_side_new_1105001.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1105001141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1105001141
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1105001142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1050ui_story"]) and arg_573_1.var_.characterEffect1050ui_story == nil then
				arg_573_1.var_.characterEffect1050ui_story = arg_573_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1050ui_story"]) then
				if arg_573_1.var_.characterEffect1050ui_story and not isNil(arg_573_1.actors_["1050ui_story"]) then
					arg_573_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_0)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1050ui_story"]) and arg_573_1.var_.characterEffect1050ui_story then
				arg_573_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_576_1 = 0
			local var_576_2 = 1.05

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_3 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(1105001141).content)

				arg_573_1.text_.text = var_576_3

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 42 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 42)

				if (42 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 42)) > 0 and var_576_2 < var_576_5 then
					arg_573_1.talkMaxDuration = var_576_5

					if var_576_5 + var_576_1 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + var_576_1
					end
				end

				arg_573_1.text_.text = var_576_3
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_6 = math.max(var_576_2, arg_573_1.talkMaxDuration)

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_6 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_1) / var_576_6

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_1 + var_576_6 and arg_573_1.time_ < var_576_1 + var_576_6 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1105001142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1105001142
		arg_577_1.duration_ = 5.1

		local var_577_0 = {
			zh = 5.1,
			ja = 4.5
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
			arg_577_1.auto_ = false
		end

		function arg_577_1.playNext_(arg_579_0)
			arg_577_1.onStoryFinished_()
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos1050ui_story = arg_577_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_580_0 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 then
				arg_577_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_577_1.time_ - 0) / var_580_0)
				arg_577_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1050ui_story"].transform.position).z)
				arg_577_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["1050ui_story"].transform.localEulerAngles = arg_577_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 then
				arg_577_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_577_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1050ui_story"].transform.position).z)
				arg_577_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["1050ui_story"].transform.localEulerAngles = arg_577_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_580_1 = arg_577_1.actors_["1050ui_story"]

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(var_580_1) and arg_577_1.var_.characterEffect1050ui_story == nil then
				arg_577_1.var_.characterEffect1050ui_story = var_580_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_2 and not isNil(var_580_1) then
				if arg_577_1.var_.characterEffect1050ui_story and not isNil(var_580_1) then
					arg_577_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_577_1.time_ >= 0 + var_580_2 and arg_577_1.time_ < 0 + var_580_2 + arg_580_0 and not isNil(var_580_1) and arg_577_1.var_.characterEffect1050ui_story then
				arg_577_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_580_4 = 0
			local var_580_5 = 0.45

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_4 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_6 = arg_577_1:GetWordFromCfg(1105001142)
				local var_580_7 = arg_577_1:FormatText(var_580_6.content)

				arg_577_1.text_.text = var_580_7

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_9 = 18 <= 0 and var_580_5 or var_580_5 * (utf8.len(var_580_7) / 18)

				if (18 <= 0 and var_580_5 or var_580_5 * (utf8.len(var_580_7) / 18)) > 0 and var_580_5 < var_580_9 then
					arg_577_1.talkMaxDuration = var_580_9

					if var_580_9 + var_580_4 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_9 + var_580_4
					end
				end

				arg_577_1.text_.text = var_580_7
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001142", "story_v_side_new_1105001.awb") ~= 0 then
					local var_580_10 = manager.audio:GetVoiceLength("story_v_side_new_1105001", "1105001142", "story_v_side_new_1105001.awb") / 1000

					if var_580_10 + var_580_4 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_10 + var_580_4
					end

					if var_580_6.prefab_name ~= "" and arg_577_1.actors_[var_580_6.prefab_name] ~= nil then
						local var_580_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_6.prefab_name].transform, "story_v_side_new_1105001", "1105001142", "story_v_side_new_1105001.awb")

						arg_577_1:RecordAudio("1105001142", var_580_11)
						arg_577_1:RecordAudio("1105001142", var_580_11)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1105001", "1105001142", "story_v_side_new_1105001.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1105001", "1105001142", "story_v_side_new_1105001.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_12 = math.max(var_580_5, arg_577_1.talkMaxDuration)

			if var_580_4 <= arg_577_1.time_ and arg_577_1.time_ < var_580_4 + var_580_12 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_4) / var_580_12

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_4 + var_580_12 and arg_577_1.time_ < var_580_4 + var_580_12 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
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

		arg_577_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/K06f",
		"TextureConfig/Background/ST59",
		"TextureConfig/Background/ST06b"
	},
	voices = {
		"story_v_side_new_1105001.awb"
	}
}
