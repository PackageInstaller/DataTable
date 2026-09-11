return {
	Play1104105001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104105001
		arg_1_1.duration_ = 4.57

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104105002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_4_0.name = "ST22a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22a

				arg_1_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22a" then
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

			local var_4_8 = "1041ui_story"

			if arg_1_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1041ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.11, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1041ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story == nil then
				arg_1_1.var_.characterEffect1041ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1041ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story then
				arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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
			local var_4_24 = 0.425

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(1104105001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 17 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 17)

				if (17 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 17)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105001", "story_v_side_new_1104105.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105001", "story_v_side_new_1104105.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_side_new_1104105", "1104105001", "story_v_side_new_1104105.awb")

						arg_1_1:RecordAudio("1104105001", var_4_31)
						arg_1_1:RecordAudio("1104105001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105001", "story_v_side_new_1104105.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105001", "story_v_side_new_1104105.awb")
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
				actorName = "1041ui_story",
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
	Play1104105002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104105002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104105003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1041ui_story"]) and arg_9_1.var_.characterEffect1041ui_story == nil then
				arg_9_1.var_.characterEffect1041ui_story = arg_9_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1041ui_story"]) then
				if arg_9_1.var_.characterEffect1041ui_story and not isNil(arg_9_1.actors_["1041ui_story"]) then
					arg_9_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1041ui_story"]) and arg_9_1.var_.characterEffect1041ui_story then
				arg_9_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.85

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1104105002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 34 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 34)

				if (34 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 34)) > 0 and var_12_2 < var_12_5 then
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
	Play1104105003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104105003
		arg_13_1.duration_ = 8

		local var_13_0 = {
			zh = 8,
			ja = 6.833
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
				arg_13_0:Play1104105004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1041ui_story"]) and arg_13_1.var_.characterEffect1041ui_story == nil then
				arg_13_1.var_.characterEffect1041ui_story = arg_13_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1041ui_story"]) then
				if arg_13_1.var_.characterEffect1041ui_story and not isNil(arg_13_1.actors_["1041ui_story"]) then
					arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1041ui_story"]) and arg_13_1.var_.characterEffect1041ui_story then
				arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_16_2 = 0
			local var_16_3 = 1.15

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(1104105003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 46 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 46)

				if (46 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 46)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105003", "story_v_side_new_1104105.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105003", "story_v_side_new_1104105.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_side_new_1104105", "1104105003", "story_v_side_new_1104105.awb")

						arg_13_1:RecordAudio("1104105003", var_16_9)
						arg_13_1:RecordAudio("1104105003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105003", "story_v_side_new_1104105.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105003", "story_v_side_new_1104105.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1104105004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104105004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1104105005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) and arg_17_1.var_.characterEffect1041ui_story == nil then
				arg_17_1.var_.characterEffect1041ui_story = arg_17_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) then
				if arg_17_1.var_.characterEffect1041ui_story and not isNil(arg_17_1.actors_["1041ui_story"]) then
					arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) and arg_17_1.var_.characterEffect1041ui_story then
				arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.1

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

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1104105004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 4 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 4)

				if (4 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 4)) > 0 and var_20_2 < var_20_5 then
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
	Play1104105005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104105005
		arg_21_1.duration_ = 11.13

		local var_21_0 = {
			zh = 11.133,
			ja = 10.033
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
				arg_21_0:Play1104105006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1041ui_story"]) and arg_21_1.var_.characterEffect1041ui_story == nil then
				arg_21_1.var_.characterEffect1041ui_story = arg_21_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1041ui_story"]) then
				if arg_21_1.var_.characterEffect1041ui_story and not isNil(arg_21_1.actors_["1041ui_story"]) then
					arg_21_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1041ui_story"]) and arg_21_1.var_.characterEffect1041ui_story then
				arg_21_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 1.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(1104105005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 45 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 45)

				if (45 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 45)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105005", "story_v_side_new_1104105.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105005", "story_v_side_new_1104105.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_side_new_1104105", "1104105005", "story_v_side_new_1104105.awb")

						arg_21_1:RecordAudio("1104105005", var_24_9)
						arg_21_1:RecordAudio("1104105005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105005", "story_v_side_new_1104105.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105005", "story_v_side_new_1104105.awb")
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
	Play1104105006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104105006
		arg_25_1.duration_ = 11.03

		local var_25_0 = {
			zh = 11.033,
			ja = 5.9
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
				arg_25_0:Play1104105007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.625

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(1104105006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 65 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 65)

				if (65 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 65)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105006", "story_v_side_new_1104105.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105006", "story_v_side_new_1104105.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_side_new_1104105", "1104105006", "story_v_side_new_1104105.awb")

						arg_25_1:RecordAudio("1104105006", var_28_6)
						arg_25_1:RecordAudio("1104105006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105006", "story_v_side_new_1104105.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105006", "story_v_side_new_1104105.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1104105007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104105007
		arg_29_1.duration_ = 6.33

		local var_29_0 = {
			zh = 4.5,
			ja = 6.333
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
				arg_29_0:Play1104105008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1041ui_story"]) and arg_29_1.var_.characterEffect1041ui_story == nil then
				arg_29_1.var_.characterEffect1041ui_story = arg_29_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1041ui_story"]) then
				if arg_29_1.var_.characterEffect1041ui_story and not isNil(arg_29_1.actors_["1041ui_story"]) then
					arg_29_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1041ui_story"]) and arg_29_1.var_.characterEffect1041ui_story then
				arg_29_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_32_2 = 0
			local var_32_3 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(1104105007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 33)

				if (33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 33)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105007", "story_v_side_new_1104105.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105007", "story_v_side_new_1104105.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_new_1104105", "1104105007", "story_v_side_new_1104105.awb")

						arg_29_1:RecordAudio("1104105007", var_32_9)
						arg_29_1:RecordAudio("1104105007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105007", "story_v_side_new_1104105.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105007", "story_v_side_new_1104105.awb")
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
	Play1104105008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104105008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1104105009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1041ui_story"]) and arg_33_1.var_.characterEffect1041ui_story == nil then
				arg_33_1.var_.characterEffect1041ui_story = arg_33_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1041ui_story"]) then
				if arg_33_1.var_.characterEffect1041ui_story and not isNil(arg_33_1.actors_["1041ui_story"]) then
					arg_33_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1041ui_story"]) and arg_33_1.var_.characterEffect1041ui_story then
				arg_33_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.425

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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1104105008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 17 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 17)

				if (17 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 17)) > 0 and var_36_2 < var_36_5 then
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
	Play1104105009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104105009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1104105010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_0 = arg_37_1.bgs_.ST22a

				arg_37_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_1 = var_40_0:GetComponent("SpriteRenderer")

				if var_40_1 and var_40_1.sprite then
					local var_40_2 = 2 * (var_40_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_0.transform.localScale = Vector3.New(var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST22a" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_3 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_4 = 2

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_4 then
				local var_40_5 = Color.New(0, 0, 0)

				var_40_5.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_3) / var_40_4)
				arg_37_1.mask_.color = var_40_5
			end

			if arg_37_1.time_ >= var_40_3 + var_40_4 and arg_37_1.time_ < var_40_3 + var_40_4 + arg_40_0 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = 1
				arg_37_1.mask_.color = var_40_6
			end

			local var_40_7 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_8 = 2

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 then
				local var_40_9 = Color.New(0, 0, 0)

				var_40_9.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_7) / var_40_8)
				arg_37_1.mask_.color = var_40_9
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 then
				local var_40_10 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_10.a = 0
				arg_37_1.mask_.color = var_40_10
			end

			local var_40_11 = arg_37_1.actors_["1041ui_story"].transform

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1.var_.moveOldPos1041ui_story = var_40_11.localPosition
			end

			local var_40_12 = 0.001

			if 2 <= arg_37_1.time_ and arg_37_1.time_ < 2 + var_40_12 then
				var_40_11.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 2) / var_40_12)
				var_40_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_11.position).x, (manager.ui.mainCamera.transform.position - var_40_11.position).y, (manager.ui.mainCamera.transform.position - var_40_11.position).z)
				var_40_11.localEulerAngles.z = 0
				var_40_11.localEulerAngles.x = 0
				var_40_11.localEulerAngles = var_40_11.localEulerAngles
			end

			if arg_37_1.time_ >= 2 + var_40_12 and arg_37_1.time_ < 2 + var_40_12 + arg_40_0 then
				var_40_11.localPosition = Vector3.New(0, 100, 0)
				var_40_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_11.position).x, (manager.ui.mainCamera.transform.position - var_40_11.position).y, (manager.ui.mainCamera.transform.position - var_40_11.position).z)
				var_40_11.localEulerAngles.z = 0
				var_40_11.localEulerAngles.x = 0
				var_40_11.localEulerAngles = var_40_11.localEulerAngles
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_13 = 4
			local var_40_14 = 0.15

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_15 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_15:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1104105009).content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_18 = 6 <= 0 and var_40_14 or var_40_14 * (utf8.len(var_40_16) / 6)

				if (6 <= 0 and var_40_14 or var_40_14 * (utf8.len(var_40_16) / 6)) > 0 and var_40_14 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18
					var_40_13 = var_40_13 + 0.3

					if var_40_18 + var_40_13 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_13
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = var_40_13 + 0.3
			local var_40_20 = math.max(var_40_14, arg_37_1.talkMaxDuration)

			if var_40_13 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_19) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_19 + var_40_20 and arg_37_1.time_ < var_40_19 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1104105010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1104105010
		arg_43_1.duration_ = 3.1

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1104105011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.125

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:GetWordFromCfg(1104105010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 5 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 5)

				if (5 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 5)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105010", "story_v_side_new_1104105.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105010", "story_v_side_new_1104105.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_side_new_1104105", "1104105010", "story_v_side_new_1104105.awb")

						arg_43_1:RecordAudio("1104105010", var_46_6)
						arg_43_1:RecordAudio("1104105010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105010", "story_v_side_new_1104105.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105010", "story_v_side_new_1104105.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1104105011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1104105011
		arg_47_1.duration_ = 6.1

		local var_47_0 = {
			zh = 6.1,
			ja = 5.2
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1104105012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1041ui_story = arg_47_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1041ui_story"].transform.position).z)
				arg_47_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1041ui_story"].transform.localEulerAngles = arg_47_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_47_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1041ui_story"].transform.position).z)
				arg_47_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1041ui_story"].transform.localEulerAngles = arg_47_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1041ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1041ui_story == nil then
				arg_47_1.var_.characterEffect1041ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1041ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1041ui_story then
				arg_47_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_50_4 = 0
			local var_50_5 = 0.725

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(1104105011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 29 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 29)

				if (29 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 29)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105011", "story_v_side_new_1104105.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105011", "story_v_side_new_1104105.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_side_new_1104105", "1104105011", "story_v_side_new_1104105.awb")

						arg_47_1:RecordAudio("1104105011", var_50_11)
						arg_47_1:RecordAudio("1104105011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105011", "story_v_side_new_1104105.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105011", "story_v_side_new_1104105.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play1104105012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1104105012
		arg_51_1.duration_ = 1.87

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1104105013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1041ui_story"]) and arg_51_1.var_.characterEffect1041ui_story == nil then
				arg_51_1.var_.characterEffect1041ui_story = arg_51_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1041ui_story"]) then
				if arg_51_1.var_.characterEffect1041ui_story and not isNil(arg_51_1.actors_["1041ui_story"]) then
					arg_51_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1041ui_story"]) and arg_51_1.var_.characterEffect1041ui_story then
				arg_51_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(1104105012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 6 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 6)

				if (6 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 6)) > 0 and var_54_2 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105012", "story_v_side_new_1104105.awb") ~= 0 then
					local var_54_7 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105012", "story_v_side_new_1104105.awb") / 1000

					if var_54_7 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_1
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_side_new_1104105", "1104105012", "story_v_side_new_1104105.awb")

						arg_51_1:RecordAudio("1104105012", var_54_8)
						arg_51_1:RecordAudio("1104105012", var_54_8)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105012", "story_v_side_new_1104105.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105012", "story_v_side_new_1104105.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_9 and arg_51_1.time_ < var_54_1 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1104105013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1104105013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1104105014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.85

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(1104105013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 34 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 34)

				if (34 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 34)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1104105014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1104105014
		arg_59_1.duration_ = 5

		local var_59_0 = {
			zh = 5,
			ja = 4.433
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1104105015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1041ui_story"]) and arg_59_1.var_.characterEffect1041ui_story == nil then
				arg_59_1.var_.characterEffect1041ui_story = arg_59_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1041ui_story"]) then
				if arg_59_1.var_.characterEffect1041ui_story and not isNil(arg_59_1.actors_["1041ui_story"]) then
					arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1041ui_story"]) and arg_59_1.var_.characterEffect1041ui_story then
				arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_62_2 = 0
			local var_62_3 = 0.6

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(1104105014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 24 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 24)

				if (24 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 24)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105014", "story_v_side_new_1104105.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105014", "story_v_side_new_1104105.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_side_new_1104105", "1104105014", "story_v_side_new_1104105.awb")

						arg_59_1:RecordAudio("1104105014", var_62_9)
						arg_59_1:RecordAudio("1104105014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105014", "story_v_side_new_1104105.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105014", "story_v_side_new_1104105.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1104105015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1104105015
		arg_63_1.duration_ = 1

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1104105016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1041ui_story"]) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = arg_63_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1041ui_story"]) then
				if arg_63_1.var_.characterEffect1041ui_story and not isNil(arg_63_1.actors_["1041ui_story"]) then
					arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1041ui_story"]) and arg_63_1.var_.characterEffect1041ui_story then
				arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.05

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(1104105015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 2 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 2)

				if (2 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 2)) > 0 and var_66_2 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105015", "story_v_side_new_1104105.awb") ~= 0 then
					local var_66_7 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105015", "story_v_side_new_1104105.awb") / 1000

					if var_66_7 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_1
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_side_new_1104105", "1104105015", "story_v_side_new_1104105.awb")

						arg_63_1:RecordAudio("1104105015", var_66_8)
						arg_63_1:RecordAudio("1104105015", var_66_8)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105015", "story_v_side_new_1104105.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105015", "story_v_side_new_1104105.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_9 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_9 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_9

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_9 and arg_63_1.time_ < var_66_1 + var_66_9 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1104105016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1104105016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1104105017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1041ui_story = arg_67_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1041ui_story"].transform.position).z)
				arg_67_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1041ui_story"].transform.localEulerAngles = arg_67_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1041ui_story"].transform.position).z)
				arg_67_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1041ui_story"].transform.localEulerAngles = arg_67_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_70_1 = 0
			local var_70_2 = 1.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1104105016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 49 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 49)

				if (49 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 49)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play1104105017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1104105017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1104105018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.675

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1104105017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 27 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 27)

				if (27 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 27)) > 0 and var_74_0 < var_74_3 then
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
	Play1104105018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1104105018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1104105019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.6

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1104105018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 24)

				if (24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 24)) > 0 and var_78_0 < var_78_3 then
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
	Play1104105019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1104105019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1104105020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.75

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1104105019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 30 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 30)

				if (30 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 30)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1104105020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1104105020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1104105021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.375

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1104105020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 55 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 55)

				if (55 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 55)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1104105021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1104105021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1104105022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1104105021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 18 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 18)

				if (18 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 18)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1104105022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1104105022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1104105023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.775

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1104105022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 31 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 31)

				if (31 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 31)) > 0 and var_94_0 < var_94_3 then
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
	Play1104105023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1104105023
		arg_95_1.duration_ = 2

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1104105024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1041ui_story = arg_95_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1041ui_story"].transform.position).z)
				arg_95_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1041ui_story"].transform.localEulerAngles = arg_95_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_95_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1041ui_story"].transform.position).z)
				arg_95_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1041ui_story"].transform.localEulerAngles = arg_95_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1041ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1041ui_story == nil then
				arg_95_1.var_.characterEffect1041ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1041ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1041ui_story then
				arg_95_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.075

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(1104105023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 3 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 3)

				if (3 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 3)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105023", "story_v_side_new_1104105.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105023", "story_v_side_new_1104105.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_side_new_1104105", "1104105023", "story_v_side_new_1104105.awb")

						arg_95_1:RecordAudio("1104105023", var_98_11)
						arg_95_1:RecordAudio("1104105023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105023", "story_v_side_new_1104105.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105023", "story_v_side_new_1104105.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1104105024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1104105024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1104105025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1041ui_story"]) and arg_99_1.var_.characterEffect1041ui_story == nil then
				arg_99_1.var_.characterEffect1041ui_story = arg_99_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1041ui_story"]) then
				if arg_99_1.var_.characterEffect1041ui_story and not isNil(arg_99_1.actors_["1041ui_story"]) then
					arg_99_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1041ui_story"]) and arg_99_1.var_.characterEffect1041ui_story then
				arg_99_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.85

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1104105024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 34 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 34)

				if (34 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 34)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1104105025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1104105025
		arg_103_1.duration_ = 5.8

		local var_103_0 = {
			zh = 3.433,
			ja = 5.8
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
				arg_103_0:Play1104105026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1041ui_story"]) and arg_103_1.var_.characterEffect1041ui_story == nil then
				arg_103_1.var_.characterEffect1041ui_story = arg_103_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1041ui_story"]) then
				if arg_103_1.var_.characterEffect1041ui_story and not isNil(arg_103_1.actors_["1041ui_story"]) then
					arg_103_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1041ui_story"]) and arg_103_1.var_.characterEffect1041ui_story then
				arg_103_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_2 = 0
			local var_106_3 = 0.575

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(1104105025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 23 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 23)

				if (23 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 23)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105025", "story_v_side_new_1104105.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105025", "story_v_side_new_1104105.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_side_new_1104105", "1104105025", "story_v_side_new_1104105.awb")

						arg_103_1:RecordAudio("1104105025", var_106_9)
						arg_103_1:RecordAudio("1104105025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105025", "story_v_side_new_1104105.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105025", "story_v_side_new_1104105.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1104105026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1104105026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1104105027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1041ui_story"]) and arg_107_1.var_.characterEffect1041ui_story == nil then
				arg_107_1.var_.characterEffect1041ui_story = arg_107_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1041ui_story"]) then
				if arg_107_1.var_.characterEffect1041ui_story and not isNil(arg_107_1.actors_["1041ui_story"]) then
					arg_107_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1041ui_story"]) and arg_107_1.var_.characterEffect1041ui_story then
				arg_107_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1104105026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 17 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 17)

				if (17 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 17)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1104105027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1104105027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1104105028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.575

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1104105027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 23 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 23)

				if (23 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 23)) > 0 and var_114_0 < var_114_3 then
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
	Play1104105028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1104105028
		arg_115_1.duration_ = 13.1

		local var_115_0 = {
			zh = 13.1,
			ja = 5.166
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
				arg_115_0:Play1104105029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1041ui_story"]) and arg_115_1.var_.characterEffect1041ui_story == nil then
				arg_115_1.var_.characterEffect1041ui_story = arg_115_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1041ui_story"]) then
				if arg_115_1.var_.characterEffect1041ui_story and not isNil(arg_115_1.actors_["1041ui_story"]) then
					arg_115_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1041ui_story"]) and arg_115_1.var_.characterEffect1041ui_story then
				arg_115_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_118_2 = 0
			local var_118_3 = 1.675

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(1104105028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 67 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 67)

				if (67 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 67)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105028", "story_v_side_new_1104105.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105028", "story_v_side_new_1104105.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_side_new_1104105", "1104105028", "story_v_side_new_1104105.awb")

						arg_115_1:RecordAudio("1104105028", var_118_9)
						arg_115_1:RecordAudio("1104105028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105028", "story_v_side_new_1104105.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105028", "story_v_side_new_1104105.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1104105029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1104105029
		arg_119_1.duration_ = 10.77

		local var_119_0 = {
			zh = 8.5,
			ja = 10.766
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
				arg_119_0:Play1104105030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 1.125

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(1104105029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 45 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 45)

				if (45 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 45)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105029", "story_v_side_new_1104105.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105029", "story_v_side_new_1104105.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_side_new_1104105", "1104105029", "story_v_side_new_1104105.awb")

						arg_119_1:RecordAudio("1104105029", var_122_6)
						arg_119_1:RecordAudio("1104105029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105029", "story_v_side_new_1104105.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105029", "story_v_side_new_1104105.awb")
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
	Play1104105030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1104105030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1104105031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1041ui_story"]) and arg_123_1.var_.characterEffect1041ui_story == nil then
				arg_123_1.var_.characterEffect1041ui_story = arg_123_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1041ui_story"]) then
				if arg_123_1.var_.characterEffect1041ui_story and not isNil(arg_123_1.actors_["1041ui_story"]) then
					arg_123_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1041ui_story"]) and arg_123_1.var_.characterEffect1041ui_story then
				arg_123_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.3

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
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

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1104105030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 12 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 12)

				if (12 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 12)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1104105031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1104105031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1104105032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1.6

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

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1104105031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 64 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 64)

				if (64 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 64)) > 0 and var_130_0 < var_130_3 then
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
	Play1104105032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1104105032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1104105033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.225

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1104105032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 49 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 49)

				if (49 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 49)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1104105033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1104105033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1104105034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.75

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1104105033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 30 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 30)

				if (30 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 30)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1104105034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1104105034
		arg_139_1.duration_ = 6.53

		local var_139_0 = {
			zh = 6.133,
			ja = 6.533
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
				arg_139_0:Play1104105035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1041ui_story = arg_139_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).z)
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles = arg_139_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_139_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).z)
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles = arg_139_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1041ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1041ui_story == nil then
				arg_139_1.var_.characterEffect1041ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1041ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1041ui_story then
				arg_139_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_142_4 = 0
			local var_142_5 = 0.75

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(1104105034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 30 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 30)

				if (30 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 30)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105034", "story_v_side_new_1104105.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105034", "story_v_side_new_1104105.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_new_1104105", "1104105034", "story_v_side_new_1104105.awb")

						arg_139_1:RecordAudio("1104105034", var_142_11)
						arg_139_1:RecordAudio("1104105034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105034", "story_v_side_new_1104105.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105034", "story_v_side_new_1104105.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play1104105035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1104105035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1104105036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1041ui_story"]) and arg_143_1.var_.characterEffect1041ui_story == nil then
				arg_143_1.var_.characterEffect1041ui_story = arg_143_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1041ui_story"]) then
				if arg_143_1.var_.characterEffect1041ui_story and not isNil(arg_143_1.actors_["1041ui_story"]) then
					arg_143_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1041ui_story"]) and arg_143_1.var_.characterEffect1041ui_story then
				arg_143_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.925

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1104105035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 37 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 37)

				if (37 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 37)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1104105036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1104105036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1104105037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.4

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1104105036).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 16 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 16)

				if (16 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 16)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1104105037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1104105037
		arg_151_1.duration_ = 13.8

		local var_151_0 = {
			zh = 9.466,
			ja = 13.8
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
				arg_151_0:Play1104105038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1041ui_story = arg_151_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1041ui_story"].transform.position).z)
				arg_151_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1041ui_story"].transform.localEulerAngles = arg_151_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_151_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1041ui_story"].transform.position).z)
				arg_151_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1041ui_story"].transform.localEulerAngles = arg_151_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1041ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1041ui_story == nil then
				arg_151_1.var_.characterEffect1041ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1041ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1041ui_story then
				arg_151_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_154_4 = 0
			local var_154_5 = 1.075

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1104105037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 43 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 43)

				if (43 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 43)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105037", "story_v_side_new_1104105.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105037", "story_v_side_new_1104105.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1104105", "1104105037", "story_v_side_new_1104105.awb")

						arg_151_1:RecordAudio("1104105037", var_154_11)
						arg_151_1:RecordAudio("1104105037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105037", "story_v_side_new_1104105.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105037", "story_v_side_new_1104105.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play1104105038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1104105038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1104105039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1041ui_story"]) and arg_155_1.var_.characterEffect1041ui_story == nil then
				arg_155_1.var_.characterEffect1041ui_story = arg_155_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1041ui_story"]) then
				if arg_155_1.var_.characterEffect1041ui_story and not isNil(arg_155_1.actors_["1041ui_story"]) then
					arg_155_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1041ui_story"]) and arg_155_1.var_.characterEffect1041ui_story then
				arg_155_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.225

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1104105038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 9 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 9)

				if (9 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 9)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1104105039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1104105039
		arg_159_1.duration_ = 8.3

		local var_159_0 = {
			zh = 4.4,
			ja = 8.3
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
				arg_159_0:Play1104105040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1041ui_story = arg_159_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1041ui_story"].transform.position).z)
				arg_159_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1041ui_story"].transform.localEulerAngles = arg_159_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_159_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1041ui_story"].transform.position).z)
				arg_159_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1041ui_story"].transform.localEulerAngles = arg_159_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1041ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1041ui_story == nil then
				arg_159_1.var_.characterEffect1041ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1041ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1041ui_story then
				arg_159_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_4 = 0
			local var_162_5 = 0.6

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(1104105039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 24 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 24)

				if (24 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 24)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105039", "story_v_side_new_1104105.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105039", "story_v_side_new_1104105.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_side_new_1104105", "1104105039", "story_v_side_new_1104105.awb")

						arg_159_1:RecordAudio("1104105039", var_162_11)
						arg_159_1:RecordAudio("1104105039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105039", "story_v_side_new_1104105.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105039", "story_v_side_new_1104105.awb")
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
				actorName = "1041ui_story",
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
	Play1104105040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1104105040
		arg_163_1.duration_ = 1.5

		SetActive(arg_163_1.tipsGo_, true)

		arg_163_1.tipsText_.text = StoryTipsCfg[104101].name

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"

			SetActive(arg_163_1.choicesGo_, true)

			for iter_164_0, iter_164_1 in ipairs(arg_163_1.choices_) do
				SetActive(iter_164_1.go, iter_164_0 <= 2)
			end

			arg_163_1.choices_[1].txt.text = arg_163_1:FormatText(StoryChoiceCfg[628].name)
			arg_163_1.choices_[2].txt.text = arg_163_1:FormatText(StoryChoiceCfg[629].name)
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				PlayerAction.UseStoryTrigger(1041013, 210410105, 1104105040, 1)
				arg_163_0:Play1104105041(arg_163_1)
			end

			if arg_165_0 == 2 then
				PlayerAction.UseStoryTrigger(1041013, 210410105, 1104105040, 2)
				arg_163_0:Play1104105041(arg_163_1)
			end

			arg_163_1:RecordChoiceLog(1104105040, 628, 629)
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1041ui_story"]) and arg_163_1.var_.characterEffect1041ui_story == nil then
				arg_163_1.var_.characterEffect1041ui_story = arg_163_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1041ui_story"]) then
				if arg_163_1.var_.characterEffect1041ui_story and not isNil(arg_163_1.actors_["1041ui_story"]) then
					arg_163_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1041ui_story"]) and arg_163_1.var_.characterEffect1041ui_story then
				arg_163_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_1 + 1.5 and arg_163_1.time_ < var_166_1 + 1.5 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1104105041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1104105041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1104105042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.65

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

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1104105041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 26 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 26)

				if (26 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 26)) > 0 and var_170_0 < var_170_3 then
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
	Play1104105042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1104105042
		arg_171_1.duration_ = 8.47

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1104105043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.15

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(1104105042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 6 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 6)

				if (6 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 6)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105042", "story_v_side_new_1104105.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105042", "story_v_side_new_1104105.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_side_new_1104105", "1104105042", "story_v_side_new_1104105.awb")

						arg_171_1:RecordAudio("1104105042", var_174_6)
						arg_171_1:RecordAudio("1104105042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105042", "story_v_side_new_1104105.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105042", "story_v_side_new_1104105.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1104105043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1104105043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1104105044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1104105043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 20 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 20)

				if (20 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 20)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1104105044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1104105044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1104105045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.525

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
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

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1104105044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 21 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 21)

				if (21 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 21)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1104105045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1104105045
		arg_183_1.duration_ = 1

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1104105046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.05

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(1104105045)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 2 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 2)

				if (2 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 2)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105045", "story_v_side_new_1104105.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105045", "story_v_side_new_1104105.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_side_new_1104105", "1104105045", "story_v_side_new_1104105.awb")

						arg_183_1:RecordAudio("1104105045", var_186_6)
						arg_183_1:RecordAudio("1104105045", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105045", "story_v_side_new_1104105.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105045", "story_v_side_new_1104105.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1104105046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1104105046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1104105047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.175

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1104105046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 47 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 47)

				if (47 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 47)) > 0 and var_190_0 < var_190_3 then
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
	Play1104105047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1104105047
		arg_191_1.duration_ = 5.67

		local var_191_0 = {
			zh = 5.066,
			ja = 5.666
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
				arg_191_0:Play1104105048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1041ui_story = arg_191_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1041ui_story"].transform.position).z)
				arg_191_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1041ui_story"].transform.localEulerAngles = arg_191_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_191_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1041ui_story"].transform.position).z)
				arg_191_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1041ui_story"].transform.localEulerAngles = arg_191_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1041ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1041ui_story == nil then
				arg_191_1.var_.characterEffect1041ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1041ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1041ui_story then
				arg_191_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.9

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(1104105047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 36 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 36)

				if (36 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 36)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105047", "story_v_side_new_1104105.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105047", "story_v_side_new_1104105.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_side_new_1104105", "1104105047", "story_v_side_new_1104105.awb")

						arg_191_1:RecordAudio("1104105047", var_194_11)
						arg_191_1:RecordAudio("1104105047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105047", "story_v_side_new_1104105.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105047", "story_v_side_new_1104105.awb")
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
				actorName = "1041ui_story",
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
	Play1104105048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1104105048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1104105049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1041ui_story"]) and arg_195_1.var_.characterEffect1041ui_story == nil then
				arg_195_1.var_.characterEffect1041ui_story = arg_195_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1041ui_story"]) then
				if arg_195_1.var_.characterEffect1041ui_story and not isNil(arg_195_1.actors_["1041ui_story"]) then
					arg_195_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1041ui_story"]) and arg_195_1.var_.characterEffect1041ui_story then
				arg_195_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.575

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

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1104105048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 23 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 23)

				if (23 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 23)) > 0 and var_198_2 < var_198_5 then
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
	Play1104105049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1104105049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1104105050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.525

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

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1104105049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 61 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 61)

				if (61 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 61)) > 0 and var_202_0 < var_202_3 then
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
	Play1104105050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1104105050
		arg_203_1.duration_ = 4.6

		local var_203_0 = {
			zh = 4.6,
			ja = 4.266
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
				arg_203_0:Play1104105051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1041ui_story"]) and arg_203_1.var_.characterEffect1041ui_story == nil then
				arg_203_1.var_.characterEffect1041ui_story = arg_203_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1041ui_story"]) then
				if arg_203_1.var_.characterEffect1041ui_story and not isNil(arg_203_1.actors_["1041ui_story"]) then
					arg_203_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1041ui_story"]) and arg_203_1.var_.characterEffect1041ui_story then
				arg_203_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_206_2 = 0
			local var_206_3 = 0.7

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(1104105050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 28 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 28)

				if (28 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 28)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105050", "story_v_side_new_1104105.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105050", "story_v_side_new_1104105.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_new_1104105", "1104105050", "story_v_side_new_1104105.awb")

						arg_203_1:RecordAudio("1104105050", var_206_9)
						arg_203_1:RecordAudio("1104105050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105050", "story_v_side_new_1104105.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105050", "story_v_side_new_1104105.awb")
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
	Play1104105051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1104105051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1104105052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1041ui_story"]) and arg_207_1.var_.characterEffect1041ui_story == nil then
				arg_207_1.var_.characterEffect1041ui_story = arg_207_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1041ui_story"]) then
				if arg_207_1.var_.characterEffect1041ui_story and not isNil(arg_207_1.actors_["1041ui_story"]) then
					arg_207_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1041ui_story"]) and arg_207_1.var_.characterEffect1041ui_story then
				arg_207_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 1.3

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

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1104105051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 52 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 52)

				if (52 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 52)) > 0 and var_210_2 < var_210_5 then
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
	Play1104105052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1104105052
		arg_211_1.duration_ = 7.93

		local var_211_0 = {
			zh = 7.933,
			ja = 7.333
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1104105053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1041ui_story"]) and arg_211_1.var_.characterEffect1041ui_story == nil then
				arg_211_1.var_.characterEffect1041ui_story = arg_211_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1041ui_story"]) then
				if arg_211_1.var_.characterEffect1041ui_story and not isNil(arg_211_1.actors_["1041ui_story"]) then
					arg_211_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1041ui_story"]) and arg_211_1.var_.characterEffect1041ui_story then
				arg_211_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_214_2 = 0
			local var_214_3 = 0.925

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(1104105052)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 37 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 37)

				if (37 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 37)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105052", "story_v_side_new_1104105.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105052", "story_v_side_new_1104105.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_side_new_1104105", "1104105052", "story_v_side_new_1104105.awb")

						arg_211_1:RecordAudio("1104105052", var_214_9)
						arg_211_1:RecordAudio("1104105052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105052", "story_v_side_new_1104105.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105052", "story_v_side_new_1104105.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1104105053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1104105053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1104105054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1041ui_story"]) and arg_215_1.var_.characterEffect1041ui_story == nil then
				arg_215_1.var_.characterEffect1041ui_story = arg_215_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1041ui_story"]) then
				if arg_215_1.var_.characterEffect1041ui_story and not isNil(arg_215_1.actors_["1041ui_story"]) then
					arg_215_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1041ui_story"]) and arg_215_1.var_.characterEffect1041ui_story then
				arg_215_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.275

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1104105053).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 11 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 11)

				if (11 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 11)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1104105054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1104105054
		arg_219_1.duration_ = 3.87

		local var_219_0 = {
			zh = 3.866,
			ja = 3
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1104105055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1041ui_story"]) and arg_219_1.var_.characterEffect1041ui_story == nil then
				arg_219_1.var_.characterEffect1041ui_story = arg_219_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1041ui_story"]) then
				if arg_219_1.var_.characterEffect1041ui_story and not isNil(arg_219_1.actors_["1041ui_story"]) then
					arg_219_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1041ui_story"]) and arg_219_1.var_.characterEffect1041ui_story then
				arg_219_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_222_2 = 0
			local var_222_3 = 0.425

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(1104105054)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 17 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 17)

				if (17 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 17)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105054", "story_v_side_new_1104105.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105054", "story_v_side_new_1104105.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_side_new_1104105", "1104105054", "story_v_side_new_1104105.awb")

						arg_219_1:RecordAudio("1104105054", var_222_9)
						arg_219_1:RecordAudio("1104105054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105054", "story_v_side_new_1104105.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105054", "story_v_side_new_1104105.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1104105055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1104105055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1104105056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1041ui_story"]) and arg_223_1.var_.characterEffect1041ui_story == nil then
				arg_223_1.var_.characterEffect1041ui_story = arg_223_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1041ui_story"]) then
				if arg_223_1.var_.characterEffect1041ui_story and not isNil(arg_223_1.actors_["1041ui_story"]) then
					arg_223_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1041ui_story"]) and arg_223_1.var_.characterEffect1041ui_story then
				arg_223_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.475

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1104105055).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 19 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 19)

				if (19 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 19)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1104105056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1104105056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1104105057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.175

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1104105056).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 7 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 7)

				if (7 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 7)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1104105057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1104105057
		arg_231_1.duration_ = 6.23

		local var_231_0 = {
			zh = 5.3,
			ja = 6.233
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
				arg_231_0:Play1104105058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1041ui_story"]) and arg_231_1.var_.characterEffect1041ui_story == nil then
				arg_231_1.var_.characterEffect1041ui_story = arg_231_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1041ui_story"]) then
				if arg_231_1.var_.characterEffect1041ui_story and not isNil(arg_231_1.actors_["1041ui_story"]) then
					arg_231_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1041ui_story"]) and arg_231_1.var_.characterEffect1041ui_story then
				arg_231_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_1")
			end

			local var_234_2 = 0
			local var_234_3 = 0.525

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(1104105057)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 21 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 21)

				if (21 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 21)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105057", "story_v_side_new_1104105.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105057", "story_v_side_new_1104105.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_side_new_1104105", "1104105057", "story_v_side_new_1104105.awb")

						arg_231_1:RecordAudio("1104105057", var_234_9)
						arg_231_1:RecordAudio("1104105057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105057", "story_v_side_new_1104105.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105057", "story_v_side_new_1104105.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1104105058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1104105058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1104105059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1041ui_story"]) and arg_235_1.var_.characterEffect1041ui_story == nil then
				arg_235_1.var_.characterEffect1041ui_story = arg_235_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1041ui_story"]) then
				if arg_235_1.var_.characterEffect1041ui_story and not isNil(arg_235_1.actors_["1041ui_story"]) then
					arg_235_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1041ui_story"]) and arg_235_1.var_.characterEffect1041ui_story then
				arg_235_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.15

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(1104105058).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 6 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 6)

				if (6 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 6)) > 0 and var_238_2 < var_238_5 then
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
	Play1104105059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1104105059
		arg_239_1.duration_ = 12.27

		local var_239_0 = {
			zh = 8,
			ja = 12.266
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1104105060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1041ui_story = arg_239_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1041ui_story"].transform.position).z)
				arg_239_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1041ui_story"].transform.localEulerAngles = arg_239_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_239_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1041ui_story"].transform.position).z)
				arg_239_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1041ui_story"].transform.localEulerAngles = arg_239_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1041ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1041ui_story == nil then
				arg_239_1.var_.characterEffect1041ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1041ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1041ui_story then
				arg_239_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_4 = 0
			local var_242_5 = 0.775

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(1104105059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 31 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 31)

				if (31 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 31)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105059", "story_v_side_new_1104105.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105059", "story_v_side_new_1104105.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_side_new_1104105", "1104105059", "story_v_side_new_1104105.awb")

						arg_239_1:RecordAudio("1104105059", var_242_11)
						arg_239_1:RecordAudio("1104105059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105059", "story_v_side_new_1104105.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105059", "story_v_side_new_1104105.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play1104105060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1104105060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1104105061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1041ui_story"]) and arg_243_1.var_.characterEffect1041ui_story == nil then
				arg_243_1.var_.characterEffect1041ui_story = arg_243_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1041ui_story"]) then
				if arg_243_1.var_.characterEffect1041ui_story and not isNil(arg_243_1.actors_["1041ui_story"]) then
					arg_243_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1041ui_story"]) and arg_243_1.var_.characterEffect1041ui_story then
				arg_243_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.425

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
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

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1104105060).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 17 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 17)

				if (17 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 17)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1104105061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1104105061
		arg_247_1.duration_ = 7.8

		local var_247_0 = {
			zh = 7.8,
			ja = 3.9
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1104105062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1041ui_story"]) and arg_247_1.var_.characterEffect1041ui_story == nil then
				arg_247_1.var_.characterEffect1041ui_story = arg_247_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1041ui_story"]) then
				if arg_247_1.var_.characterEffect1041ui_story and not isNil(arg_247_1.actors_["1041ui_story"]) then
					arg_247_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1041ui_story"]) and arg_247_1.var_.characterEffect1041ui_story then
				arg_247_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_250_2 = 0
			local var_250_3 = 0.95

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(1104105061)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 38 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 38)

				if (38 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 38)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105061", "story_v_side_new_1104105.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105061", "story_v_side_new_1104105.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_side_new_1104105", "1104105061", "story_v_side_new_1104105.awb")

						arg_247_1:RecordAudio("1104105061", var_250_9)
						arg_247_1:RecordAudio("1104105061", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105061", "story_v_side_new_1104105.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105061", "story_v_side_new_1104105.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1104105062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1104105062
		arg_251_1.duration_ = 9.8

		local var_251_0 = {
			zh = 9.8,
			ja = 9.733
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1104105063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1041ui_story"]) and arg_251_1.var_.characterEffect1041ui_story == nil then
				arg_251_1.var_.characterEffect1041ui_story = arg_251_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1041ui_story"]) then
				if arg_251_1.var_.characterEffect1041ui_story and not isNil(arg_251_1.actors_["1041ui_story"]) then
					arg_251_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1041ui_story"]) and arg_251_1.var_.characterEffect1041ui_story then
				arg_251_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_254_2 = 0
			local var_254_3 = 1.2

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:GetWordFromCfg(1104105062)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 48 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 48)

				if (48 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 48)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105062", "story_v_side_new_1104105.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105062", "story_v_side_new_1104105.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_side_new_1104105", "1104105062", "story_v_side_new_1104105.awb")

						arg_251_1:RecordAudio("1104105062", var_254_9)
						arg_251_1:RecordAudio("1104105062", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105062", "story_v_side_new_1104105.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105062", "story_v_side_new_1104105.awb")
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
	Play1104105063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1104105063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1104105064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1041ui_story"]) and arg_255_1.var_.characterEffect1041ui_story == nil then
				arg_255_1.var_.characterEffect1041ui_story = arg_255_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1041ui_story"]) then
				if arg_255_1.var_.characterEffect1041ui_story and not isNil(arg_255_1.actors_["1041ui_story"]) then
					arg_255_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1041ui_story"]) and arg_255_1.var_.characterEffect1041ui_story then
				arg_255_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.325

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1104105063).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 13 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 13)

				if (13 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 13)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1104105064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1104105064
		arg_259_1.duration_ = 5.6

		local var_259_0 = {
			zh = 5.6,
			ja = 5.3
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
				arg_259_0:Play1104105065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1041ui_story"]) and arg_259_1.var_.characterEffect1041ui_story == nil then
				arg_259_1.var_.characterEffect1041ui_story = arg_259_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1041ui_story"]) then
				if arg_259_1.var_.characterEffect1041ui_story and not isNil(arg_259_1.actors_["1041ui_story"]) then
					arg_259_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1041ui_story"]) and arg_259_1.var_.characterEffect1041ui_story then
				arg_259_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_262_2 = 0
			local var_262_3 = 0.675

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:GetWordFromCfg(1104105064)
				local var_262_5 = arg_259_1:FormatText(var_262_4.content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 27 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 27)

				if (27 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 27)) > 0 and var_262_3 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105064", "story_v_side_new_1104105.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105064", "story_v_side_new_1104105.awb") / 1000

					if var_262_8 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_2
					end

					if var_262_4.prefab_name ~= "" and arg_259_1.actors_[var_262_4.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_4.prefab_name].transform, "story_v_side_new_1104105", "1104105064", "story_v_side_new_1104105.awb")

						arg_259_1:RecordAudio("1104105064", var_262_9)
						arg_259_1:RecordAudio("1104105064", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105064", "story_v_side_new_1104105.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105064", "story_v_side_new_1104105.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_10 and arg_259_1.time_ < var_262_2 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1104105065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1104105065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1104105066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1041ui_story"]) and arg_263_1.var_.characterEffect1041ui_story == nil then
				arg_263_1.var_.characterEffect1041ui_story = arg_263_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1041ui_story"]) then
				if arg_263_1.var_.characterEffect1041ui_story and not isNil(arg_263_1.actors_["1041ui_story"]) then
					arg_263_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1041ui_story"]) and arg_263_1.var_.characterEffect1041ui_story then
				arg_263_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.75

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1104105065).content)

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
	Play1104105066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1104105066
		arg_267_1.duration_ = 7.5

		local var_267_0 = {
			zh = 6.9,
			ja = 7.5
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1104105067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1041ui_story = arg_267_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1041ui_story"].transform.position).z)
				arg_267_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1041ui_story"].transform.localEulerAngles = arg_267_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_267_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1041ui_story"].transform.position).z)
				arg_267_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1041ui_story"].transform.localEulerAngles = arg_267_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1041ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1041ui_story == nil then
				arg_267_1.var_.characterEffect1041ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1041ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1041ui_story then
				arg_267_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_270_4 = 0
			local var_270_5 = 0.975

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(1104105066)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 39 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 39)

				if (39 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 39)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105066", "story_v_side_new_1104105.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105066", "story_v_side_new_1104105.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_side_new_1104105", "1104105066", "story_v_side_new_1104105.awb")

						arg_267_1:RecordAudio("1104105066", var_270_11)
						arg_267_1:RecordAudio("1104105066", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105066", "story_v_side_new_1104105.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105066", "story_v_side_new_1104105.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_12 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_12 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_12

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_12 and arg_267_1.time_ < var_270_4 + var_270_12 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play1104105067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1104105067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1104105068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1041ui_story"]) and arg_271_1.var_.characterEffect1041ui_story == nil then
				arg_271_1.var_.characterEffect1041ui_story = arg_271_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1041ui_story"]) then
				if arg_271_1.var_.characterEffect1041ui_story and not isNil(arg_271_1.actors_["1041ui_story"]) then
					arg_271_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1041ui_story"]) and arg_271_1.var_.characterEffect1041ui_story then
				arg_271_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_274_1 = 0
			local var_274_2 = 1.05

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1104105067).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 42 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 42)

				if (42 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 42)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1104105068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1104105068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1104105069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.725

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1104105068).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 69 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 69)

				if (69 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 69)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1104105069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1104105069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1104105070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 1.65

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1104105069).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 66 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 66)

				if (66 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 66)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1104105070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1104105070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1104105071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.225

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1104105070).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 49 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 49)

				if (49 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 49)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1104105071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1104105071
		arg_287_1.duration_ = 8.43

		local var_287_0 = {
			zh = 7.766,
			ja = 8.433
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
				arg_287_0:Play1104105072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1041ui_story = arg_287_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1041ui_story"].transform.position).z)
				arg_287_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1041ui_story"].transform.localEulerAngles = arg_287_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_287_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1041ui_story"].transform.position).z)
				arg_287_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1041ui_story"].transform.localEulerAngles = arg_287_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1041ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1041ui_story == nil then
				arg_287_1.var_.characterEffect1041ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1041ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1041ui_story then
				arg_287_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_290_4 = 0
			local var_290_5 = 0.975

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(1104105071)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 39 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 39)

				if (39 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 39)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105071", "story_v_side_new_1104105.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105071", "story_v_side_new_1104105.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_side_new_1104105", "1104105071", "story_v_side_new_1104105.awb")

						arg_287_1:RecordAudio("1104105071", var_290_11)
						arg_287_1:RecordAudio("1104105071", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105071", "story_v_side_new_1104105.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105071", "story_v_side_new_1104105.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play1104105072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1104105072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1104105073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1041ui_story"]) and arg_291_1.var_.characterEffect1041ui_story == nil then
				arg_291_1.var_.characterEffect1041ui_story = arg_291_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1041ui_story"]) then
				if arg_291_1.var_.characterEffect1041ui_story and not isNil(arg_291_1.actors_["1041ui_story"]) then
					arg_291_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1041ui_story"]) and arg_291_1.var_.characterEffect1041ui_story then
				arg_291_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.75

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

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1104105072).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 30 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 30)

				if (30 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 30)) > 0 and var_294_2 < var_294_5 then
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
	Play1104105073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1104105073
		arg_295_1.duration_ = 4.47

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1104105074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1041ui_story = arg_295_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1041ui_story"].transform.position).z)
				arg_295_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1041ui_story"].transform.localEulerAngles = arg_295_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_295_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1041ui_story"].transform.position).z)
				arg_295_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1041ui_story"].transform.localEulerAngles = arg_295_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1041ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1041ui_story == nil then
				arg_295_1.var_.characterEffect1041ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1041ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1041ui_story then
				arg_295_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_298_4 = 0
			local var_298_5 = 0.525

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(1104105073)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 21 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 21)

				if (21 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 21)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105073", "story_v_side_new_1104105.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105073", "story_v_side_new_1104105.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_side_new_1104105", "1104105073", "story_v_side_new_1104105.awb")

						arg_295_1:RecordAudio("1104105073", var_298_11)
						arg_295_1:RecordAudio("1104105073", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105073", "story_v_side_new_1104105.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105073", "story_v_side_new_1104105.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play1104105074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1104105074
		arg_299_1.duration_ = 7.27

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1104105075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if arg_299_1.bgs_.STblack == nil then
				local var_302_0 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_302_0.name = "STblack"
				var_302_0.transform.parent = arg_299_1.stage_.transform
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_.STblack = var_302_0
			end

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= 2 + arg_302_0 then
				local var_302_1 = arg_299_1.bgs_.STblack

				arg_299_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_2 = var_302_1:GetComponent("SpriteRenderer")

				if var_302_2 and var_302_2.sprite then
					local var_302_3 = 2 * (var_302_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_1.transform.localScale = Vector3.New(var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "STblack" then
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

			local var_302_9 = 0.266666666666667

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

			local var_302_12 = arg_299_1.actors_["1041ui_story"].transform

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= 2 + arg_302_0 then
				arg_299_1.var_.moveOldPos1041ui_story = var_302_12.localPosition
			end

			local var_302_13 = 0.001

			if 2 <= arg_299_1.time_ and arg_299_1.time_ < 2 + var_302_13 then
				var_302_12.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 2) / var_302_13)
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

			local var_302_14 = 2.26666666666667
			local var_302_15 = 0.05

			if 2.26666666666667 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
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

				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_17 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1104105074).content)

				arg_299_1.text_.text = var_302_17

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_19 = 2 <= 0 and var_302_15 or var_302_15 * (utf8.len(var_302_17) / 2)

				if (2 <= 0 and var_302_15 or var_302_15 * (utf8.len(var_302_17) / 2)) > 0 and var_302_15 < var_302_19 then
					arg_299_1.talkMaxDuration = var_302_19
					var_302_14 = var_302_14 + 0.3

					if var_302_19 + var_302_14 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_19 + var_302_14
					end
				end

				arg_299_1.text_.text = var_302_17
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_20 = var_302_14 + 0.3
			local var_302_21 = math.max(var_302_15, arg_299_1.talkMaxDuration)

			if var_302_14 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_20 + var_302_21 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_20) / var_302_21

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_20 + var_302_21 and arg_299_1.time_ < var_302_20 + var_302_21 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104105075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104105075
		arg_305_1.duration_ = 9.13

		local var_305_0 = {
			zh = 8.333,
			ja = 9.133
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1104105076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if arg_305_1.bgs_.ST24a == nil then
				local var_308_0 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST24a")
				var_308_0.name = "ST24a"
				var_308_0.transform.parent = arg_305_1.stage_.transform
				var_308_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_.ST24a = var_308_0
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				local var_308_1 = arg_305_1.bgs_.ST24a

				arg_305_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_308_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_2 = var_308_1:GetComponent("SpriteRenderer")

				if var_308_2 and var_308_2.sprite then
					local var_308_3 = 2 * (var_308_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_308_1.transform.localScale = Vector3.New(var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "ST24a" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_4 = 0

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_5 = 2

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_5 then
				local var_308_6 = Color.New(0, 0, 0)

				var_308_6.a = Mathf.Lerp(1, 0, (arg_305_1.time_ - var_308_4) / var_308_5)
				arg_305_1.mask_.color = var_308_6
			end

			if arg_305_1.time_ >= var_308_4 + var_308_5 and arg_305_1.time_ < var_308_4 + var_308_5 + arg_308_0 then
				local var_308_7 = Color.New(0, 0, 0)

				arg_305_1.mask_.enabled = false
				var_308_7.a = 0
				arg_305_1.mask_.color = var_308_7
			end

			local var_308_8 = arg_305_1.actors_["1041ui_story"].transform

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				arg_305_1.var_.moveOldPos1041ui_story = var_308_8.localPosition
			end

			local var_308_9 = 0.001

			if 2 <= arg_305_1.time_ and arg_305_1.time_ < 2 + var_308_9 then
				var_308_8.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_305_1.time_ - 2) / var_308_9)
				var_308_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_8.position).x, (manager.ui.mainCamera.transform.position - var_308_8.position).y, (manager.ui.mainCamera.transform.position - var_308_8.position).z)
				var_308_8.localEulerAngles.z = 0
				var_308_8.localEulerAngles.x = 0
				var_308_8.localEulerAngles = var_308_8.localEulerAngles
			end

			if arg_305_1.time_ >= 2 + var_308_9 and arg_305_1.time_ < 2 + var_308_9 + arg_308_0 then
				var_308_8.localPosition = Vector3.New(0, -1.11, -5.9)
				var_308_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_8.position).x, (manager.ui.mainCamera.transform.position - var_308_8.position).y, (manager.ui.mainCamera.transform.position - var_308_8.position).z)
				var_308_8.localEulerAngles.z = 0
				var_308_8.localEulerAngles.x = 0
				var_308_8.localEulerAngles = var_308_8.localEulerAngles
			end

			local var_308_10 = arg_305_1.actors_["1041ui_story"]

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 and not isNil(var_308_10) and arg_305_1.var_.characterEffect1041ui_story == nil then
				arg_305_1.var_.characterEffect1041ui_story = var_308_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_11 = 0.200000002980232

			if 2 <= arg_305_1.time_ and arg_305_1.time_ < 2 + var_308_11 and not isNil(var_308_10) then
				if arg_305_1.var_.characterEffect1041ui_story and not isNil(var_308_10) then
					arg_305_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 2 + var_308_11 and arg_305_1.time_ < 2 + var_308_11 + arg_308_0 and not isNil(var_308_10) and arg_305_1.var_.characterEffect1041ui_story then
				arg_305_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				arg_305_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				arg_305_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_13 = 2
			local var_308_14 = 0.7

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_13 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_15 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_15:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_16 = arg_305_1:GetWordFromCfg(1104105075)
				local var_308_17 = arg_305_1:FormatText(var_308_16.content)

				arg_305_1.text_.text = var_308_17

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_19 = 28 <= 0 and var_308_14 or var_308_14 * (utf8.len(var_308_17) / 28)

				if (28 <= 0 and var_308_14 or var_308_14 * (utf8.len(var_308_17) / 28)) > 0 and var_308_14 < var_308_19 then
					arg_305_1.talkMaxDuration = var_308_19
					var_308_13 = var_308_13 + 0.3

					if var_308_19 + var_308_13 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_13
					end
				end

				arg_305_1.text_.text = var_308_17
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105075", "story_v_side_new_1104105.awb") ~= 0 then
					local var_308_20 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105075", "story_v_side_new_1104105.awb") / 1000

					if var_308_20 + var_308_13 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_20 + var_308_13
					end

					if var_308_16.prefab_name ~= "" and arg_305_1.actors_[var_308_16.prefab_name] ~= nil then
						local var_308_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_16.prefab_name].transform, "story_v_side_new_1104105", "1104105075", "story_v_side_new_1104105.awb")

						arg_305_1:RecordAudio("1104105075", var_308_21)
						arg_305_1:RecordAudio("1104105075", var_308_21)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105075", "story_v_side_new_1104105.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105075", "story_v_side_new_1104105.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = var_308_13 + 0.3
			local var_308_23 = math.max(var_308_14, arg_305_1.talkMaxDuration)

			if var_308_13 + 0.3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_22 + var_308_23 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_22) / var_308_23

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_22 + var_308_23 and arg_305_1.time_ < var_308_22 + var_308_23 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play1104105076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1104105076
		arg_311_1.duration_ = 5.67

		local var_311_0 = {
			zh = 3.733,
			ja = 5.666
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
				arg_311_0:Play1104105077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1041ui_story = arg_311_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1041ui_story"].transform.position).z)
				arg_311_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1041ui_story"].transform.localEulerAngles = arg_311_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_311_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1041ui_story"].transform.position).z)
				arg_311_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1041ui_story"].transform.localEulerAngles = arg_311_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1041ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1041ui_story == nil then
				arg_311_1.var_.characterEffect1041ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1041ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1041ui_story then
				arg_311_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_314_4 = 0
			local var_314_5 = 0.475

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(1104105076)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 19 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 19)

				if (19 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 19)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105076", "story_v_side_new_1104105.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105076", "story_v_side_new_1104105.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_side_new_1104105", "1104105076", "story_v_side_new_1104105.awb")

						arg_311_1:RecordAudio("1104105076", var_314_11)
						arg_311_1:RecordAudio("1104105076", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105076", "story_v_side_new_1104105.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105076", "story_v_side_new_1104105.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_4) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_4 + var_314_12 and arg_311_1.time_ < var_314_4 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104105077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1104105077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1104105078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1041ui_story"]) and arg_315_1.var_.characterEffect1041ui_story == nil then
				arg_315_1.var_.characterEffect1041ui_story = arg_315_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1041ui_story"]) then
				if arg_315_1.var_.characterEffect1041ui_story and not isNil(arg_315_1.actors_["1041ui_story"]) then
					arg_315_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1041ui_story"]) and arg_315_1.var_.characterEffect1041ui_story then
				arg_315_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.725

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1104105077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 29 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 29)

				if (29 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 29)) > 0 and var_318_2 < var_318_5 then
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
	Play1104105078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1104105078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1104105079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.675

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1104105078).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 27 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 27)

				if (27 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 27)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1104105079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1104105079
		arg_323_1.duration_ = 5.23

		local var_323_0 = {
			zh = 2.133,
			ja = 5.233
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
				arg_323_0:Play1104105080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1041ui_story = arg_323_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1041ui_story"].transform.position).z)
				arg_323_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1041ui_story"].transform.localEulerAngles = arg_323_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_323_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1041ui_story"].transform.position).z)
				arg_323_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1041ui_story"].transform.localEulerAngles = arg_323_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1041ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1041ui_story == nil then
				arg_323_1.var_.characterEffect1041ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1041ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1041ui_story then
				arg_323_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_4 = 0
			local var_326_5 = 0.475

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(1104105079)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 19 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 19)

				if (19 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 19)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105079", "story_v_side_new_1104105.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105079", "story_v_side_new_1104105.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_side_new_1104105", "1104105079", "story_v_side_new_1104105.awb")

						arg_323_1:RecordAudio("1104105079", var_326_11)
						arg_323_1:RecordAudio("1104105079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105079", "story_v_side_new_1104105.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105079", "story_v_side_new_1104105.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1104105080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1104105080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1104105081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1041ui_story"]) and arg_327_1.var_.characterEffect1041ui_story == nil then
				arg_327_1.var_.characterEffect1041ui_story = arg_327_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1041ui_story"]) then
				if arg_327_1.var_.characterEffect1041ui_story and not isNil(arg_327_1.actors_["1041ui_story"]) then
					arg_327_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1041ui_story"]) and arg_327_1.var_.characterEffect1041ui_story then
				arg_327_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.575

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1104105080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 23 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 23)

				if (23 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 23)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1104105081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1104105081
		arg_331_1.duration_ = 6.6

		local var_331_0 = {
			zh = 5,
			ja = 6.6
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1104105082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1041ui_story = arg_331_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1041ui_story"].transform.position).z)
				arg_331_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1041ui_story"].transform.localEulerAngles = arg_331_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_331_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1041ui_story"].transform.position).z)
				arg_331_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1041ui_story"].transform.localEulerAngles = arg_331_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1041ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1041ui_story == nil then
				arg_331_1.var_.characterEffect1041ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1041ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1041ui_story then
				arg_331_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_334_4 = 0
			local var_334_5 = 1.05

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(1104105081)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 42 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 42)

				if (42 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 42)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105081", "story_v_side_new_1104105.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105081", "story_v_side_new_1104105.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_side_new_1104105", "1104105081", "story_v_side_new_1104105.awb")

						arg_331_1:RecordAudio("1104105081", var_334_11)
						arg_331_1:RecordAudio("1104105081", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105081", "story_v_side_new_1104105.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105081", "story_v_side_new_1104105.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play1104105082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1104105082
		arg_335_1.duration_ = 4.53

		local var_335_0 = {
			zh = 1.999999999999,
			ja = 4.533
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
				arg_335_0:Play1104105083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_338_0 = 0
			local var_338_1 = 0.15

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_2 = arg_335_1:GetWordFromCfg(1104105082)
				local var_338_3 = arg_335_1:FormatText(var_338_2.content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 6 <= 0 and var_338_1 or var_338_1 * (utf8.len(var_338_3) / 6)

				if (6 <= 0 and var_338_1 or var_338_1 * (utf8.len(var_338_3) / 6)) > 0 and var_338_1 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105082", "story_v_side_new_1104105.awb") ~= 0 then
					local var_338_6 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105082", "story_v_side_new_1104105.awb") / 1000

					if var_338_6 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_0
					end

					if var_338_2.prefab_name ~= "" and arg_335_1.actors_[var_338_2.prefab_name] ~= nil then
						local var_338_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_2.prefab_name].transform, "story_v_side_new_1104105", "1104105082", "story_v_side_new_1104105.awb")

						arg_335_1:RecordAudio("1104105082", var_338_7)
						arg_335_1:RecordAudio("1104105082", var_338_7)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105082", "story_v_side_new_1104105.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105082", "story_v_side_new_1104105.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1104105083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1104105083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1104105084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1041ui_story"]) and arg_339_1.var_.characterEffect1041ui_story == nil then
				arg_339_1.var_.characterEffect1041ui_story = arg_339_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1041ui_story"]) then
				if arg_339_1.var_.characterEffect1041ui_story and not isNil(arg_339_1.actors_["1041ui_story"]) then
					arg_339_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1041ui_story"]) and arg_339_1.var_.characterEffect1041ui_story then
				arg_339_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.225

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

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1104105083).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 9 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 9)

				if (9 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 9)) > 0 and var_342_2 < var_342_5 then
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
	Play1104105084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1104105084
		arg_343_1.duration_ = 8.47

		local var_343_0 = {
			zh = 6.6,
			ja = 8.466
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
				arg_343_0:Play1104105085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1041ui_story = arg_343_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1041ui_story"].transform.position).z)
				arg_343_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1041ui_story"].transform.localEulerAngles = arg_343_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_343_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1041ui_story"].transform.position).z)
				arg_343_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1041ui_story"].transform.localEulerAngles = arg_343_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["1041ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1041ui_story == nil then
				arg_343_1.var_.characterEffect1041ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect1041ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect1041ui_story then
				arg_343_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_346_4 = 0
			local var_346_5 = 1

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:GetWordFromCfg(1104105084)
				local var_346_7 = arg_343_1:FormatText(var_346_6.content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 40 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 40)

				if (40 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 40)) > 0 and var_346_5 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105084", "story_v_side_new_1104105.awb") ~= 0 then
					local var_346_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105084", "story_v_side_new_1104105.awb") / 1000

					if var_346_10 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_4
					end

					if var_346_6.prefab_name ~= "" and arg_343_1.actors_[var_346_6.prefab_name] ~= nil then
						local var_346_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_6.prefab_name].transform, "story_v_side_new_1104105", "1104105084", "story_v_side_new_1104105.awb")

						arg_343_1:RecordAudio("1104105084", var_346_11)
						arg_343_1:RecordAudio("1104105084", var_346_11)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105084", "story_v_side_new_1104105.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105084", "story_v_side_new_1104105.awb")
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
				actorName = "1041ui_story",
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
	Play1104105085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1104105085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1104105086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1041ui_story"]) and arg_347_1.var_.characterEffect1041ui_story == nil then
				arg_347_1.var_.characterEffect1041ui_story = arg_347_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1041ui_story"]) then
				if arg_347_1.var_.characterEffect1041ui_story and not isNil(arg_347_1.actors_["1041ui_story"]) then
					arg_347_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1041ui_story"]) and arg_347_1.var_.characterEffect1041ui_story then
				arg_347_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.85

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1104105085).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 34 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 34)

				if (34 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 34)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1104105086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1104105086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1104105087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.15

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1104105086).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 6 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 6)

				if (6 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 6)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1104105087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1104105087
		arg_355_1.duration_ = 9

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1104105088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 then
				local var_358_0 = arg_355_1.bgs_.ST24a

				arg_355_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_358_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_358_1 = var_358_0:GetComponent("SpriteRenderer")

				if var_358_1 and var_358_1.sprite then
					local var_358_2 = 2 * (var_358_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_358_0.transform.localScale = Vector3.New(var_358_2 / var_358_1.sprite.bounds.size.y < var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x and var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x or var_358_2 / var_358_1.sprite.bounds.size.y, var_358_2 / var_358_1.sprite.bounds.size.y < var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x and var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x or var_358_2 / var_358_1.sprite.bounds.size.y, 0)
				end

				for iter_358_0, iter_358_1 in pairs(arg_355_1.bgs_) do
					if iter_358_0 ~= "ST24a" then
						iter_358_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_358_3 = arg_355_1.actors_["1041ui_story"].transform

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 then
				arg_355_1.var_.moveOldPos1041ui_story = var_358_3.localPosition
			end

			local var_358_4 = 0.001

			if 2 <= arg_355_1.time_ and arg_355_1.time_ < 2 + var_358_4 then
				var_358_3.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_355_1.time_ - 2) / var_358_4)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			if arg_355_1.time_ >= 2 + var_358_4 and arg_355_1.time_ < 2 + var_358_4 + arg_358_0 then
				var_358_3.localPosition = Vector3.New(0, 100, 0)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			local var_358_5 = 0

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_6 = 2

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_6 then
				local var_358_7 = Color.New(0, 0, 0)

				var_358_7.a = Mathf.Lerp(0, 1, (arg_355_1.time_ - var_358_5) / var_358_6)
				arg_355_1.mask_.color = var_358_7
			end

			if arg_355_1.time_ >= var_358_5 + var_358_6 and arg_355_1.time_ < var_358_5 + var_358_6 + arg_358_0 then
				local var_358_8 = Color.New(0, 0, 0)

				var_358_8.a = 1
				arg_355_1.mask_.color = var_358_8
			end

			local var_358_9 = 2

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= var_358_9 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_10 = 2

			if var_358_9 <= arg_355_1.time_ and arg_355_1.time_ < var_358_9 + var_358_10 then
				local var_358_11 = Color.New(0, 0, 0)

				var_358_11.a = Mathf.Lerp(1, 0, (arg_355_1.time_ - var_358_9) / var_358_10)
				arg_355_1.mask_.color = var_358_11
			end

			if arg_355_1.time_ >= var_358_9 + var_358_10 and arg_355_1.time_ < var_358_9 + var_358_10 + arg_358_0 then
				local var_358_12 = Color.New(0, 0, 0)

				arg_355_1.mask_.enabled = false
				var_358_12.a = 0
				arg_355_1.mask_.color = var_358_12
			end

			if arg_355_1.frameCnt_ <= 1 then
				arg_355_1.dialog_:SetActive(false)
			end

			local var_358_13 = 4
			local var_358_14 = 2.025

			if 4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_13 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				arg_355_1.dialog_:SetActive(true)

				arg_355_1.dialogCg_.alpha = 0

				local var_358_15 = LeanTween.value(arg_355_1.dialog_, 0, 1, 0.3)

				var_358_15:setOnUpdate(LuaHelper.FloatAction(function(arg_359_0)
					arg_355_1.dialogCg_.alpha = arg_359_0
				end))
				var_358_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_355_1.dialog_)
					var_358_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_355_1.duration_ = arg_355_1.duration_ + 0.3

				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_16 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1104105087).content)

				arg_355_1.text_.text = var_358_16

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_18 = 81 <= 0 and var_358_14 or var_358_14 * (utf8.len(var_358_16) / 81)

				if (81 <= 0 and var_358_14 or var_358_14 * (utf8.len(var_358_16) / 81)) > 0 and var_358_14 < var_358_18 then
					arg_355_1.talkMaxDuration = var_358_18
					var_358_13 = var_358_13 + 0.3

					if var_358_18 + var_358_13 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_18 + var_358_13
					end
				end

				arg_355_1.text_.text = var_358_16
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_19 = var_358_13 + 0.3
			local var_358_20 = math.max(var_358_14, arg_355_1.talkMaxDuration)

			if var_358_13 + 0.3 <= arg_355_1.time_ and arg_355_1.time_ < var_358_19 + var_358_20 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_19) / var_358_20

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_19 + var_358_20 and arg_355_1.time_ < var_358_19 + var_358_20 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play1104105088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104105088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1104105089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 1.175

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1104105088).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 47 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 47)

				if (47 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 47)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1104105089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104105089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1104105090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.325

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1104105089).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 13 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 13)

				if (13 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 13)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1104105090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104105090
		arg_369_1.duration_ = 6.43

		local var_369_0 = {
			zh = 4.8,
			ja = 6.433
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
				arg_369_0:Play1104105091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1041ui_story = arg_369_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).z)
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles = arg_369_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_369_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).z)
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles = arg_369_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1041ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1041ui_story == nil then
				arg_369_1.var_.characterEffect1041ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1041ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1041ui_story then
				arg_369_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_372_4 = 0
			local var_372_5 = 0.6

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:GetWordFromCfg(1104105090)
				local var_372_7 = arg_369_1:FormatText(var_372_6.content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 24 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 24)

				if (24 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 24)) > 0 and var_372_5 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105090", "story_v_side_new_1104105.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105090", "story_v_side_new_1104105.awb") / 1000

					if var_372_10 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_4
					end

					if var_372_6.prefab_name ~= "" and arg_369_1.actors_[var_372_6.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_6.prefab_name].transform, "story_v_side_new_1104105", "1104105090", "story_v_side_new_1104105.awb")

						arg_369_1:RecordAudio("1104105090", var_372_11)
						arg_369_1:RecordAudio("1104105090", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105090", "story_v_side_new_1104105.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105090", "story_v_side_new_1104105.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_12 and arg_369_1.time_ < var_372_4 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play1104105091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104105091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1104105092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1041ui_story"]) and arg_373_1.var_.characterEffect1041ui_story == nil then
				arg_373_1.var_.characterEffect1041ui_story = arg_373_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1041ui_story"]) then
				if arg_373_1.var_.characterEffect1041ui_story and not isNil(arg_373_1.actors_["1041ui_story"]) then
					arg_373_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1041ui_story"]) and arg_373_1.var_.characterEffect1041ui_story then
				arg_373_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1041ui_story.fillRatio = 0.5
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

				local var_376_3 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1104105091).content)

				arg_373_1.text_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 22 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 22)

				if (22 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 22)) > 0 and var_376_2 < var_376_5 then
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
	Play1104105092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104105092
		arg_377_1.duration_ = 9.73

		local var_377_0 = {
			zh = 8,
			ja = 9.733
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
				arg_377_0:Play1104105093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1041ui_story = arg_377_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1041ui_story"].transform.position).z)
				arg_377_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1041ui_story"].transform.localEulerAngles = arg_377_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_377_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1041ui_story"].transform.position).z)
				arg_377_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1041ui_story"].transform.localEulerAngles = arg_377_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1041ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1041ui_story == nil then
				arg_377_1.var_.characterEffect1041ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1041ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1041ui_story then
				arg_377_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_380_4 = 0
			local var_380_5 = 1.375

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(1104105092)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 55 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 55)

				if (55 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 55)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105092", "story_v_side_new_1104105.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105092", "story_v_side_new_1104105.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_side_new_1104105", "1104105092", "story_v_side_new_1104105.awb")

						arg_377_1:RecordAudio("1104105092", var_380_11)
						arg_377_1:RecordAudio("1104105092", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105092", "story_v_side_new_1104105.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105092", "story_v_side_new_1104105.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104105093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1104105093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1104105094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1041ui_story"]) and arg_381_1.var_.characterEffect1041ui_story == nil then
				arg_381_1.var_.characterEffect1041ui_story = arg_381_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1041ui_story"]) then
				if arg_381_1.var_.characterEffect1041ui_story and not isNil(arg_381_1.actors_["1041ui_story"]) then
					arg_381_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_0)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1041ui_story"]) and arg_381_1.var_.characterEffect1041ui_story then
				arg_381_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_384_1 = 0
			local var_384_2 = 0.475

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(1104105093).content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 19 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_3) / 19)

				if (19 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_3) / 19)) > 0 and var_384_2 < var_384_5 then
					arg_381_1.talkMaxDuration = var_384_5

					if var_384_5 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_6 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_6 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_6

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_6 and arg_381_1.time_ < var_384_1 + var_384_6 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1104105094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1104105094
		arg_385_1.duration_ = 7.47

		local var_385_0 = {
			zh = 7.466,
			ja = 7.2
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1104105095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1041ui_story = arg_385_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1041ui_story"].transform.position).z)
				arg_385_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1041ui_story"].transform.localEulerAngles = arg_385_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_385_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1041ui_story"].transform.position).z)
				arg_385_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1041ui_story"].transform.localEulerAngles = arg_385_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1041ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1041ui_story == nil then
				arg_385_1.var_.characterEffect1041ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1041ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1041ui_story then
				arg_385_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_388_4 = 0
			local var_388_5 = 0.85

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(1104105094)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 34 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 34)

				if (34 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 34)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105094", "story_v_side_new_1104105.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105094", "story_v_side_new_1104105.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_side_new_1104105", "1104105094", "story_v_side_new_1104105.awb")

						arg_385_1:RecordAudio("1104105094", var_388_11)
						arg_385_1:RecordAudio("1104105094", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105094", "story_v_side_new_1104105.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105094", "story_v_side_new_1104105.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play1104105095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104105095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1104105096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1041ui_story"]) and arg_389_1.var_.characterEffect1041ui_story == nil then
				arg_389_1.var_.characterEffect1041ui_story = arg_389_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1041ui_story"]) then
				if arg_389_1.var_.characterEffect1041ui_story and not isNil(arg_389_1.actors_["1041ui_story"]) then
					arg_389_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1041ui_story"]) and arg_389_1.var_.characterEffect1041ui_story then
				arg_389_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 0.35

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(1104105095).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 14 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 14)

				if (14 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 14)) > 0 and var_392_2 < var_392_5 then
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

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1104105096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104105096
		arg_393_1.duration_ = 3.23

		local var_393_0 = {
			zh = 2.266,
			ja = 3.233
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104105097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1041ui_story = arg_393_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1041ui_story"].transform.position).z)
				arg_393_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1041ui_story"].transform.localEulerAngles = arg_393_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_393_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1041ui_story"].transform.position).z)
				arg_393_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1041ui_story"].transform.localEulerAngles = arg_393_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1041ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1041ui_story == nil then
				arg_393_1.var_.characterEffect1041ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1041ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1041ui_story then
				arg_393_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_396_4 = 0
			local var_396_5 = 0.1

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_6 = arg_393_1:GetWordFromCfg(1104105096)
				local var_396_7 = arg_393_1:FormatText(var_396_6.content)

				arg_393_1.text_.text = var_396_7

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_9 = 4 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 4)

				if (4 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 4)) > 0 and var_396_5 < var_396_9 then
					arg_393_1.talkMaxDuration = var_396_9

					if var_396_9 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_9 + var_396_4
					end
				end

				arg_393_1.text_.text = var_396_7
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105096", "story_v_side_new_1104105.awb") ~= 0 then
					local var_396_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105096", "story_v_side_new_1104105.awb") / 1000

					if var_396_10 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_4
					end

					if var_396_6.prefab_name ~= "" and arg_393_1.actors_[var_396_6.prefab_name] ~= nil then
						local var_396_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_6.prefab_name].transform, "story_v_side_new_1104105", "1104105096", "story_v_side_new_1104105.awb")

						arg_393_1:RecordAudio("1104105096", var_396_11)
						arg_393_1:RecordAudio("1104105096", var_396_11)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105096", "story_v_side_new_1104105.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105096", "story_v_side_new_1104105.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_12 = math.max(var_396_5, arg_393_1.talkMaxDuration)

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_12 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_4) / var_396_12

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_4 + var_396_12 and arg_393_1.time_ < var_396_4 + var_396_12 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1104105097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104105097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1104105098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1041ui_story"]) and arg_397_1.var_.characterEffect1041ui_story == nil then
				arg_397_1.var_.characterEffect1041ui_story = arg_397_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1041ui_story"]) then
				if arg_397_1.var_.characterEffect1041ui_story and not isNil(arg_397_1.actors_["1041ui_story"]) then
					arg_397_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1041ui_story"]) and arg_397_1.var_.characterEffect1041ui_story then
				arg_397_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_400_1 = 0
			local var_400_2 = 1.325

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1104105097).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 53 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 53)

				if (53 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 53)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1104105098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104105098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104105099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.175

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

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1104105098).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 7 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 7)

				if (7 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 7)) > 0 and var_404_0 < var_404_3 then
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
	Play1104105099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104105099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104105100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 1.225

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1104105099).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 49 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 49)

				if (49 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 49)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104105100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104105100
		arg_409_1.duration_ = 3.03

		local var_409_0 = {
			zh = 1.533,
			ja = 3.033
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104105101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1041ui_story"]) and arg_409_1.var_.characterEffect1041ui_story == nil then
				arg_409_1.var_.characterEffect1041ui_story = arg_409_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1041ui_story"]) then
				if arg_409_1.var_.characterEffect1041ui_story and not isNil(arg_409_1.actors_["1041ui_story"]) then
					arg_409_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1041ui_story"]) and arg_409_1.var_.characterEffect1041ui_story then
				arg_409_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_412_2 = 0
			local var_412_3 = 0.125

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:GetWordFromCfg(1104105100)
				local var_412_5 = arg_409_1:FormatText(var_412_4.content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 5 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 5)

				if (5 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 5)) > 0 and var_412_3 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105100", "story_v_side_new_1104105.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105100", "story_v_side_new_1104105.awb") / 1000

					if var_412_8 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_2
					end

					if var_412_4.prefab_name ~= "" and arg_409_1.actors_[var_412_4.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_4.prefab_name].transform, "story_v_side_new_1104105", "1104105100", "story_v_side_new_1104105.awb")

						arg_409_1:RecordAudio("1104105100", var_412_9)
						arg_409_1:RecordAudio("1104105100", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105100", "story_v_side_new_1104105.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105100", "story_v_side_new_1104105.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_10 and arg_409_1.time_ < var_412_2 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1104105101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104105101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104105102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1041ui_story"]) and arg_413_1.var_.characterEffect1041ui_story == nil then
				arg_413_1.var_.characterEffect1041ui_story = arg_413_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1041ui_story"]) then
				if arg_413_1.var_.characterEffect1041ui_story and not isNil(arg_413_1.actors_["1041ui_story"]) then
					arg_413_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1041ui_story"]) and arg_413_1.var_.characterEffect1041ui_story then
				arg_413_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 0.35

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1104105101).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 14 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 14)

				if (14 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 14)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1104105102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104105102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104105103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.675

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1104105102).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 27 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 27)

				if (27 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 27)) > 0 and var_420_0 < var_420_3 then
					arg_417_1.talkMaxDuration = var_420_3

					if var_420_3 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_3 + 0
					end
				end

				arg_417_1.text_.text = var_420_1
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_4 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_4

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1104105103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104105103
		arg_421_1.duration_ = 10.6

		local var_421_0 = {
			zh = 6.866,
			ja = 10.6
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104105104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1041ui_story"]) and arg_421_1.var_.characterEffect1041ui_story == nil then
				arg_421_1.var_.characterEffect1041ui_story = arg_421_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1041ui_story"]) then
				if arg_421_1.var_.characterEffect1041ui_story and not isNil(arg_421_1.actors_["1041ui_story"]) then
					arg_421_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1041ui_story"]) and arg_421_1.var_.characterEffect1041ui_story then
				arg_421_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_424_2 = 0
			local var_424_3 = 0.725

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_4 = arg_421_1:GetWordFromCfg(1104105103)
				local var_424_5 = arg_421_1:FormatText(var_424_4.content)

				arg_421_1.text_.text = var_424_5

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_7 = 29 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_5) / 29)

				if (29 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_5) / 29)) > 0 and var_424_3 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_2 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_2
					end
				end

				arg_421_1.text_.text = var_424_5
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105103", "story_v_side_new_1104105.awb") ~= 0 then
					local var_424_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105103", "story_v_side_new_1104105.awb") / 1000

					if var_424_8 + var_424_2 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_8 + var_424_2
					end

					if var_424_4.prefab_name ~= "" and arg_421_1.actors_[var_424_4.prefab_name] ~= nil then
						local var_424_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_4.prefab_name].transform, "story_v_side_new_1104105", "1104105103", "story_v_side_new_1104105.awb")

						arg_421_1:RecordAudio("1104105103", var_424_9)
						arg_421_1:RecordAudio("1104105103", var_424_9)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105103", "story_v_side_new_1104105.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105103", "story_v_side_new_1104105.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_10 = math.max(var_424_3, arg_421_1.talkMaxDuration)

			if var_424_2 <= arg_421_1.time_ and arg_421_1.time_ < var_424_2 + var_424_10 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_2) / var_424_10

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_2 + var_424_10 and arg_421_1.time_ < var_424_2 + var_424_10 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1104105104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104105104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104105105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1041ui_story"]) and arg_425_1.var_.characterEffect1041ui_story == nil then
				arg_425_1.var_.characterEffect1041ui_story = arg_425_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1041ui_story"]) then
				if arg_425_1.var_.characterEffect1041ui_story and not isNil(arg_425_1.actors_["1041ui_story"]) then
					arg_425_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1041ui_story"]) and arg_425_1.var_.characterEffect1041ui_story then
				arg_425_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 0.075

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
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

				local var_428_3 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1104105104).content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 3 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 3)

				if (3 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 3)) > 0 and var_428_2 < var_428_5 then
					arg_425_1.talkMaxDuration = var_428_5

					if var_428_5 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_6 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_6 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_6

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_6 and arg_425_1.time_ < var_428_1 + var_428_6 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104105105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104105105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104105106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.95

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1104105105).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 38 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 38)

				if (38 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 38)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104105106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104105106
		arg_433_1.duration_ = 7.53

		local var_433_0 = {
			zh = 6.866,
			ja = 7.533
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104105107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1041ui_story"]) and arg_433_1.var_.characterEffect1041ui_story == nil then
				arg_433_1.var_.characterEffect1041ui_story = arg_433_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1041ui_story"]) then
				if arg_433_1.var_.characterEffect1041ui_story and not isNil(arg_433_1.actors_["1041ui_story"]) then
					arg_433_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1041ui_story"]) and arg_433_1.var_.characterEffect1041ui_story then
				arg_433_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_436_2 = 0
			local var_436_3 = 0.9

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_2 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_4 = arg_433_1:GetWordFromCfg(1104105106)
				local var_436_5 = arg_433_1:FormatText(var_436_4.content)

				arg_433_1.text_.text = var_436_5

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_7 = 36 <= 0 and var_436_3 or var_436_3 * (utf8.len(var_436_5) / 36)

				if (36 <= 0 and var_436_3 or var_436_3 * (utf8.len(var_436_5) / 36)) > 0 and var_436_3 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_2 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_2
					end
				end

				arg_433_1.text_.text = var_436_5
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105106", "story_v_side_new_1104105.awb") ~= 0 then
					local var_436_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105106", "story_v_side_new_1104105.awb") / 1000

					if var_436_8 + var_436_2 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_8 + var_436_2
					end

					if var_436_4.prefab_name ~= "" and arg_433_1.actors_[var_436_4.prefab_name] ~= nil then
						local var_436_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_4.prefab_name].transform, "story_v_side_new_1104105", "1104105106", "story_v_side_new_1104105.awb")

						arg_433_1:RecordAudio("1104105106", var_436_9)
						arg_433_1:RecordAudio("1104105106", var_436_9)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105106", "story_v_side_new_1104105.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105106", "story_v_side_new_1104105.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_10 = math.max(var_436_3, arg_433_1.talkMaxDuration)

			if var_436_2 <= arg_433_1.time_ and arg_433_1.time_ < var_436_2 + var_436_10 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_2) / var_436_10

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_2 + var_436_10 and arg_433_1.time_ < var_436_2 + var_436_10 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104105107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104105107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104105108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1041ui_story"]) and arg_437_1.var_.characterEffect1041ui_story == nil then
				arg_437_1.var_.characterEffect1041ui_story = arg_437_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1041ui_story"]) then
				if arg_437_1.var_.characterEffect1041ui_story and not isNil(arg_437_1.actors_["1041ui_story"]) then
					arg_437_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1041ui_story"]) and arg_437_1.var_.characterEffect1041ui_story then
				arg_437_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.925

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1104105107).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 37 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 37)

				if (37 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 37)) > 0 and var_440_2 < var_440_5 then
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
	Play1104105108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104105108
		arg_441_1.duration_ = 6.7

		local var_441_0 = {
			zh = 5.9,
			ja = 6.7
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
				arg_441_0:Play1104105109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1041ui_story"]) and arg_441_1.var_.characterEffect1041ui_story == nil then
				arg_441_1.var_.characterEffect1041ui_story = arg_441_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1041ui_story"]) then
				if arg_441_1.var_.characterEffect1041ui_story and not isNil(arg_441_1.actors_["1041ui_story"]) then
					arg_441_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1041ui_story"]) and arg_441_1.var_.characterEffect1041ui_story then
				arg_441_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_444_2 = 0
			local var_444_3 = 0.675

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_4 = arg_441_1:GetWordFromCfg(1104105108)
				local var_444_5 = arg_441_1:FormatText(var_444_4.content)

				arg_441_1.text_.text = var_444_5

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_7 = 27 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 27)

				if (27 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 27)) > 0 and var_444_3 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_5
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105108", "story_v_side_new_1104105.awb") ~= 0 then
					local var_444_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105108", "story_v_side_new_1104105.awb") / 1000

					if var_444_8 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_2
					end

					if var_444_4.prefab_name ~= "" and arg_441_1.actors_[var_444_4.prefab_name] ~= nil then
						local var_444_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_4.prefab_name].transform, "story_v_side_new_1104105", "1104105108", "story_v_side_new_1104105.awb")

						arg_441_1:RecordAudio("1104105108", var_444_9)
						arg_441_1:RecordAudio("1104105108", var_444_9)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105108", "story_v_side_new_1104105.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105108", "story_v_side_new_1104105.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_10 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_10 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_10

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_10 and arg_441_1.time_ < var_444_2 + var_444_10 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104105109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104105109
		arg_445_1.duration_ = 18.13

		local var_445_0 = {
			zh = 17.266,
			ja = 18.133
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104105110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 1.9

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:GetWordFromCfg(1104105109)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 76 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 76)

				if (76 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 76)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105109", "story_v_side_new_1104105.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105109", "story_v_side_new_1104105.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_side_new_1104105", "1104105109", "story_v_side_new_1104105.awb")

						arg_445_1:RecordAudio("1104105109", var_448_6)
						arg_445_1:RecordAudio("1104105109", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105109", "story_v_side_new_1104105.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105109", "story_v_side_new_1104105.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104105110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104105110
		arg_449_1.duration_ = 11.17

		local var_449_0 = {
			zh = 11.166,
			ja = 8.3
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104105111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 1.325

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(1104105110)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 53 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 53)

				if (53 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 53)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105110", "story_v_side_new_1104105.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105110", "story_v_side_new_1104105.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_side_new_1104105", "1104105110", "story_v_side_new_1104105.awb")

						arg_449_1:RecordAudio("1104105110", var_452_6)
						arg_449_1:RecordAudio("1104105110", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105110", "story_v_side_new_1104105.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105110", "story_v_side_new_1104105.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104105111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104105111
		arg_453_1.duration_ = 5.37

		local var_453_0 = {
			zh = 5.033,
			ja = 5.366
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104105112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_456_0 = 0
			local var_456_1 = 0.575

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(1104105111)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 23 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 23)

				if (23 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 23)) > 0 and var_456_1 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105111", "story_v_side_new_1104105.awb") ~= 0 then
					local var_456_6 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105111", "story_v_side_new_1104105.awb") / 1000

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end

					if var_456_2.prefab_name ~= "" and arg_453_1.actors_[var_456_2.prefab_name] ~= nil then
						local var_456_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_2.prefab_name].transform, "story_v_side_new_1104105", "1104105111", "story_v_side_new_1104105.awb")

						arg_453_1:RecordAudio("1104105111", var_456_7)
						arg_453_1:RecordAudio("1104105111", var_456_7)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105111", "story_v_side_new_1104105.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105111", "story_v_side_new_1104105.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104105112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104105112
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104105113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1041ui_story"]) and arg_457_1.var_.characterEffect1041ui_story == nil then
				arg_457_1.var_.characterEffect1041ui_story = arg_457_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1041ui_story"]) then
				if arg_457_1.var_.characterEffect1041ui_story and not isNil(arg_457_1.actors_["1041ui_story"]) then
					arg_457_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1041ui_story"]) and arg_457_1.var_.characterEffect1041ui_story then
				arg_457_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.225

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1104105112).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 9 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 9)

				if (9 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 9)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_6 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_6 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_6

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_6 and arg_457_1.time_ < var_460_1 + var_460_6 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104105113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104105113
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104105114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.525

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1104105113).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 21 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 21)

				if (21 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 21)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104105114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104105114
		arg_465_1.duration_ = 5.7

		local var_465_0 = {
			zh = 3.133,
			ja = 5.7
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104105115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1041ui_story = arg_465_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).z)
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles = arg_465_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_465_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).z)
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles = arg_465_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1041ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1041ui_story == nil then
				arg_465_1.var_.characterEffect1041ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1041ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1041ui_story then
				arg_465_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_468_4 = 0
			local var_468_5 = 0.625

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(1104105114)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 25 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 25)

				if (25 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 25)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105114", "story_v_side_new_1104105.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105114", "story_v_side_new_1104105.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_side_new_1104105", "1104105114", "story_v_side_new_1104105.awb")

						arg_465_1:RecordAudio("1104105114", var_468_11)
						arg_465_1:RecordAudio("1104105114", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105114", "story_v_side_new_1104105.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105114", "story_v_side_new_1104105.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104105115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104105115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104105116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1041ui_story"]) and arg_469_1.var_.characterEffect1041ui_story == nil then
				arg_469_1.var_.characterEffect1041ui_story = arg_469_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1041ui_story"]) then
				if arg_469_1.var_.characterEffect1041ui_story and not isNil(arg_469_1.actors_["1041ui_story"]) then
					arg_469_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1041ui_story"]) and arg_469_1.var_.characterEffect1041ui_story then
				arg_469_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.725

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1104105115).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 29 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 29)

				if (29 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 29)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104105116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104105116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104105117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 1.075

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1104105116).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 43 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 43)

				if (43 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 43)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104105117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104105117
		arg_477_1.duration_ = 14.5

		local var_477_0 = {
			zh = 14.5,
			ja = 13.7
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104105118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1041ui_story = arg_477_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1041ui_story"].transform.position).z)
				arg_477_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1041ui_story"].transform.localEulerAngles = arg_477_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_477_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1041ui_story"].transform.position).z)
				arg_477_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1041ui_story"].transform.localEulerAngles = arg_477_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1041ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1041ui_story == nil then
				arg_477_1.var_.characterEffect1041ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1041ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1041ui_story then
				arg_477_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_2")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_4 = 0
			local var_480_5 = 1.525

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(1104105117)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 61 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 61)

				if (61 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 61)) > 0 and var_480_5 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105117", "story_v_side_new_1104105.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105117", "story_v_side_new_1104105.awb") / 1000

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end

					if var_480_6.prefab_name ~= "" and arg_477_1.actors_[var_480_6.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_6.prefab_name].transform, "story_v_side_new_1104105", "1104105117", "story_v_side_new_1104105.awb")

						arg_477_1:RecordAudio("1104105117", var_480_11)
						arg_477_1:RecordAudio("1104105117", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105117", "story_v_side_new_1104105.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105117", "story_v_side_new_1104105.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_12 and arg_477_1.time_ < var_480_4 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104105118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104105118
		arg_481_1.duration_ = 13.63

		local var_481_0 = {
			zh = 12.166,
			ja = 13.633
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104105119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 1.425

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:GetWordFromCfg(1104105118)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 57 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 57)

				if (57 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 57)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105118", "story_v_side_new_1104105.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105118", "story_v_side_new_1104105.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_side_new_1104105", "1104105118", "story_v_side_new_1104105.awb")

						arg_481_1:RecordAudio("1104105118", var_484_6)
						arg_481_1:RecordAudio("1104105118", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105118", "story_v_side_new_1104105.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105118", "story_v_side_new_1104105.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104105119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104105119
		arg_485_1.duration_ = 17.33

		local var_485_0 = {
			zh = 17.333,
			ja = 13.233
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104105120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 1.625

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:GetWordFromCfg(1104105119)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 65 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 65)

				if (65 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 65)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105119", "story_v_side_new_1104105.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105119", "story_v_side_new_1104105.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_side_new_1104105", "1104105119", "story_v_side_new_1104105.awb")

						arg_485_1:RecordAudio("1104105119", var_488_6)
						arg_485_1:RecordAudio("1104105119", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105119", "story_v_side_new_1104105.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105119", "story_v_side_new_1104105.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104105120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104105120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104105121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1041ui_story"]) and arg_489_1.var_.characterEffect1041ui_story == nil then
				arg_489_1.var_.characterEffect1041ui_story = arg_489_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1041ui_story"]) then
				if arg_489_1.var_.characterEffect1041ui_story and not isNil(arg_489_1.actors_["1041ui_story"]) then
					arg_489_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1041ui_story"]) and arg_489_1.var_.characterEffect1041ui_story then
				arg_489_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_492_1 = 0
			local var_492_2 = 0.4

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1104105120).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 16 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 16)

				if (16 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 16)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104105121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104105121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104105122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.5

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1104105121).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 20 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 20)

				if (20 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 20)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104105122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104105122
		arg_497_1.duration_ = 17.53

		local var_497_0 = {
			zh = 10.4,
			ja = 17.533
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104105123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1041ui_story = arg_497_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).z)
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles = arg_497_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_497_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).z)
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles = arg_497_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_500_1 = arg_497_1.actors_["1041ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1041ui_story == nil then
				arg_497_1.var_.characterEffect1041ui_story = var_500_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_2 and not isNil(var_500_1) then
				if arg_497_1.var_.characterEffect1041ui_story and not isNil(var_500_1) then
					arg_497_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_2 and arg_497_1.time_ < 0 + var_500_2 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1041ui_story then
				arg_497_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_500_4 = 0
			local var_500_5 = 1.125

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_6 = arg_497_1:GetWordFromCfg(1104105122)
				local var_500_7 = arg_497_1:FormatText(var_500_6.content)

				arg_497_1.text_.text = var_500_7

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_9 = 45 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 45)

				if (45 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 45)) > 0 and var_500_5 < var_500_9 then
					arg_497_1.talkMaxDuration = var_500_9

					if var_500_9 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_4
					end
				end

				arg_497_1.text_.text = var_500_7
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105122", "story_v_side_new_1104105.awb") ~= 0 then
					local var_500_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105122", "story_v_side_new_1104105.awb") / 1000

					if var_500_10 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_10 + var_500_4
					end

					if var_500_6.prefab_name ~= "" and arg_497_1.actors_[var_500_6.prefab_name] ~= nil then
						local var_500_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_6.prefab_name].transform, "story_v_side_new_1104105", "1104105122", "story_v_side_new_1104105.awb")

						arg_497_1:RecordAudio("1104105122", var_500_11)
						arg_497_1:RecordAudio("1104105122", var_500_11)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105122", "story_v_side_new_1104105.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105122", "story_v_side_new_1104105.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_12 = math.max(var_500_5, arg_497_1.talkMaxDuration)

			if var_500_4 <= arg_497_1.time_ and arg_497_1.time_ < var_500_4 + var_500_12 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_4) / var_500_12

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_4 + var_500_12 and arg_497_1.time_ < var_500_4 + var_500_12 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play1104105123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104105123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104105124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1041ui_story"]) and arg_501_1.var_.characterEffect1041ui_story == nil then
				arg_501_1.var_.characterEffect1041ui_story = arg_501_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1041ui_story"]) then
				if arg_501_1.var_.characterEffect1041ui_story and not isNil(arg_501_1.actors_["1041ui_story"]) then
					arg_501_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_0)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1041ui_story"]) and arg_501_1.var_.characterEffect1041ui_story then
				arg_501_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_504_1 = 0
			local var_504_2 = 1.05

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1104105123).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 42 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 42)

				if (42 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 42)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104105124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104105124
		arg_505_1.duration_ = 9.53

		local var_505_0 = {
			zh = 6.1,
			ja = 9.533
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104105125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1041ui_story"]) and arg_505_1.var_.characterEffect1041ui_story == nil then
				arg_505_1.var_.characterEffect1041ui_story = arg_505_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1041ui_story"]) then
				if arg_505_1.var_.characterEffect1041ui_story and not isNil(arg_505_1.actors_["1041ui_story"]) then
					arg_505_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1041ui_story"]) and arg_505_1.var_.characterEffect1041ui_story then
				arg_505_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_508_2 = 0
			local var_508_3 = 0.575

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_2 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_4 = arg_505_1:GetWordFromCfg(1104105124)
				local var_508_5 = arg_505_1:FormatText(var_508_4.content)

				arg_505_1.text_.text = var_508_5

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_7 = 23 <= 0 and var_508_3 or var_508_3 * (utf8.len(var_508_5) / 23)

				if (23 <= 0 and var_508_3 or var_508_3 * (utf8.len(var_508_5) / 23)) > 0 and var_508_3 < var_508_7 then
					arg_505_1.talkMaxDuration = var_508_7

					if var_508_7 + var_508_2 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_7 + var_508_2
					end
				end

				arg_505_1.text_.text = var_508_5
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105124", "story_v_side_new_1104105.awb") ~= 0 then
					local var_508_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105124", "story_v_side_new_1104105.awb") / 1000

					if var_508_8 + var_508_2 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_8 + var_508_2
					end

					if var_508_4.prefab_name ~= "" and arg_505_1.actors_[var_508_4.prefab_name] ~= nil then
						local var_508_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_4.prefab_name].transform, "story_v_side_new_1104105", "1104105124", "story_v_side_new_1104105.awb")

						arg_505_1:RecordAudio("1104105124", var_508_9)
						arg_505_1:RecordAudio("1104105124", var_508_9)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105124", "story_v_side_new_1104105.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105124", "story_v_side_new_1104105.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_10 = math.max(var_508_3, arg_505_1.talkMaxDuration)

			if var_508_2 <= arg_505_1.time_ and arg_505_1.time_ < var_508_2 + var_508_10 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_2) / var_508_10

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_2 + var_508_10 and arg_505_1.time_ < var_508_2 + var_508_10 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104105125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1104105125
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1104105126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["1041ui_story"]) and arg_509_1.var_.characterEffect1041ui_story == nil then
				arg_509_1.var_.characterEffect1041ui_story = arg_509_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_0 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["1041ui_story"]) then
				if arg_509_1.var_.characterEffect1041ui_story and not isNil(arg_509_1.actors_["1041ui_story"]) then
					arg_509_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_0)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["1041ui_story"]) and arg_509_1.var_.characterEffect1041ui_story then
				arg_509_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_512_1 = 0
			local var_512_2 = 0.8

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(1104105125).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 32 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 32)

				if (32 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 32)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1104105126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1104105126
		arg_513_1.duration_ = 5.33

		local var_513_0 = {
			zh = 4.933,
			ja = 5.333
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
				arg_513_0:Play1104105127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1041ui_story"]) and arg_513_1.var_.characterEffect1041ui_story == nil then
				arg_513_1.var_.characterEffect1041ui_story = arg_513_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1041ui_story"]) then
				if arg_513_1.var_.characterEffect1041ui_story and not isNil(arg_513_1.actors_["1041ui_story"]) then
					arg_513_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1041ui_story"]) and arg_513_1.var_.characterEffect1041ui_story then
				arg_513_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_516_2 = 0
			local var_516_3 = 0.4

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_4 = arg_513_1:GetWordFromCfg(1104105126)
				local var_516_5 = arg_513_1:FormatText(var_516_4.content)

				arg_513_1.text_.text = var_516_5

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_7 = 16 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_5) / 16)

				if (16 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_5) / 16)) > 0 and var_516_3 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_2
					end
				end

				arg_513_1.text_.text = var_516_5
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105126", "story_v_side_new_1104105.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105126", "story_v_side_new_1104105.awb") / 1000

					if var_516_8 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_2
					end

					if var_516_4.prefab_name ~= "" and arg_513_1.actors_[var_516_4.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_4.prefab_name].transform, "story_v_side_new_1104105", "1104105126", "story_v_side_new_1104105.awb")

						arg_513_1:RecordAudio("1104105126", var_516_9)
						arg_513_1:RecordAudio("1104105126", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105126", "story_v_side_new_1104105.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105126", "story_v_side_new_1104105.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_3, arg_513_1.talkMaxDuration)

			if var_516_2 <= arg_513_1.time_ and arg_513_1.time_ < var_516_2 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_2) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_2 + var_516_10 and arg_513_1.time_ < var_516_2 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1104105127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104105127
		arg_517_1.duration_ = 15.67

		local var_517_0 = {
			zh = 15.666,
			ja = 12.633
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104105128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 1.6

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:GetWordFromCfg(1104105127)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 64 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 64)

				if (64 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 64)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105127", "story_v_side_new_1104105.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105127", "story_v_side_new_1104105.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_side_new_1104105", "1104105127", "story_v_side_new_1104105.awb")

						arg_517_1:RecordAudio("1104105127", var_520_6)
						arg_517_1:RecordAudio("1104105127", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105127", "story_v_side_new_1104105.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105127", "story_v_side_new_1104105.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104105128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104105128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1104105129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1041ui_story"]) and arg_521_1.var_.characterEffect1041ui_story == nil then
				arg_521_1.var_.characterEffect1041ui_story = arg_521_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1041ui_story"]) then
				if arg_521_1.var_.characterEffect1041ui_story and not isNil(arg_521_1.actors_["1041ui_story"]) then
					arg_521_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1041ui_story"]) and arg_521_1.var_.characterEffect1041ui_story then
				arg_521_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_524_1 = 0
			local var_524_2 = 0.675

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1104105128).content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 27 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 27)

				if (27 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 27)) > 0 and var_524_2 < var_524_5 then
					arg_521_1.talkMaxDuration = var_524_5

					if var_524_5 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + var_524_1
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_6 = math.max(var_524_2, arg_521_1.talkMaxDuration)

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_6 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_1) / var_524_6

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_1 + var_524_6 and arg_521_1.time_ < var_524_1 + var_524_6 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1104105129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1104105129
		arg_525_1.duration_ = 14

		local var_525_0 = {
			zh = 10.166,
			ja = 14
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
				arg_525_0:Play1104105130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos1041ui_story = arg_525_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_528_0 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 then
				arg_525_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_525_1.time_ - 0) / var_528_0)
				arg_525_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).z)
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles = arg_525_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 then
				arg_525_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_525_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).z)
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles = arg_525_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_528_1 = arg_525_1.actors_["1041ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1041ui_story == nil then
				arg_525_1.var_.characterEffect1041ui_story = var_528_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_2 and not isNil(var_528_1) then
				if arg_525_1.var_.characterEffect1041ui_story and not isNil(var_528_1) then
					arg_525_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_2 and arg_525_1.time_ < 0 + var_528_2 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1041ui_story then
				arg_525_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_528_4 = 0
			local var_528_5 = 1.025

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_6 = arg_525_1:GetWordFromCfg(1104105129)
				local var_528_7 = arg_525_1:FormatText(var_528_6.content)

				arg_525_1.text_.text = var_528_7

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_9 = 41 <= 0 and var_528_5 or var_528_5 * (utf8.len(var_528_7) / 41)

				if (41 <= 0 and var_528_5 or var_528_5 * (utf8.len(var_528_7) / 41)) > 0 and var_528_5 < var_528_9 then
					arg_525_1.talkMaxDuration = var_528_9

					if var_528_9 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_9 + var_528_4
					end
				end

				arg_525_1.text_.text = var_528_7
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105129", "story_v_side_new_1104105.awb") ~= 0 then
					local var_528_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105129", "story_v_side_new_1104105.awb") / 1000

					if var_528_10 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_10 + var_528_4
					end

					if var_528_6.prefab_name ~= "" and arg_525_1.actors_[var_528_6.prefab_name] ~= nil then
						local var_528_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_6.prefab_name].transform, "story_v_side_new_1104105", "1104105129", "story_v_side_new_1104105.awb")

						arg_525_1:RecordAudio("1104105129", var_528_11)
						arg_525_1:RecordAudio("1104105129", var_528_11)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105129", "story_v_side_new_1104105.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105129", "story_v_side_new_1104105.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_12 = math.max(var_528_5, arg_525_1.talkMaxDuration)

			if var_528_4 <= arg_525_1.time_ and arg_525_1.time_ < var_528_4 + var_528_12 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_4) / var_528_12

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_4 + var_528_12 and arg_525_1.time_ < var_528_4 + var_528_12 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play1104105130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1104105130
		arg_529_1.duration_ = 4.6

		local var_529_0 = {
			zh = 3.233,
			ja = 4.6
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
				arg_529_0:Play1104105131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_532_0 = 0
			local var_532_1 = 0.375

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_2 = arg_529_1:GetWordFromCfg(1104105130)
				local var_532_3 = arg_529_1:FormatText(var_532_2.content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 15 <= 0 and var_532_1 or var_532_1 * (utf8.len(var_532_3) / 15)

				if (15 <= 0 and var_532_1 or var_532_1 * (utf8.len(var_532_3) / 15)) > 0 and var_532_1 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105130", "story_v_side_new_1104105.awb") ~= 0 then
					local var_532_6 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105130", "story_v_side_new_1104105.awb") / 1000

					if var_532_6 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_0
					end

					if var_532_2.prefab_name ~= "" and arg_529_1.actors_[var_532_2.prefab_name] ~= nil then
						local var_532_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_2.prefab_name].transform, "story_v_side_new_1104105", "1104105130", "story_v_side_new_1104105.awb")

						arg_529_1:RecordAudio("1104105130", var_532_7)
						arg_529_1:RecordAudio("1104105130", var_532_7)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105130", "story_v_side_new_1104105.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105130", "story_v_side_new_1104105.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_8 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_8 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_8

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_8 and arg_529_1.time_ < var_532_0 + var_532_8 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1104105131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1104105131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1104105132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos1041ui_story = arg_533_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_536_0 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 then
				arg_533_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_533_1.time_ - 0) / var_536_0)
				arg_533_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).z)
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles = arg_533_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 then
				arg_533_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_533_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).z)
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles = arg_533_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_536_1 = 0
			local var_536_2 = 0.9

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_3 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1104105131).content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 36 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 36)

				if (36 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 36)) > 0 and var_536_2 < var_536_5 then
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

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play1104105132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1104105132
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1104105133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.475

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1104105132).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 19 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 19)

				if (19 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 19)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1104105133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1104105133
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1104105134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.375

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
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

				local var_544_1 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(1104105133).content)

				arg_541_1.text_.text = var_544_1

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_3 = 15 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 15)

				if (15 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 15)) > 0 and var_544_0 < var_544_3 then
					arg_541_1.talkMaxDuration = var_544_3

					if var_544_3 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_3 + 0
					end
				end

				arg_541_1.text_.text = var_544_1
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_4 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_4 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_4

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_4 and arg_541_1.time_ < 0 + var_544_4 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1104105134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1104105134
		arg_545_1.duration_ = 3

		local var_545_0 = {
			zh = 1.966,
			ja = 3
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1104105135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1041ui_story = arg_545_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).z)
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles = arg_545_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_545_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).z)
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles = arg_545_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_548_1 = arg_545_1.actors_["1041ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1041ui_story == nil then
				arg_545_1.var_.characterEffect1041ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1041ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1041ui_story then
				arg_545_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_548_4 = 0
			local var_548_5 = 0.175

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(1104105134)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 7 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 7)

				if (7 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 7)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105134", "story_v_side_new_1104105.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105134", "story_v_side_new_1104105.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_side_new_1104105", "1104105134", "story_v_side_new_1104105.awb")

						arg_545_1:RecordAudio("1104105134", var_548_11)
						arg_545_1:RecordAudio("1104105134", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105134", "story_v_side_new_1104105.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105134", "story_v_side_new_1104105.awb")
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
				actorName = "1041ui_story",
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
	Play1104105135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104105135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104105136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["1041ui_story"]) and arg_549_1.var_.characterEffect1041ui_story == nil then
				arg_549_1.var_.characterEffect1041ui_story = arg_549_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_0 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["1041ui_story"]) then
				if arg_549_1.var_.characterEffect1041ui_story and not isNil(arg_549_1.actors_["1041ui_story"]) then
					arg_549_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_0)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["1041ui_story"]) and arg_549_1.var_.characterEffect1041ui_story then
				arg_549_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_552_1 = 0
			local var_552_2 = 0.1

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1104105135).content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 4 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 4)

				if (4 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 4)) > 0 and var_552_2 < var_552_5 then
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
	Play1104105136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104105136
		arg_553_1.duration_ = 2

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104105137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1041ui_story = arg_553_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_556_0 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 then
				arg_553_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_553_1.time_ - 0) / var_556_0)
				arg_553_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).z)
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles = arg_553_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 then
				arg_553_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_553_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).z)
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles = arg_553_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_556_1 = arg_553_1.actors_["1041ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1041ui_story == nil then
				arg_553_1.var_.characterEffect1041ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect1041ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1041ui_story then
				arg_553_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_556_4 = 0
			local var_556_5 = 0.05

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_6 = arg_553_1:GetWordFromCfg(1104105136)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 2 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 2)

				if (2 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 2)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105136", "story_v_side_new_1104105.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105136", "story_v_side_new_1104105.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_side_new_1104105", "1104105136", "story_v_side_new_1104105.awb")

						arg_553_1:RecordAudio("1104105136", var_556_11)
						arg_553_1:RecordAudio("1104105136", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105136", "story_v_side_new_1104105.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105136", "story_v_side_new_1104105.awb")
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
				actorName = "1041ui_story",
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
	Play1104105137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104105137
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104105138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1041ui_story"]) and arg_557_1.var_.characterEffect1041ui_story == nil then
				arg_557_1.var_.characterEffect1041ui_story = arg_557_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1041ui_story"]) then
				if arg_557_1.var_.characterEffect1041ui_story and not isNil(arg_557_1.actors_["1041ui_story"]) then
					arg_557_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_0)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1041ui_story"]) and arg_557_1.var_.characterEffect1041ui_story then
				arg_557_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_560_1 = 0
			local var_560_2 = 0.4

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_3 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(1104105137).content)

				arg_557_1.text_.text = var_560_3

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 16 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_3) / 16)

				if (16 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_3) / 16)) > 0 and var_560_2 < var_560_5 then
					arg_557_1.talkMaxDuration = var_560_5

					if var_560_5 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + var_560_1
					end
				end

				arg_557_1.text_.text = var_560_3
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_6 = math.max(var_560_2, arg_557_1.talkMaxDuration)

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_6 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_1) / var_560_6

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_1 + var_560_6 and arg_557_1.time_ < var_560_1 + var_560_6 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1104105138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104105138
		arg_561_1.duration_ = 9.23

		local var_561_0 = {
			zh = 7.566,
			ja = 9.233
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104105139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1041ui_story = arg_561_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1041ui_story"].transform.position).z)
				arg_561_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1041ui_story"].transform.localEulerAngles = arg_561_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_561_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1041ui_story"].transform.position).z)
				arg_561_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1041ui_story"].transform.localEulerAngles = arg_561_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_564_1 = arg_561_1.actors_["1041ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1041ui_story == nil then
				arg_561_1.var_.characterEffect1041ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1041ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1041ui_story then
				arg_561_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_564_4 = 0
			local var_564_5 = 0.975

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(1104105138)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 39 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 39)

				if (39 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 39)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105138", "story_v_side_new_1104105.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105138", "story_v_side_new_1104105.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_side_new_1104105", "1104105138", "story_v_side_new_1104105.awb")

						arg_561_1:RecordAudio("1104105138", var_564_11)
						arg_561_1:RecordAudio("1104105138", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105138", "story_v_side_new_1104105.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105138", "story_v_side_new_1104105.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104105139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1104105139
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1104105140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1041ui_story"]) and arg_565_1.var_.characterEffect1041ui_story == nil then
				arg_565_1.var_.characterEffect1041ui_story = arg_565_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1041ui_story"]) then
				if arg_565_1.var_.characterEffect1041ui_story and not isNil(arg_565_1.actors_["1041ui_story"]) then
					arg_565_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1041ui_story"]) and arg_565_1.var_.characterEffect1041ui_story then
				arg_565_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_568_1 = 0
			local var_568_2 = 1.275

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(1104105139).content)

				arg_565_1.text_.text = var_568_3

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 51 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 51)

				if (51 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 51)) > 0 and var_568_2 < var_568_5 then
					arg_565_1.talkMaxDuration = var_568_5

					if var_568_5 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_3
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_6 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_6 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_6

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_6 and arg_565_1.time_ < var_568_1 + var_568_6 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1104105140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1104105140
		arg_569_1.duration_ = 1.57

		local var_569_0 = {
			zh = 1.566,
			ja = 1.333
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
				arg_569_0:Play1104105141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["1041ui_story"]) and arg_569_1.var_.characterEffect1041ui_story == nil then
				arg_569_1.var_.characterEffect1041ui_story = arg_569_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_0 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["1041ui_story"]) then
				if arg_569_1.var_.characterEffect1041ui_story and not isNil(arg_569_1.actors_["1041ui_story"]) then
					arg_569_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["1041ui_story"]) and arg_569_1.var_.characterEffect1041ui_story then
				arg_569_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_572_2 = 0
			local var_572_3 = 0.05

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_2 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_4 = arg_569_1:GetWordFromCfg(1104105140)
				local var_572_5 = arg_569_1:FormatText(var_572_4.content)

				arg_569_1.text_.text = var_572_5

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_7 = 2 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_5) / 2)

				if (2 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_5) / 2)) > 0 and var_572_3 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_2
					end
				end

				arg_569_1.text_.text = var_572_5
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105140", "story_v_side_new_1104105.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105140", "story_v_side_new_1104105.awb") / 1000

					if var_572_8 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_2
					end

					if var_572_4.prefab_name ~= "" and arg_569_1.actors_[var_572_4.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_4.prefab_name].transform, "story_v_side_new_1104105", "1104105140", "story_v_side_new_1104105.awb")

						arg_569_1:RecordAudio("1104105140", var_572_9)
						arg_569_1:RecordAudio("1104105140", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105140", "story_v_side_new_1104105.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105140", "story_v_side_new_1104105.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_10 = math.max(var_572_3, arg_569_1.talkMaxDuration)

			if var_572_2 <= arg_569_1.time_ and arg_569_1.time_ < var_572_2 + var_572_10 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_2) / var_572_10

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_2 + var_572_10 and arg_569_1.time_ < var_572_2 + var_572_10 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1104105141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104105141
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104105142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1041ui_story"]) and arg_573_1.var_.characterEffect1041ui_story == nil then
				arg_573_1.var_.characterEffect1041ui_story = arg_573_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1041ui_story"]) then
				if arg_573_1.var_.characterEffect1041ui_story and not isNil(arg_573_1.actors_["1041ui_story"]) then
					arg_573_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_0)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1041ui_story"]) and arg_573_1.var_.characterEffect1041ui_story then
				arg_573_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_576_1 = 0
			local var_576_2 = 0.75

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

				local var_576_3 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(1104105141).content)

				arg_573_1.text_.text = var_576_3

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 30 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 30)

				if (30 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 30)) > 0 and var_576_2 < var_576_5 then
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
	Play1104105142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1104105142
		arg_577_1.duration_ = 9.97

		local var_577_0 = {
			zh = 6.4,
			ja = 9.966
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
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1104105143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1041ui_story"]) and arg_577_1.var_.characterEffect1041ui_story == nil then
				arg_577_1.var_.characterEffect1041ui_story = arg_577_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1041ui_story"]) then
				if arg_577_1.var_.characterEffect1041ui_story and not isNil(arg_577_1.actors_["1041ui_story"]) then
					arg_577_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1041ui_story"]) and arg_577_1.var_.characterEffect1041ui_story then
				arg_577_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_580_2 = 0
			local var_580_3 = 0.525

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_2 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_4 = arg_577_1:GetWordFromCfg(1104105142)
				local var_580_5 = arg_577_1:FormatText(var_580_4.content)

				arg_577_1.text_.text = var_580_5

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_7 = 21 <= 0 and var_580_3 or var_580_3 * (utf8.len(var_580_5) / 21)

				if (21 <= 0 and var_580_3 or var_580_3 * (utf8.len(var_580_5) / 21)) > 0 and var_580_3 < var_580_7 then
					arg_577_1.talkMaxDuration = var_580_7

					if var_580_7 + var_580_2 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_7 + var_580_2
					end
				end

				arg_577_1.text_.text = var_580_5
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105142", "story_v_side_new_1104105.awb") ~= 0 then
					local var_580_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105142", "story_v_side_new_1104105.awb") / 1000

					if var_580_8 + var_580_2 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_8 + var_580_2
					end

					if var_580_4.prefab_name ~= "" and arg_577_1.actors_[var_580_4.prefab_name] ~= nil then
						local var_580_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_4.prefab_name].transform, "story_v_side_new_1104105", "1104105142", "story_v_side_new_1104105.awb")

						arg_577_1:RecordAudio("1104105142", var_580_9)
						arg_577_1:RecordAudio("1104105142", var_580_9)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105142", "story_v_side_new_1104105.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105142", "story_v_side_new_1104105.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_10 = math.max(var_580_3, arg_577_1.talkMaxDuration)

			if var_580_2 <= arg_577_1.time_ and arg_577_1.time_ < var_580_2 + var_580_10 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_2) / var_580_10

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_2 + var_580_10 and arg_577_1.time_ < var_580_2 + var_580_10 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1104105143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1104105143
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1104105144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["1041ui_story"]) and arg_581_1.var_.characterEffect1041ui_story == nil then
				arg_581_1.var_.characterEffect1041ui_story = arg_581_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_0 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["1041ui_story"]) then
				if arg_581_1.var_.characterEffect1041ui_story and not isNil(arg_581_1.actors_["1041ui_story"]) then
					arg_581_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_581_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_581_1.time_ - 0) / var_584_0)
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["1041ui_story"]) and arg_581_1.var_.characterEffect1041ui_story then
				arg_581_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_581_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_584_1 = 0
			local var_584_2 = 0.225

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_3 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(1104105143).content)

				arg_581_1.text_.text = var_584_3

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_5 = 9 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_3) / 9)

				if (9 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_3) / 9)) > 0 and var_584_2 < var_584_5 then
					arg_581_1.talkMaxDuration = var_584_5

					if var_584_5 + var_584_1 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_5 + var_584_1
					end
				end

				arg_581_1.text_.text = var_584_3
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_6 = math.max(var_584_2, arg_581_1.talkMaxDuration)

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_6 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_1) / var_584_6

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_1 + var_584_6 and arg_581_1.time_ < var_584_1 + var_584_6 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1104105144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104105144
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104105145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.575

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1104105144).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 23 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 23)

				if (23 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 23)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104105145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104105145
		arg_589_1.duration_ = 9.4

		local var_589_0 = {
			zh = 9.4,
			ja = 5.2
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104105146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["1041ui_story"]) and arg_589_1.var_.characterEffect1041ui_story == nil then
				arg_589_1.var_.characterEffect1041ui_story = arg_589_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_0 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["1041ui_story"]) then
				if arg_589_1.var_.characterEffect1041ui_story and not isNil(arg_589_1.actors_["1041ui_story"]) then
					arg_589_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["1041ui_story"]) and arg_589_1.var_.characterEffect1041ui_story then
				arg_589_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_592_2 = 0
			local var_592_3 = 0.85

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_2 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_4 = arg_589_1:GetWordFromCfg(1104105145)
				local var_592_5 = arg_589_1:FormatText(var_592_4.content)

				arg_589_1.text_.text = var_592_5

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_7 = 34 <= 0 and var_592_3 or var_592_3 * (utf8.len(var_592_5) / 34)

				if (34 <= 0 and var_592_3 or var_592_3 * (utf8.len(var_592_5) / 34)) > 0 and var_592_3 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_2 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_2
					end
				end

				arg_589_1.text_.text = var_592_5
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105145", "story_v_side_new_1104105.awb") ~= 0 then
					local var_592_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105145", "story_v_side_new_1104105.awb") / 1000

					if var_592_8 + var_592_2 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_8 + var_592_2
					end

					if var_592_4.prefab_name ~= "" and arg_589_1.actors_[var_592_4.prefab_name] ~= nil then
						local var_592_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_4.prefab_name].transform, "story_v_side_new_1104105", "1104105145", "story_v_side_new_1104105.awb")

						arg_589_1:RecordAudio("1104105145", var_592_9)
						arg_589_1:RecordAudio("1104105145", var_592_9)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105145", "story_v_side_new_1104105.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105145", "story_v_side_new_1104105.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_10 = math.max(var_592_3, arg_589_1.talkMaxDuration)

			if var_592_2 <= arg_589_1.time_ and arg_589_1.time_ < var_592_2 + var_592_10 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_2) / var_592_10

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_2 + var_592_10 and arg_589_1.time_ < var_592_2 + var_592_10 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104105146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104105146
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104105147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(arg_593_1.actors_["1041ui_story"]) and arg_593_1.var_.characterEffect1041ui_story == nil then
				arg_593_1.var_.characterEffect1041ui_story = arg_593_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_0 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 and not isNil(arg_593_1.actors_["1041ui_story"]) then
				if arg_593_1.var_.characterEffect1041ui_story and not isNil(arg_593_1.actors_["1041ui_story"]) then
					arg_593_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_593_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_593_1.time_ - 0) / var_596_0)
				end
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 and not isNil(arg_593_1.actors_["1041ui_story"]) and arg_593_1.var_.characterEffect1041ui_story then
				arg_593_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_593_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_596_1 = 0
			local var_596_2 = 0.1

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_3 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(1104105146).content)

				arg_593_1.text_.text = var_596_3

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 4 <= 0 and var_596_2 or var_596_2 * (utf8.len(var_596_3) / 4)

				if (4 <= 0 and var_596_2 or var_596_2 * (utf8.len(var_596_3) / 4)) > 0 and var_596_2 < var_596_5 then
					arg_593_1.talkMaxDuration = var_596_5

					if var_596_5 + var_596_1 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_5 + var_596_1
					end
				end

				arg_593_1.text_.text = var_596_3
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_6 = math.max(var_596_2, arg_593_1.talkMaxDuration)

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_6 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_1) / var_596_6

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_1 + var_596_6 and arg_593_1.time_ < var_596_1 + var_596_6 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1104105147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104105147
		arg_597_1.duration_ = 7.37

		local var_597_0 = {
			zh = 4.733,
			ja = 7.366
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1104105148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1041ui_story"]) and arg_597_1.var_.characterEffect1041ui_story == nil then
				arg_597_1.var_.characterEffect1041ui_story = arg_597_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_0 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1041ui_story"]) then
				if arg_597_1.var_.characterEffect1041ui_story and not isNil(arg_597_1.actors_["1041ui_story"]) then
					arg_597_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1041ui_story"]) and arg_597_1.var_.characterEffect1041ui_story then
				arg_597_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_600_2 = 0
			local var_600_3 = 0.55

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_2 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_4 = arg_597_1:GetWordFromCfg(1104105147)
				local var_600_5 = arg_597_1:FormatText(var_600_4.content)

				arg_597_1.text_.text = var_600_5

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_7 = 22 <= 0 and var_600_3 or var_600_3 * (utf8.len(var_600_5) / 22)

				if (22 <= 0 and var_600_3 or var_600_3 * (utf8.len(var_600_5) / 22)) > 0 and var_600_3 < var_600_7 then
					arg_597_1.talkMaxDuration = var_600_7

					if var_600_7 + var_600_2 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_7 + var_600_2
					end
				end

				arg_597_1.text_.text = var_600_5
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105147", "story_v_side_new_1104105.awb") ~= 0 then
					local var_600_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105147", "story_v_side_new_1104105.awb") / 1000

					if var_600_8 + var_600_2 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_8 + var_600_2
					end

					if var_600_4.prefab_name ~= "" and arg_597_1.actors_[var_600_4.prefab_name] ~= nil then
						local var_600_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_4.prefab_name].transform, "story_v_side_new_1104105", "1104105147", "story_v_side_new_1104105.awb")

						arg_597_1:RecordAudio("1104105147", var_600_9)
						arg_597_1:RecordAudio("1104105147", var_600_9)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105147", "story_v_side_new_1104105.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105147", "story_v_side_new_1104105.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_10 = math.max(var_600_3, arg_597_1.talkMaxDuration)

			if var_600_2 <= arg_597_1.time_ and arg_597_1.time_ < var_600_2 + var_600_10 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_2) / var_600_10

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_2 + var_600_10 and arg_597_1.time_ < var_600_2 + var_600_10 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1104105148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1104105148
		arg_601_1.duration_ = 9

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1104105149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 2 < arg_601_1.time_ and arg_601_1.time_ <= 2 + arg_604_0 then
				local var_604_0 = arg_601_1.bgs_.ST24a

				arg_601_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_604_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_604_1 = var_604_0:GetComponent("SpriteRenderer")

				if var_604_1 and var_604_1.sprite then
					local var_604_2 = 2 * (var_604_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_604_0.transform.localScale = Vector3.New(var_604_2 / var_604_1.sprite.bounds.size.y < var_604_2 * manager.ui.mainCameraCom_.aspect / var_604_1.sprite.bounds.size.x and var_604_2 * manager.ui.mainCameraCom_.aspect / var_604_1.sprite.bounds.size.x or var_604_2 / var_604_1.sprite.bounds.size.y, var_604_2 / var_604_1.sprite.bounds.size.y < var_604_2 * manager.ui.mainCameraCom_.aspect / var_604_1.sprite.bounds.size.x and var_604_2 * manager.ui.mainCameraCom_.aspect / var_604_1.sprite.bounds.size.x or var_604_2 / var_604_1.sprite.bounds.size.y, 0)
				end

				for iter_604_0, iter_604_1 in pairs(arg_601_1.bgs_) do
					if iter_604_0 ~= "ST24a" then
						iter_604_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_604_3 = 0

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_3 + arg_604_0 then
				arg_601_1.mask_.enabled = true
				arg_601_1.mask_.raycastTarget = true

				arg_601_1:SetGaussion(false)
			end

			local var_604_4 = 2

			if var_604_3 <= arg_601_1.time_ and arg_601_1.time_ < var_604_3 + var_604_4 then
				local var_604_5 = Color.New(0, 0, 0)

				var_604_5.a = Mathf.Lerp(0, 1, (arg_601_1.time_ - var_604_3) / var_604_4)
				arg_601_1.mask_.color = var_604_5
			end

			if arg_601_1.time_ >= var_604_3 + var_604_4 and arg_601_1.time_ < var_604_3 + var_604_4 + arg_604_0 then
				local var_604_6 = Color.New(0, 0, 0)

				var_604_6.a = 1
				arg_601_1.mask_.color = var_604_6
			end

			local var_604_7 = 2

			if 2 < arg_601_1.time_ and arg_601_1.time_ <= var_604_7 + arg_604_0 then
				arg_601_1.mask_.enabled = true
				arg_601_1.mask_.raycastTarget = true

				arg_601_1:SetGaussion(false)
			end

			local var_604_8 = 2

			if var_604_7 <= arg_601_1.time_ and arg_601_1.time_ < var_604_7 + var_604_8 then
				local var_604_9 = Color.New(0, 0, 0)

				var_604_9.a = Mathf.Lerp(1, 0, (arg_601_1.time_ - var_604_7) / var_604_8)
				arg_601_1.mask_.color = var_604_9
			end

			if arg_601_1.time_ >= var_604_7 + var_604_8 and arg_601_1.time_ < var_604_7 + var_604_8 + arg_604_0 then
				local var_604_10 = Color.New(0, 0, 0)

				arg_601_1.mask_.enabled = false
				var_604_10.a = 0
				arg_601_1.mask_.color = var_604_10
			end

			local var_604_11 = arg_601_1.actors_["1041ui_story"].transform

			if 2 < arg_601_1.time_ and arg_601_1.time_ <= 2 + arg_604_0 then
				arg_601_1.var_.moveOldPos1041ui_story = var_604_11.localPosition
			end

			local var_604_12 = 0.001

			if 2 <= arg_601_1.time_ and arg_601_1.time_ < 2 + var_604_12 then
				var_604_11.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_601_1.time_ - 2) / var_604_12)
				var_604_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_604_11.position).x, (manager.ui.mainCamera.transform.position - var_604_11.position).y, (manager.ui.mainCamera.transform.position - var_604_11.position).z)
				var_604_11.localEulerAngles.z = 0
				var_604_11.localEulerAngles.x = 0
				var_604_11.localEulerAngles = var_604_11.localEulerAngles
			end

			if arg_601_1.time_ >= 2 + var_604_12 and arg_601_1.time_ < 2 + var_604_12 + arg_604_0 then
				var_604_11.localPosition = Vector3.New(0, 100, 0)
				var_604_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_604_11.position).x, (manager.ui.mainCamera.transform.position - var_604_11.position).y, (manager.ui.mainCamera.transform.position - var_604_11.position).z)
				var_604_11.localEulerAngles.z = 0
				var_604_11.localEulerAngles.x = 0
				var_604_11.localEulerAngles = var_604_11.localEulerAngles
			end

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_604_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_601_1.bgmTxt_.text ~= var_604_15 and arg_601_1.bgmTxt_.text ~= "" then
						if arg_601_1.bgmTxt2_.text ~= "" then
							arg_601_1.bgmTxt_.text = arg_601_1.bgmTxt2_.text
						end

						arg_601_1.bgmTxt2_.text = var_604_15

						arg_601_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_601_1.bgmTxt_.text = var_604_15
						arg_601_1.bgmTxt2_.text = var_604_15
					end

					if arg_601_1.bgmTimer then
						arg_601_1.bgmTimer:Stop()

						arg_601_1.bgmTimer = nil
					end

					if arg_601_1.settingData.show_music_name == 1 then
						arg_601_1.musicController:SetSelectedState("show")
						arg_601_1.musicAnimator_:Play("open", 0, 0)

						if arg_601_1.settingData.music_time ~= 0 then
							arg_601_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_601_1.settingData.music_time), function()
								if arg_601_1 == nil or isNil(arg_601_1.bgmTxt_) then
									return
								end

								arg_601_1.musicController:SetSelectedState("hide")
								arg_601_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_601_1.frameCnt_ <= 1 then
				arg_601_1.dialog_:SetActive(false)
			end

			local var_604_16 = 4
			local var_604_17 = 0.05

			if 4 < arg_601_1.time_ and arg_601_1.time_ <= var_604_16 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0

				arg_601_1.dialog_:SetActive(true)

				arg_601_1.dialogCg_.alpha = 0

				local var_604_18 = LeanTween.value(arg_601_1.dialog_, 0, 1, 0.3)

				var_604_18:setOnUpdate(LuaHelper.FloatAction(function(arg_606_0)
					arg_601_1.dialogCg_.alpha = arg_606_0
				end))
				var_604_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_601_1.dialog_)
					var_604_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_601_1.duration_ = arg_601_1.duration_ + 0.3

				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_19 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(1104105148).content)

				arg_601_1.text_.text = var_604_19

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_21 = 2 <= 0 and var_604_17 or var_604_17 * (utf8.len(var_604_19) / 2)

				if (2 <= 0 and var_604_17 or var_604_17 * (utf8.len(var_604_19) / 2)) > 0 and var_604_17 < var_604_21 then
					arg_601_1.talkMaxDuration = var_604_21
					var_604_16 = var_604_16 + 0.3

					if var_604_21 + var_604_16 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_21 + var_604_16
					end
				end

				arg_601_1.text_.text = var_604_19
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_22 = var_604_16 + 0.3
			local var_604_23 = math.max(var_604_17, arg_601_1.talkMaxDuration)

			if var_604_16 + 0.3 <= arg_601_1.time_ and arg_601_1.time_ < var_604_22 + var_604_23 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_22) / var_604_23

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_22 + var_604_23 and arg_601_1.time_ < var_604_22 + var_604_23 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_601_1:InitPlayNodeList()
	end,
	Play1104105149 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1104105149
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1104105150(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_611_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_608_1.bgmTxt_.text ~= var_611_2 and arg_608_1.bgmTxt_.text ~= "" then
						if arg_608_1.bgmTxt2_.text ~= "" then
							arg_608_1.bgmTxt_.text = arg_608_1.bgmTxt2_.text
						end

						arg_608_1.bgmTxt2_.text = var_611_2

						arg_608_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_608_1.bgmTxt_.text = var_611_2
						arg_608_1.bgmTxt2_.text = var_611_2
					end

					if arg_608_1.bgmTimer then
						arg_608_1.bgmTimer:Stop()

						arg_608_1.bgmTimer = nil
					end

					if arg_608_1.settingData.show_music_name == 1 then
						arg_608_1.musicController:SetSelectedState("show")
						arg_608_1.musicAnimator_:Play("open", 0, 0)

						if arg_608_1.settingData.music_time ~= 0 then
							arg_608_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_608_1.settingData.music_time), function()
								if arg_608_1 == nil or isNil(arg_608_1.bgmTxt_) then
									return
								end

								arg_608_1.musicController:SetSelectedState("hide")
								arg_608_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_608_1.time_ and arg_608_1.time_ <= 1 + arg_611_0 then
				arg_608_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_611_5 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_608_1.bgmTxt_.text ~= var_611_5 and arg_608_1.bgmTxt_.text ~= "" then
						if arg_608_1.bgmTxt2_.text ~= "" then
							arg_608_1.bgmTxt_.text = arg_608_1.bgmTxt2_.text
						end

						arg_608_1.bgmTxt2_.text = var_611_5

						arg_608_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_608_1.bgmTxt_.text = var_611_5
						arg_608_1.bgmTxt2_.text = var_611_5
					end

					if arg_608_1.bgmTimer then
						arg_608_1.bgmTimer:Stop()

						arg_608_1.bgmTimer = nil
					end

					if arg_608_1.settingData.show_music_name == 1 then
						arg_608_1.musicController:SetSelectedState("show")
						arg_608_1.musicAnimator_:Play("open", 0, 0)

						if arg_608_1.settingData.music_time ~= 0 then
							arg_608_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_608_1.settingData.music_time), function()
								if arg_608_1 == nil or isNil(arg_608_1.bgmTxt_) then
									return
								end

								arg_608_1.musicController:SetSelectedState("hide")
								arg_608_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_611_6 = 0
			local var_611_7 = 0.275

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_6 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_8 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(1104105149).content)

				arg_608_1.text_.text = var_611_8

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_10 = 11 <= 0 and var_611_7 or var_611_7 * (utf8.len(var_611_8) / 11)

				if (11 <= 0 and var_611_7 or var_611_7 * (utf8.len(var_611_8) / 11)) > 0 and var_611_7 < var_611_10 then
					arg_608_1.talkMaxDuration = var_611_10

					if var_611_10 + var_611_6 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_10 + var_611_6
					end
				end

				arg_608_1.text_.text = var_611_8
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_11 = math.max(var_611_7, arg_608_1.talkMaxDuration)

			if var_611_6 <= arg_608_1.time_ and arg_608_1.time_ < var_611_6 + var_611_11 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_6) / var_611_11

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_6 + var_611_11 and arg_608_1.time_ < var_611_6 + var_611_11 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play1104105150 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1104105150
		arg_614_1.duration_ = 10.3

		local var_614_0 = {
			zh = 10.3,
			ja = 6.466
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1104105151(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1.var_.moveOldPos1041ui_story = arg_614_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_617_0 = 0.001

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_0 then
				arg_614_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_614_1.time_ - 0) / var_617_0)
				arg_614_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_614_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1041ui_story"].transform.position).z)
				arg_614_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_614_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_614_1.actors_["1041ui_story"].transform.localEulerAngles = arg_614_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_614_1.time_ >= 0 + var_617_0 and arg_614_1.time_ < 0 + var_617_0 + arg_617_0 then
				arg_614_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_614_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_614_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1041ui_story"].transform.position).z)
				arg_614_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_614_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_614_1.actors_["1041ui_story"].transform.localEulerAngles = arg_614_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_617_1 = arg_614_1.actors_["1041ui_story"]

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 and not isNil(var_617_1) and arg_614_1.var_.characterEffect1041ui_story == nil then
				arg_614_1.var_.characterEffect1041ui_story = var_617_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_2 = 0.200000002980232

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_2 and not isNil(var_617_1) then
				if arg_614_1.var_.characterEffect1041ui_story and not isNil(var_617_1) then
					arg_614_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_614_1.time_ >= 0 + var_617_2 and arg_614_1.time_ < 0 + var_617_2 + arg_617_0 and not isNil(var_617_1) and arg_614_1.var_.characterEffect1041ui_story then
				arg_614_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_617_4 = 0
			local var_617_5 = 1.45

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_4 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_6 = arg_614_1:GetWordFromCfg(1104105150)
				local var_617_7 = arg_614_1:FormatText(var_617_6.content)

				arg_614_1.text_.text = var_617_7

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_9 = 58 <= 0 and var_617_5 or var_617_5 * (utf8.len(var_617_7) / 58)

				if (58 <= 0 and var_617_5 or var_617_5 * (utf8.len(var_617_7) / 58)) > 0 and var_617_5 < var_617_9 then
					arg_614_1.talkMaxDuration = var_617_9

					if var_617_9 + var_617_4 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_9 + var_617_4
					end
				end

				arg_614_1.text_.text = var_617_7
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105150", "story_v_side_new_1104105.awb") ~= 0 then
					local var_617_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105150", "story_v_side_new_1104105.awb") / 1000

					if var_617_10 + var_617_4 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_10 + var_617_4
					end

					if var_617_6.prefab_name ~= "" and arg_614_1.actors_[var_617_6.prefab_name] ~= nil then
						local var_617_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_6.prefab_name].transform, "story_v_side_new_1104105", "1104105150", "story_v_side_new_1104105.awb")

						arg_614_1:RecordAudio("1104105150", var_617_11)
						arg_614_1:RecordAudio("1104105150", var_617_11)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105150", "story_v_side_new_1104105.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105150", "story_v_side_new_1104105.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_12 = math.max(var_617_5, arg_614_1.talkMaxDuration)

			if var_617_4 <= arg_614_1.time_ and arg_614_1.time_ < var_617_4 + var_617_12 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_4) / var_617_12

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_4 + var_617_12 and arg_614_1.time_ < var_617_4 + var_617_12 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play1104105151 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1104105151
		arg_618_1.duration_ = 1.5

		SetActive(arg_618_1.tipsGo_, true)

		arg_618_1.tipsText_.text = StoryTipsCfg[104101].name

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"

			SetActive(arg_618_1.choicesGo_, true)

			for iter_619_0, iter_619_1 in ipairs(arg_618_1.choices_) do
				SetActive(iter_619_1.go, iter_619_0 <= 2)
			end

			arg_618_1.choices_[1].txt.text = arg_618_1:FormatText(StoryChoiceCfg[630].name)
			arg_618_1.choices_[2].txt.text = arg_618_1:FormatText(StoryChoiceCfg[631].name)
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				PlayerAction.UseStoryTrigger(1041014, 210410105, 1104105151, 1)
				arg_618_0:Play1104105152(arg_618_1)
			end

			if arg_620_0 == 2 then
				PlayerAction.UseStoryTrigger(1041014, 210410105, 1104105151, 2)
				arg_618_0:Play1104105152(arg_618_1)
			end

			arg_618_1:RecordChoiceLog(1104105151, 630, 631)
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 and not isNil(arg_618_1.actors_["1041ui_story"]) and arg_618_1.var_.characterEffect1041ui_story == nil then
				arg_618_1.var_.characterEffect1041ui_story = arg_618_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_0 = 0.200000002980232

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_0 and not isNil(arg_618_1.actors_["1041ui_story"]) then
				if arg_618_1.var_.characterEffect1041ui_story and not isNil(arg_618_1.actors_["1041ui_story"]) then
					arg_618_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_618_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_618_1.time_ - 0) / var_621_0)
				end
			end

			if arg_618_1.time_ >= 0 + var_621_0 and arg_618_1.time_ < 0 + var_621_0 + arg_621_0 and not isNil(arg_618_1.actors_["1041ui_story"]) and arg_618_1.var_.characterEffect1041ui_story then
				arg_618_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_618_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_621_1 = 0

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.allBtn_.enabled = false
			end

			if arg_618_1.time_ >= var_621_1 + 1.5 and arg_618_1.time_ < var_621_1 + 1.5 + arg_621_0 then
				arg_618_1.allBtn_.enabled = true
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	Play1104105152 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1104105152
		arg_622_1.duration_ = 5

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1104105153(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 0.85

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_1 = arg_622_1:FormatText(arg_622_1:GetWordFromCfg(1104105152).content)

				arg_622_1.text_.text = var_625_1

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_3 = 34 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_1) / 34)

				if (34 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_1) / 34)) > 0 and var_625_0 < var_625_3 then
					arg_622_1.talkMaxDuration = var_625_3

					if var_625_3 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_3 + 0
					end
				end

				arg_622_1.text_.text = var_625_1
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)
				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_4 = math.max(var_625_0, arg_622_1.talkMaxDuration)

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_4 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - 0) / var_625_4

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= 0 + var_625_4 and arg_622_1.time_ < 0 + var_625_4 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1104105153 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1104105153
		arg_626_1.duration_ = 9.97

		local var_626_0 = {
			zh = 7.666,
			ja = 9.966
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1104105154(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 and not isNil(arg_626_1.actors_["1041ui_story"]) and arg_626_1.var_.characterEffect1041ui_story == nil then
				arg_626_1.var_.characterEffect1041ui_story = arg_626_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_629_0 = 0.200000002980232

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_0 and not isNil(arg_626_1.actors_["1041ui_story"]) then
				if arg_626_1.var_.characterEffect1041ui_story and not isNil(arg_626_1.actors_["1041ui_story"]) then
					arg_626_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_626_1.time_ >= 0 + var_629_0 and arg_626_1.time_ < 0 + var_629_0 + arg_629_0 and not isNil(arg_626_1.actors_["1041ui_story"]) and arg_626_1.var_.characterEffect1041ui_story then
				arg_626_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_629_2 = 0
			local var_629_3 = 1.2

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_2 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_4 = arg_626_1:GetWordFromCfg(1104105153)
				local var_629_5 = arg_626_1:FormatText(var_629_4.content)

				arg_626_1.text_.text = var_629_5

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_7 = 48 <= 0 and var_629_3 or var_629_3 * (utf8.len(var_629_5) / 48)

				if (48 <= 0 and var_629_3 or var_629_3 * (utf8.len(var_629_5) / 48)) > 0 and var_629_3 < var_629_7 then
					arg_626_1.talkMaxDuration = var_629_7

					if var_629_7 + var_629_2 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_7 + var_629_2
					end
				end

				arg_626_1.text_.text = var_629_5
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105153", "story_v_side_new_1104105.awb") ~= 0 then
					local var_629_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105153", "story_v_side_new_1104105.awb") / 1000

					if var_629_8 + var_629_2 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_8 + var_629_2
					end

					if var_629_4.prefab_name ~= "" and arg_626_1.actors_[var_629_4.prefab_name] ~= nil then
						local var_629_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_4.prefab_name].transform, "story_v_side_new_1104105", "1104105153", "story_v_side_new_1104105.awb")

						arg_626_1:RecordAudio("1104105153", var_629_9)
						arg_626_1:RecordAudio("1104105153", var_629_9)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105153", "story_v_side_new_1104105.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105153", "story_v_side_new_1104105.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_10 = math.max(var_629_3, arg_626_1.talkMaxDuration)

			if var_629_2 <= arg_626_1.time_ and arg_626_1.time_ < var_629_2 + var_629_10 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_2) / var_629_10

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_2 + var_629_10 and arg_626_1.time_ < var_629_2 + var_629_10 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1104105154 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1104105154
		arg_630_1.duration_ = 5

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1104105155(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 and not isNil(arg_630_1.actors_["1041ui_story"]) and arg_630_1.var_.characterEffect1041ui_story == nil then
				arg_630_1.var_.characterEffect1041ui_story = arg_630_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_0 = 0.200000002980232

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_0 and not isNil(arg_630_1.actors_["1041ui_story"]) then
				if arg_630_1.var_.characterEffect1041ui_story and not isNil(arg_630_1.actors_["1041ui_story"]) then
					arg_630_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_630_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_630_1.time_ - 0) / var_633_0)
				end
			end

			if arg_630_1.time_ >= 0 + var_633_0 and arg_630_1.time_ < 0 + var_633_0 + arg_633_0 and not isNil(arg_630_1.actors_["1041ui_story"]) and arg_630_1.var_.characterEffect1041ui_story then
				arg_630_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_630_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_633_1 = 0
			local var_633_2 = 0.45

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_1 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, true)
				arg_630_1.iconController_:SetSelectedState("hero")

				arg_630_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_630_1.callingController_:SetSelectedState("normal")

				arg_630_1.keyicon_.color = Color.New(1, 1, 1)
				arg_630_1.icon_.color = Color.New(1, 1, 1)

				local var_633_3 = arg_630_1:FormatText(arg_630_1:GetWordFromCfg(1104105154).content)

				arg_630_1.text_.text = var_633_3

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_5 = 18 <= 0 and var_633_2 or var_633_2 * (utf8.len(var_633_3) / 18)

				if (18 <= 0 and var_633_2 or var_633_2 * (utf8.len(var_633_3) / 18)) > 0 and var_633_2 < var_633_5 then
					arg_630_1.talkMaxDuration = var_633_5

					if var_633_5 + var_633_1 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_5 + var_633_1
					end
				end

				arg_630_1.text_.text = var_633_3
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)
				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_6 = math.max(var_633_2, arg_630_1.talkMaxDuration)

			if var_633_1 <= arg_630_1.time_ and arg_630_1.time_ < var_633_1 + var_633_6 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_1) / var_633_6

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_1 + var_633_6 and arg_630_1.time_ < var_633_1 + var_633_6 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play1104105155 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1104105155
		arg_634_1.duration_ = 3.8

		local var_634_0 = {
			zh = 3.4,
			ja = 3.8
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1104105156(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(arg_634_1.actors_["1041ui_story"]) and arg_634_1.var_.characterEffect1041ui_story == nil then
				arg_634_1.var_.characterEffect1041ui_story = arg_634_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_0 = 0.200000002980232

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_0 and not isNil(arg_634_1.actors_["1041ui_story"]) then
				if arg_634_1.var_.characterEffect1041ui_story and not isNil(arg_634_1.actors_["1041ui_story"]) then
					arg_634_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_634_1.time_ >= 0 + var_637_0 and arg_634_1.time_ < 0 + var_637_0 + arg_637_0 and not isNil(arg_634_1.actors_["1041ui_story"]) and arg_634_1.var_.characterEffect1041ui_story then
				arg_634_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_637_2 = 0
			local var_637_3 = 0.475

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_2 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_4 = arg_634_1:GetWordFromCfg(1104105155)
				local var_637_5 = arg_634_1:FormatText(var_637_4.content)

				arg_634_1.text_.text = var_637_5

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_7 = 19 <= 0 and var_637_3 or var_637_3 * (utf8.len(var_637_5) / 19)

				if (19 <= 0 and var_637_3 or var_637_3 * (utf8.len(var_637_5) / 19)) > 0 and var_637_3 < var_637_7 then
					arg_634_1.talkMaxDuration = var_637_7

					if var_637_7 + var_637_2 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_7 + var_637_2
					end
				end

				arg_634_1.text_.text = var_637_5
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105155", "story_v_side_new_1104105.awb") ~= 0 then
					local var_637_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105155", "story_v_side_new_1104105.awb") / 1000

					if var_637_8 + var_637_2 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_8 + var_637_2
					end

					if var_637_4.prefab_name ~= "" and arg_634_1.actors_[var_637_4.prefab_name] ~= nil then
						local var_637_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_4.prefab_name].transform, "story_v_side_new_1104105", "1104105155", "story_v_side_new_1104105.awb")

						arg_634_1:RecordAudio("1104105155", var_637_9)
						arg_634_1:RecordAudio("1104105155", var_637_9)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105155", "story_v_side_new_1104105.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105155", "story_v_side_new_1104105.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_10 = math.max(var_637_3, arg_634_1.talkMaxDuration)

			if var_637_2 <= arg_634_1.time_ and arg_634_1.time_ < var_637_2 + var_637_10 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_2) / var_637_10

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_2 + var_637_10 and arg_634_1.time_ < var_637_2 + var_637_10 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play1104105156 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1104105156
		arg_638_1.duration_ = 5

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1104105157(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(arg_638_1.actors_["1041ui_story"]) and arg_638_1.var_.characterEffect1041ui_story == nil then
				arg_638_1.var_.characterEffect1041ui_story = arg_638_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_0 = 0.200000002980232

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 and not isNil(arg_638_1.actors_["1041ui_story"]) then
				if arg_638_1.var_.characterEffect1041ui_story and not isNil(arg_638_1.actors_["1041ui_story"]) then
					arg_638_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_638_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_638_1.time_ - 0) / var_641_0)
				end
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 and not isNil(arg_638_1.actors_["1041ui_story"]) and arg_638_1.var_.characterEffect1041ui_story then
				arg_638_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_638_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_641_1 = 0
			local var_641_2 = 0.825

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_1 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, false)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_3 = arg_638_1:FormatText(arg_638_1:GetWordFromCfg(1104105156).content)

				arg_638_1.text_.text = var_641_3

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_5 = 33 <= 0 and var_641_2 or var_641_2 * (utf8.len(var_641_3) / 33)

				if (33 <= 0 and var_641_2 or var_641_2 * (utf8.len(var_641_3) / 33)) > 0 and var_641_2 < var_641_5 then
					arg_638_1.talkMaxDuration = var_641_5

					if var_641_5 + var_641_1 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_5 + var_641_1
					end
				end

				arg_638_1.text_.text = var_641_3
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)
				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_6 = math.max(var_641_2, arg_638_1.talkMaxDuration)

			if var_641_1 <= arg_638_1.time_ and arg_638_1.time_ < var_641_1 + var_641_6 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_1) / var_641_6

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_1 + var_641_6 and arg_638_1.time_ < var_641_1 + var_641_6 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play1104105157 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1104105157
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1104105158(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = 1.25

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, false)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_1 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(1104105157).content)

				arg_642_1.text_.text = var_645_1

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_3 = 50 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_1) / 50)

				if (50 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_1) / 50)) > 0 and var_645_0 < var_645_3 then
					arg_642_1.talkMaxDuration = var_645_3

					if var_645_3 + 0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_3 + 0
					end
				end

				arg_642_1.text_.text = var_645_1
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_4 = math.max(var_645_0, arg_642_1.talkMaxDuration)

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_4 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - 0) / var_645_4

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= 0 + var_645_4 and arg_642_1.time_ < 0 + var_645_4 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1104105158 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1104105158
		arg_646_1.duration_ = 5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1104105159(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = 0.7

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				arg_646_1.leftNameTxt_.text = arg_646_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, true)
				arg_646_1.iconController_:SetSelectedState("hero")

				arg_646_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_646_1.callingController_:SetSelectedState("normal")

				arg_646_1.keyicon_.color = Color.New(1, 1, 1)
				arg_646_1.icon_.color = Color.New(1, 1, 1)

				local var_649_1 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(1104105158).content)

				arg_646_1.text_.text = var_649_1

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_3 = 28 <= 0 and var_649_0 or var_649_0 * (utf8.len(var_649_1) / 28)

				if (28 <= 0 and var_649_0 or var_649_0 * (utf8.len(var_649_1) / 28)) > 0 and var_649_0 < var_649_3 then
					arg_646_1.talkMaxDuration = var_649_3

					if var_649_3 + 0 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_3 + 0
					end
				end

				arg_646_1.text_.text = var_649_1
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_4 = math.max(var_649_0, arg_646_1.talkMaxDuration)

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_4 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - 0) / var_649_4

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= 0 + var_649_4 and arg_646_1.time_ < 0 + var_649_4 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play1104105159 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1104105159
		arg_650_1.duration_ = 8.8

		local var_650_0 = {
			zh = 8.8,
			ja = 4.5
		}
		local var_650_1 = manager.audio:GetLocalizationFlag()

		if var_650_0[var_650_1] ~= nil then
			arg_650_1.duration_ = var_650_0[var_650_1]
		end

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1104105160(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 and not isNil(arg_650_1.actors_["1041ui_story"]) and arg_650_1.var_.characterEffect1041ui_story == nil then
				arg_650_1.var_.characterEffect1041ui_story = arg_650_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_0 = 0.200000002980232

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_0 and not isNil(arg_650_1.actors_["1041ui_story"]) then
				if arg_650_1.var_.characterEffect1041ui_story and not isNil(arg_650_1.actors_["1041ui_story"]) then
					arg_650_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_650_1.time_ >= 0 + var_653_0 and arg_650_1.time_ < 0 + var_653_0 + arg_653_0 and not isNil(arg_650_1.actors_["1041ui_story"]) and arg_650_1.var_.characterEffect1041ui_story then
				arg_650_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_653_2 = 0
			local var_653_3 = 1.325

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_2 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_4 = arg_650_1:GetWordFromCfg(1104105159)
				local var_653_5 = arg_650_1:FormatText(var_653_4.content)

				arg_650_1.text_.text = var_653_5

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_7 = 53 <= 0 and var_653_3 or var_653_3 * (utf8.len(var_653_5) / 53)

				if (53 <= 0 and var_653_3 or var_653_3 * (utf8.len(var_653_5) / 53)) > 0 and var_653_3 < var_653_7 then
					arg_650_1.talkMaxDuration = var_653_7

					if var_653_7 + var_653_2 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_7 + var_653_2
					end
				end

				arg_650_1.text_.text = var_653_5
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105159", "story_v_side_new_1104105.awb") ~= 0 then
					local var_653_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105159", "story_v_side_new_1104105.awb") / 1000

					if var_653_8 + var_653_2 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_8 + var_653_2
					end

					if var_653_4.prefab_name ~= "" and arg_650_1.actors_[var_653_4.prefab_name] ~= nil then
						local var_653_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_4.prefab_name].transform, "story_v_side_new_1104105", "1104105159", "story_v_side_new_1104105.awb")

						arg_650_1:RecordAudio("1104105159", var_653_9)
						arg_650_1:RecordAudio("1104105159", var_653_9)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105159", "story_v_side_new_1104105.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105159", "story_v_side_new_1104105.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_10 = math.max(var_653_3, arg_650_1.talkMaxDuration)

			if var_653_2 <= arg_650_1.time_ and arg_650_1.time_ < var_653_2 + var_653_10 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_2) / var_653_10

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_2 + var_653_10 and arg_650_1.time_ < var_653_2 + var_653_10 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play1104105160 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 1104105160
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play1104105161(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(arg_654_1.actors_["1041ui_story"]) and arg_654_1.var_.characterEffect1041ui_story == nil then
				arg_654_1.var_.characterEffect1041ui_story = arg_654_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_0 = 0.200000002980232

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_0 and not isNil(arg_654_1.actors_["1041ui_story"]) then
				if arg_654_1.var_.characterEffect1041ui_story and not isNil(arg_654_1.actors_["1041ui_story"]) then
					arg_654_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_654_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_654_1.time_ - 0) / var_657_0)
				end
			end

			if arg_654_1.time_ >= 0 + var_657_0 and arg_654_1.time_ < 0 + var_657_0 + arg_657_0 and not isNil(arg_654_1.actors_["1041ui_story"]) and arg_654_1.var_.characterEffect1041ui_story then
				arg_654_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_654_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_657_1 = 0
			local var_657_2 = 1.05

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_1 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_3 = arg_654_1:FormatText(arg_654_1:GetWordFromCfg(1104105160).content)

				arg_654_1.text_.text = var_657_3

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_5 = 42 <= 0 and var_657_2 or var_657_2 * (utf8.len(var_657_3) / 42)

				if (42 <= 0 and var_657_2 or var_657_2 * (utf8.len(var_657_3) / 42)) > 0 and var_657_2 < var_657_5 then
					arg_654_1.talkMaxDuration = var_657_5

					if var_657_5 + var_657_1 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_5 + var_657_1
					end
				end

				arg_654_1.text_.text = var_657_3
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_6 = math.max(var_657_2, arg_654_1.talkMaxDuration)

			if var_657_1 <= arg_654_1.time_ and arg_654_1.time_ < var_657_1 + var_657_6 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_1) / var_657_6

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_1 + var_657_6 and arg_654_1.time_ < var_657_1 + var_657_6 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play1104105161 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 1104105161
		arg_658_1.duration_ = 6.93

		local var_658_0 = {
			zh = 4.266,
			ja = 6.933
		}
		local var_658_1 = manager.audio:GetLocalizationFlag()

		if var_658_0[var_658_1] ~= nil then
			arg_658_1.duration_ = var_658_0[var_658_1]
		end

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play1104105162(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(arg_658_1.actors_["1041ui_story"]) and arg_658_1.var_.characterEffect1041ui_story == nil then
				arg_658_1.var_.characterEffect1041ui_story = arg_658_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_0 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_0 and not isNil(arg_658_1.actors_["1041ui_story"]) then
				if arg_658_1.var_.characterEffect1041ui_story and not isNil(arg_658_1.actors_["1041ui_story"]) then
					arg_658_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= 0 + var_661_0 and arg_658_1.time_ < 0 + var_661_0 + arg_661_0 and not isNil(arg_658_1.actors_["1041ui_story"]) and arg_658_1.var_.characterEffect1041ui_story then
				arg_658_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_661_2 = 0
			local var_661_3 = 0.65

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_2 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_4 = arg_658_1:GetWordFromCfg(1104105161)
				local var_661_5 = arg_658_1:FormatText(var_661_4.content)

				arg_658_1.text_.text = var_661_5

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_7 = 26 <= 0 and var_661_3 or var_661_3 * (utf8.len(var_661_5) / 26)

				if (26 <= 0 and var_661_3 or var_661_3 * (utf8.len(var_661_5) / 26)) > 0 and var_661_3 < var_661_7 then
					arg_658_1.talkMaxDuration = var_661_7

					if var_661_7 + var_661_2 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_7 + var_661_2
					end
				end

				arg_658_1.text_.text = var_661_5
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105161", "story_v_side_new_1104105.awb") ~= 0 then
					local var_661_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105161", "story_v_side_new_1104105.awb") / 1000

					if var_661_8 + var_661_2 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_8 + var_661_2
					end

					if var_661_4.prefab_name ~= "" and arg_658_1.actors_[var_661_4.prefab_name] ~= nil then
						local var_661_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_4.prefab_name].transform, "story_v_side_new_1104105", "1104105161", "story_v_side_new_1104105.awb")

						arg_658_1:RecordAudio("1104105161", var_661_9)
						arg_658_1:RecordAudio("1104105161", var_661_9)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105161", "story_v_side_new_1104105.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105161", "story_v_side_new_1104105.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_10 = math.max(var_661_3, arg_658_1.talkMaxDuration)

			if var_661_2 <= arg_658_1.time_ and arg_658_1.time_ < var_661_2 + var_661_10 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_2) / var_661_10

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_2 + var_661_10 and arg_658_1.time_ < var_661_2 + var_661_10 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play1104105162 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 1104105162
		arg_662_1.duration_ = 5

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play1104105163(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 and not isNil(arg_662_1.actors_["1041ui_story"]) and arg_662_1.var_.characterEffect1041ui_story == nil then
				arg_662_1.var_.characterEffect1041ui_story = arg_662_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_0 = 0.200000002980232

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_0 and not isNil(arg_662_1.actors_["1041ui_story"]) then
				if arg_662_1.var_.characterEffect1041ui_story and not isNil(arg_662_1.actors_["1041ui_story"]) then
					arg_662_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_662_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_662_1.time_ - 0) / var_665_0)
				end
			end

			if arg_662_1.time_ >= 0 + var_665_0 and arg_662_1.time_ < 0 + var_665_0 + arg_665_0 and not isNil(arg_662_1.actors_["1041ui_story"]) and arg_662_1.var_.characterEffect1041ui_story then
				arg_662_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_662_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_665_1 = 0
			local var_665_2 = 0.65

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_1 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, true)
				arg_662_1.iconController_:SetSelectedState("hero")

				arg_662_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_662_1.callingController_:SetSelectedState("normal")

				arg_662_1.keyicon_.color = Color.New(1, 1, 1)
				arg_662_1.icon_.color = Color.New(1, 1, 1)

				local var_665_3 = arg_662_1:FormatText(arg_662_1:GetWordFromCfg(1104105162).content)

				arg_662_1.text_.text = var_665_3

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_5 = 26 <= 0 and var_665_2 or var_665_2 * (utf8.len(var_665_3) / 26)

				if (26 <= 0 and var_665_2 or var_665_2 * (utf8.len(var_665_3) / 26)) > 0 and var_665_2 < var_665_5 then
					arg_662_1.talkMaxDuration = var_665_5

					if var_665_5 + var_665_1 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_5 + var_665_1
					end
				end

				arg_662_1.text_.text = var_665_3
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)
				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_6 = math.max(var_665_2, arg_662_1.talkMaxDuration)

			if var_665_1 <= arg_662_1.time_ and arg_662_1.time_ < var_665_1 + var_665_6 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_1) / var_665_6

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_1 + var_665_6 and arg_662_1.time_ < var_665_1 + var_665_6 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play1104105163 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 1104105163
		arg_666_1.duration_ = 5

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play1104105164(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = 0.975

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, false)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_1 = arg_666_1:FormatText(arg_666_1:GetWordFromCfg(1104105163).content)

				arg_666_1.text_.text = var_669_1

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_3 = 39 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_1) / 39)

				if (39 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_1) / 39)) > 0 and var_669_0 < var_669_3 then
					arg_666_1.talkMaxDuration = var_669_3

					if var_669_3 + 0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_3 + 0
					end
				end

				arg_666_1.text_.text = var_669_1
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_4 = math.max(var_669_0, arg_666_1.talkMaxDuration)

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_4 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - 0) / var_669_4

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= 0 + var_669_4 and arg_666_1.time_ < 0 + var_669_4 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play1104105164 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 1104105164
		arg_670_1.duration_ = 3.47

		local var_670_0 = {
			zh = 3.033,
			ja = 3.466
		}
		local var_670_1 = manager.audio:GetLocalizationFlag()

		if var_670_0[var_670_1] ~= nil then
			arg_670_1.duration_ = var_670_0[var_670_1]
		end

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play1104105165(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 and not isNil(arg_670_1.actors_["1041ui_story"]) and arg_670_1.var_.characterEffect1041ui_story == nil then
				arg_670_1.var_.characterEffect1041ui_story = arg_670_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_673_0 = 0.200000002980232

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_0 and not isNil(arg_670_1.actors_["1041ui_story"]) then
				if arg_670_1.var_.characterEffect1041ui_story and not isNil(arg_670_1.actors_["1041ui_story"]) then
					arg_670_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_670_1.time_ >= 0 + var_673_0 and arg_670_1.time_ < 0 + var_673_0 + arg_673_0 and not isNil(arg_670_1.actors_["1041ui_story"]) and arg_670_1.var_.characterEffect1041ui_story then
				arg_670_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_673_2 = 0
			local var_673_3 = 0.55

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_2 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, true)

				arg_670_1.leftNameTxt_.text = arg_670_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_670_1.leftNameTxt_.transform)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1.leftNameTxt_.text)
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_4 = arg_670_1:GetWordFromCfg(1104105164)
				local var_673_5 = arg_670_1:FormatText(var_673_4.content)

				arg_670_1.text_.text = var_673_5

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_7 = 22 <= 0 and var_673_3 or var_673_3 * (utf8.len(var_673_5) / 22)

				if (22 <= 0 and var_673_3 or var_673_3 * (utf8.len(var_673_5) / 22)) > 0 and var_673_3 < var_673_7 then
					arg_670_1.talkMaxDuration = var_673_7

					if var_673_7 + var_673_2 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_7 + var_673_2
					end
				end

				arg_670_1.text_.text = var_673_5
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105164", "story_v_side_new_1104105.awb") ~= 0 then
					local var_673_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105164", "story_v_side_new_1104105.awb") / 1000

					if var_673_8 + var_673_2 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_8 + var_673_2
					end

					if var_673_4.prefab_name ~= "" and arg_670_1.actors_[var_673_4.prefab_name] ~= nil then
						local var_673_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_670_1.actors_[var_673_4.prefab_name].transform, "story_v_side_new_1104105", "1104105164", "story_v_side_new_1104105.awb")

						arg_670_1:RecordAudio("1104105164", var_673_9)
						arg_670_1:RecordAudio("1104105164", var_673_9)
					else
						arg_670_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105164", "story_v_side_new_1104105.awb")
					end

					arg_670_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105164", "story_v_side_new_1104105.awb")
				end

				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_10 = math.max(var_673_3, arg_670_1.talkMaxDuration)

			if var_673_2 <= arg_670_1.time_ and arg_670_1.time_ < var_673_2 + var_673_10 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_2) / var_673_10

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_2 + var_673_10 and arg_670_1.time_ < var_673_2 + var_673_10 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play1104105165 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 1104105165
		arg_674_1.duration_ = 10.2

		local var_674_0 = {
			zh = 9.433,
			ja = 10.2
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play1104105166(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = 1

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				arg_674_1.leftNameTxt_.text = arg_674_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_1 = arg_674_1:GetWordFromCfg(1104105165)
				local var_677_2 = arg_674_1:FormatText(var_677_1.content)

				arg_674_1.text_.text = var_677_2

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_4 = 40 <= 0 and var_677_0 or var_677_0 * (utf8.len(var_677_2) / 40)

				if (40 <= 0 and var_677_0 or var_677_0 * (utf8.len(var_677_2) / 40)) > 0 and var_677_0 < var_677_4 then
					arg_674_1.talkMaxDuration = var_677_4

					if var_677_4 + 0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_4 + 0
					end
				end

				arg_674_1.text_.text = var_677_2
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105165", "story_v_side_new_1104105.awb") ~= 0 then
					local var_677_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105165", "story_v_side_new_1104105.awb") / 1000

					if var_677_5 + 0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_5 + 0
					end

					if var_677_1.prefab_name ~= "" and arg_674_1.actors_[var_677_1.prefab_name] ~= nil then
						local var_677_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_1.prefab_name].transform, "story_v_side_new_1104105", "1104105165", "story_v_side_new_1104105.awb")

						arg_674_1:RecordAudio("1104105165", var_677_6)
						arg_674_1:RecordAudio("1104105165", var_677_6)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105165", "story_v_side_new_1104105.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105165", "story_v_side_new_1104105.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_7 = math.max(var_677_0, arg_674_1.talkMaxDuration)

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_7 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - 0) / var_677_7

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= 0 + var_677_7 and arg_674_1.time_ < 0 + var_677_7 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play1104105166 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1104105166
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1104105167(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0.3

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				arg_678_1.leftNameTxt_.text = arg_678_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_1 = arg_678_1:FormatText(arg_678_1:GetWordFromCfg(1104105166).content)

				arg_678_1.text_.text = var_681_1

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_3 = 12 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_1) / 12)

				if (12 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_1) / 12)) > 0 and var_681_0 < var_681_3 then
					arg_678_1.talkMaxDuration = var_681_3

					if var_681_3 + 0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_3 + 0
					end
				end

				arg_678_1.text_.text = var_681_1
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_4 = math.max(var_681_0, arg_678_1.talkMaxDuration)

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_4 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - 0) / var_681_4

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= 0 + var_681_4 and arg_678_1.time_ < 0 + var_681_4 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play1104105167 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 1104105167
		arg_682_1.duration_ = 15.9

		local var_682_0 = {
			zh = 14.766,
			ja = 15.9
		}
		local var_682_1 = manager.audio:GetLocalizationFlag()

		if var_682_0[var_682_1] ~= nil then
			arg_682_1.duration_ = var_682_0[var_682_1]
		end

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play1104105168(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 and not isNil(arg_682_1.actors_["1041ui_story"]) and arg_682_1.var_.characterEffect1041ui_story == nil then
				arg_682_1.var_.characterEffect1041ui_story = arg_682_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_685_0 = 0.200000002980232

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_0 and not isNil(arg_682_1.actors_["1041ui_story"]) then
				if arg_682_1.var_.characterEffect1041ui_story and not isNil(arg_682_1.actors_["1041ui_story"]) then
					arg_682_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_682_1.time_ >= 0 + var_685_0 and arg_682_1.time_ < 0 + var_685_0 + arg_685_0 and not isNil(arg_682_1.actors_["1041ui_story"]) and arg_682_1.var_.characterEffect1041ui_story then
				arg_682_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			local var_685_2 = 0
			local var_685_3 = 1.725

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_2 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				arg_682_1.leftNameTxt_.text = arg_682_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_4 = arg_682_1:GetWordFromCfg(1104105167)
				local var_685_5 = arg_682_1:FormatText(var_685_4.content)

				arg_682_1.text_.text = var_685_5

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_7 = 69 <= 0 and var_685_3 or var_685_3 * (utf8.len(var_685_5) / 69)

				if (69 <= 0 and var_685_3 or var_685_3 * (utf8.len(var_685_5) / 69)) > 0 and var_685_3 < var_685_7 then
					arg_682_1.talkMaxDuration = var_685_7

					if var_685_7 + var_685_2 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_7 + var_685_2
					end
				end

				arg_682_1.text_.text = var_685_5
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105167", "story_v_side_new_1104105.awb") ~= 0 then
					local var_685_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105167", "story_v_side_new_1104105.awb") / 1000

					if var_685_8 + var_685_2 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_8 + var_685_2
					end

					if var_685_4.prefab_name ~= "" and arg_682_1.actors_[var_685_4.prefab_name] ~= nil then
						local var_685_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_4.prefab_name].transform, "story_v_side_new_1104105", "1104105167", "story_v_side_new_1104105.awb")

						arg_682_1:RecordAudio("1104105167", var_685_9)
						arg_682_1:RecordAudio("1104105167", var_685_9)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105167", "story_v_side_new_1104105.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105167", "story_v_side_new_1104105.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_10 = math.max(var_685_3, arg_682_1.talkMaxDuration)

			if var_685_2 <= arg_682_1.time_ and arg_682_1.time_ < var_685_2 + var_685_10 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_2) / var_685_10

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_2 + var_685_10 and arg_682_1.time_ < var_685_2 + var_685_10 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {}

		arg_682_1:InitPlayNodeList()
	end,
	Play1104105168 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 1104105168
		arg_686_1.duration_ = 8.23

		local var_686_0 = {
			zh = 6.4,
			ja = 8.233
		}
		local var_686_1 = manager.audio:GetLocalizationFlag()

		if var_686_0[var_686_1] ~= nil then
			arg_686_1.duration_ = var_686_0[var_686_1]
		end

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play1104105169(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			local var_689_0 = 0.775

			if 0 < arg_686_1.time_ and arg_686_1.time_ <= 0 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, true)

				arg_686_1.leftNameTxt_.text = arg_686_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, false)
				arg_686_1.callingController_:SetSelectedState("normal")

				local var_689_1 = arg_686_1:GetWordFromCfg(1104105168)
				local var_689_2 = arg_686_1:FormatText(var_689_1.content)

				arg_686_1.text_.text = var_689_2

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_4 = 31 <= 0 and var_689_0 or var_689_0 * (utf8.len(var_689_2) / 31)

				if (31 <= 0 and var_689_0 or var_689_0 * (utf8.len(var_689_2) / 31)) > 0 and var_689_0 < var_689_4 then
					arg_686_1.talkMaxDuration = var_689_4

					if var_689_4 + 0 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_4 + 0
					end
				end

				arg_686_1.text_.text = var_689_2
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105168", "story_v_side_new_1104105.awb") ~= 0 then
					local var_689_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105168", "story_v_side_new_1104105.awb") / 1000

					if var_689_5 + 0 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_5 + 0
					end

					if var_689_1.prefab_name ~= "" and arg_686_1.actors_[var_689_1.prefab_name] ~= nil then
						local var_689_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_686_1.actors_[var_689_1.prefab_name].transform, "story_v_side_new_1104105", "1104105168", "story_v_side_new_1104105.awb")

						arg_686_1:RecordAudio("1104105168", var_689_6)
						arg_686_1:RecordAudio("1104105168", var_689_6)
					else
						arg_686_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105168", "story_v_side_new_1104105.awb")
					end

					arg_686_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105168", "story_v_side_new_1104105.awb")
				end

				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_7 = math.max(var_689_0, arg_686_1.talkMaxDuration)

			if 0 <= arg_686_1.time_ and arg_686_1.time_ < 0 + var_689_7 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - 0) / var_689_7

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= 0 + var_689_7 and arg_686_1.time_ < 0 + var_689_7 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play1104105169 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 1104105169
		arg_690_1.duration_ = 5

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play1104105170(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 and not isNil(arg_690_1.actors_["1041ui_story"]) and arg_690_1.var_.characterEffect1041ui_story == nil then
				arg_690_1.var_.characterEffect1041ui_story = arg_690_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_693_0 = 0.200000002980232

			if 0 <= arg_690_1.time_ and arg_690_1.time_ < 0 + var_693_0 and not isNil(arg_690_1.actors_["1041ui_story"]) then
				if arg_690_1.var_.characterEffect1041ui_story and not isNil(arg_690_1.actors_["1041ui_story"]) then
					arg_690_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_690_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_690_1.time_ - 0) / var_693_0)
				end
			end

			if arg_690_1.time_ >= 0 + var_693_0 and arg_690_1.time_ < 0 + var_693_0 + arg_693_0 and not isNil(arg_690_1.actors_["1041ui_story"]) and arg_690_1.var_.characterEffect1041ui_story then
				arg_690_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_690_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_693_1 = 0
			local var_693_2 = 0.575

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= var_693_1 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				arg_690_1.leftNameTxt_.text = arg_690_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, true)
				arg_690_1.iconController_:SetSelectedState("hero")

				arg_690_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_690_1.callingController_:SetSelectedState("normal")

				arg_690_1.keyicon_.color = Color.New(1, 1, 1)
				arg_690_1.icon_.color = Color.New(1, 1, 1)

				local var_693_3 = arg_690_1:FormatText(arg_690_1:GetWordFromCfg(1104105169).content)

				arg_690_1.text_.text = var_693_3

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_5 = 23 <= 0 and var_693_2 or var_693_2 * (utf8.len(var_693_3) / 23)

				if (23 <= 0 and var_693_2 or var_693_2 * (utf8.len(var_693_3) / 23)) > 0 and var_693_2 < var_693_5 then
					arg_690_1.talkMaxDuration = var_693_5

					if var_693_5 + var_693_1 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_5 + var_693_1
					end
				end

				arg_690_1.text_.text = var_693_3
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)
				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_6 = math.max(var_693_2, arg_690_1.talkMaxDuration)

			if var_693_1 <= arg_690_1.time_ and arg_690_1.time_ < var_693_1 + var_693_6 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_1) / var_693_6

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_1 + var_693_6 and arg_690_1.time_ < var_693_1 + var_693_6 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play1104105170 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 1104105170
		arg_694_1.duration_ = 5

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play1104105171(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			local var_697_0 = 0.475

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, true)

				arg_694_1.leftNameTxt_.text = arg_694_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_694_1.leftNameTxt_.transform)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1.leftNameTxt_.text)
				SetActive(arg_694_1.iconTrs_.gameObject, true)
				arg_694_1.iconController_:SetSelectedState("hero")

				arg_694_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_694_1.callingController_:SetSelectedState("normal")

				arg_694_1.keyicon_.color = Color.New(1, 1, 1)
				arg_694_1.icon_.color = Color.New(1, 1, 1)

				local var_697_1 = arg_694_1:FormatText(arg_694_1:GetWordFromCfg(1104105170).content)

				arg_694_1.text_.text = var_697_1

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_3 = 19 <= 0 and var_697_0 or var_697_0 * (utf8.len(var_697_1) / 19)

				if (19 <= 0 and var_697_0 or var_697_0 * (utf8.len(var_697_1) / 19)) > 0 and var_697_0 < var_697_3 then
					arg_694_1.talkMaxDuration = var_697_3

					if var_697_3 + 0 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_3 + 0
					end
				end

				arg_694_1.text_.text = var_697_1
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)
				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_4 = math.max(var_697_0, arg_694_1.talkMaxDuration)

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_4 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - 0) / var_697_4

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= 0 + var_697_4 and arg_694_1.time_ < 0 + var_697_4 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {}

		arg_694_1:InitPlayNodeList()
	end,
	Play1104105171 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 1104105171
		arg_698_1.duration_ = 5

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play1104105172(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			local var_701_0 = 0.625

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, false)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_698_1.iconTrs_.gameObject, false)
				arg_698_1.callingController_:SetSelectedState("normal")

				local var_701_1 = arg_698_1:FormatText(arg_698_1:GetWordFromCfg(1104105171).content)

				arg_698_1.text_.text = var_701_1

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_3 = 25 <= 0 and var_701_0 or var_701_0 * (utf8.len(var_701_1) / 25)

				if (25 <= 0 and var_701_0 or var_701_0 * (utf8.len(var_701_1) / 25)) > 0 and var_701_0 < var_701_3 then
					arg_698_1.talkMaxDuration = var_701_3

					if var_701_3 + 0 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_3 + 0
					end
				end

				arg_698_1.text_.text = var_701_1
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_4 = math.max(var_701_0, arg_698_1.talkMaxDuration)

			if 0 <= arg_698_1.time_ and arg_698_1.time_ < 0 + var_701_4 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - 0) / var_701_4

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= 0 + var_701_4 and arg_698_1.time_ < 0 + var_701_4 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {}

		arg_698_1:InitPlayNodeList()
	end,
	Play1104105172 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 1104105172
		arg_702_1.duration_ = 1.17

		local var_702_0 = {
			zh = 1.166,
			ja = 1
		}
		local var_702_1 = manager.audio:GetLocalizationFlag()

		if var_702_0[var_702_1] ~= nil then
			arg_702_1.duration_ = var_702_0[var_702_1]
		end

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play1104105173(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 and not isNil(arg_702_1.actors_["1041ui_story"]) and arg_702_1.var_.characterEffect1041ui_story == nil then
				arg_702_1.var_.characterEffect1041ui_story = arg_702_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_705_0 = 0.200000002980232

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_0 and not isNil(arg_702_1.actors_["1041ui_story"]) then
				if arg_702_1.var_.characterEffect1041ui_story and not isNil(arg_702_1.actors_["1041ui_story"]) then
					arg_702_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_702_1.time_ >= 0 + var_705_0 and arg_702_1.time_ < 0 + var_705_0 + arg_705_0 and not isNil(arg_702_1.actors_["1041ui_story"]) and arg_702_1.var_.characterEffect1041ui_story then
				arg_702_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_705_2 = 0
			local var_705_3 = 0.05

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_2 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, true)

				arg_702_1.leftNameTxt_.text = arg_702_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, false)
				arg_702_1.callingController_:SetSelectedState("normal")

				local var_705_4 = arg_702_1:GetWordFromCfg(1104105172)
				local var_705_5 = arg_702_1:FormatText(var_705_4.content)

				arg_702_1.text_.text = var_705_5

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_7 = 2 <= 0 and var_705_3 or var_705_3 * (utf8.len(var_705_5) / 2)

				if (2 <= 0 and var_705_3 or var_705_3 * (utf8.len(var_705_5) / 2)) > 0 and var_705_3 < var_705_7 then
					arg_702_1.talkMaxDuration = var_705_7

					if var_705_7 + var_705_2 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_7 + var_705_2
					end
				end

				arg_702_1.text_.text = var_705_5
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105172", "story_v_side_new_1104105.awb") ~= 0 then
					local var_705_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105172", "story_v_side_new_1104105.awb") / 1000

					if var_705_8 + var_705_2 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_8 + var_705_2
					end

					if var_705_4.prefab_name ~= "" and arg_702_1.actors_[var_705_4.prefab_name] ~= nil then
						local var_705_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_702_1.actors_[var_705_4.prefab_name].transform, "story_v_side_new_1104105", "1104105172", "story_v_side_new_1104105.awb")

						arg_702_1:RecordAudio("1104105172", var_705_9)
						arg_702_1:RecordAudio("1104105172", var_705_9)
					else
						arg_702_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105172", "story_v_side_new_1104105.awb")
					end

					arg_702_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105172", "story_v_side_new_1104105.awb")
				end

				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_10 = math.max(var_705_3, arg_702_1.talkMaxDuration)

			if var_705_2 <= arg_702_1.time_ and arg_702_1.time_ < var_705_2 + var_705_10 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_2) / var_705_10

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_2 + var_705_10 and arg_702_1.time_ < var_705_2 + var_705_10 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play1104105173 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 1104105173
		arg_706_1.duration_ = 18.7

		local var_706_0 = {
			zh = 15.1,
			ja = 18.7
		}
		local var_706_1 = manager.audio:GetLocalizationFlag()

		if var_706_0[var_706_1] ~= nil then
			arg_706_1.duration_ = var_706_0[var_706_1]
		end

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play1104105174(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			local var_709_0 = 1.75

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0
				arg_706_1.dialogCg_.alpha = 1

				arg_706_1.dialog_:SetActive(true)
				SetActive(arg_706_1.leftNameGo_, true)

				arg_706_1.leftNameTxt_.text = arg_706_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_706_1.leftNameTxt_.transform)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1.leftNameTxt_.text)
				SetActive(arg_706_1.iconTrs_.gameObject, false)
				arg_706_1.callingController_:SetSelectedState("normal")

				local var_709_1 = arg_706_1:GetWordFromCfg(1104105173)
				local var_709_2 = arg_706_1:FormatText(var_709_1.content)

				arg_706_1.text_.text = var_709_2

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_4 = 70 <= 0 and var_709_0 or var_709_0 * (utf8.len(var_709_2) / 70)

				if (70 <= 0 and var_709_0 or var_709_0 * (utf8.len(var_709_2) / 70)) > 0 and var_709_0 < var_709_4 then
					arg_706_1.talkMaxDuration = var_709_4

					if var_709_4 + 0 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_4 + 0
					end
				end

				arg_706_1.text_.text = var_709_2
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105173", "story_v_side_new_1104105.awb") ~= 0 then
					local var_709_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105173", "story_v_side_new_1104105.awb") / 1000

					if var_709_5 + 0 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_5 + 0
					end

					if var_709_1.prefab_name ~= "" and arg_706_1.actors_[var_709_1.prefab_name] ~= nil then
						local var_709_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_706_1.actors_[var_709_1.prefab_name].transform, "story_v_side_new_1104105", "1104105173", "story_v_side_new_1104105.awb")

						arg_706_1:RecordAudio("1104105173", var_709_6)
						arg_706_1:RecordAudio("1104105173", var_709_6)
					else
						arg_706_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105173", "story_v_side_new_1104105.awb")
					end

					arg_706_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105173", "story_v_side_new_1104105.awb")
				end

				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_7 = math.max(var_709_0, arg_706_1.talkMaxDuration)

			if 0 <= arg_706_1.time_ and arg_706_1.time_ < 0 + var_709_7 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - 0) / var_709_7

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= 0 + var_709_7 and arg_706_1.time_ < 0 + var_709_7 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {}

		arg_706_1:InitPlayNodeList()
	end,
	Play1104105174 = function(arg_710_0, arg_710_1)
		arg_710_1.time_ = 0
		arg_710_1.frameCnt_ = 0
		arg_710_1.state_ = "playing"
		arg_710_1.curTalkId_ = 1104105174
		arg_710_1.duration_ = 5

		SetActive(arg_710_1.tipsGo_, false)

		function arg_710_1.onSingleLineFinish_()
			arg_710_1.onSingleLineUpdate_ = nil
			arg_710_1.onSingleLineFinish_ = nil
			arg_710_1.state_ = "waiting"
		end

		function arg_710_1.playNext_(arg_712_0)
			if arg_712_0 == 1 then
				arg_710_0:Play1104105175(arg_710_1)
			end
		end

		function arg_710_1.onSingleLineUpdate_(arg_713_0)
			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 and not isNil(arg_710_1.actors_["1041ui_story"]) and arg_710_1.var_.characterEffect1041ui_story == nil then
				arg_710_1.var_.characterEffect1041ui_story = arg_710_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_713_0 = 0.200000002980232

			if 0 <= arg_710_1.time_ and arg_710_1.time_ < 0 + var_713_0 and not isNil(arg_710_1.actors_["1041ui_story"]) then
				if arg_710_1.var_.characterEffect1041ui_story and not isNil(arg_710_1.actors_["1041ui_story"]) then
					arg_710_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_710_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_710_1.time_ - 0) / var_713_0)
				end
			end

			if arg_710_1.time_ >= 0 + var_713_0 and arg_710_1.time_ < 0 + var_713_0 + arg_713_0 and not isNil(arg_710_1.actors_["1041ui_story"]) and arg_710_1.var_.characterEffect1041ui_story then
				arg_710_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_710_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_713_1 = 0
			local var_713_2 = 0.75

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= var_713_1 + arg_713_0 then
				arg_710_1.talkMaxDuration = 0
				arg_710_1.dialogCg_.alpha = 1

				arg_710_1.dialog_:SetActive(true)
				SetActive(arg_710_1.leftNameGo_, false)

				arg_710_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_710_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_710_1:RecordName(arg_710_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_710_1.iconTrs_.gameObject, false)
				arg_710_1.callingController_:SetSelectedState("normal")

				local var_713_3 = arg_710_1:FormatText(arg_710_1:GetWordFromCfg(1104105174).content)

				arg_710_1.text_.text = var_713_3

				LuaForUtil.ClearLinePrefixSymbol(arg_710_1.text_)

				local var_713_5 = 30 <= 0 and var_713_2 or var_713_2 * (utf8.len(var_713_3) / 30)

				if (30 <= 0 and var_713_2 or var_713_2 * (utf8.len(var_713_3) / 30)) > 0 and var_713_2 < var_713_5 then
					arg_710_1.talkMaxDuration = var_713_5

					if var_713_5 + var_713_1 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_5 + var_713_1
					end
				end

				arg_710_1.text_.text = var_713_3
				arg_710_1.typewritter.percent = 0

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(false)
				arg_710_1:RecordContent(arg_710_1.text_.text)
			end

			local var_713_6 = math.max(var_713_2, arg_710_1.talkMaxDuration)

			if var_713_1 <= arg_710_1.time_ and arg_710_1.time_ < var_713_1 + var_713_6 then
				arg_710_1.typewritter.percent = (arg_710_1.time_ - var_713_1) / var_713_6

				arg_710_1.typewritter:SetDirty()
			end

			if arg_710_1.time_ >= var_713_1 + var_713_6 and arg_710_1.time_ < var_713_1 + var_713_6 + arg_713_0 then
				arg_710_1.typewritter.percent = 1

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(true)
			end
		end

		arg_710_1.nodeConfigList_ = {}

		arg_710_1:InitPlayNodeList()
	end,
	Play1104105175 = function(arg_714_0, arg_714_1)
		arg_714_1.time_ = 0
		arg_714_1.frameCnt_ = 0
		arg_714_1.state_ = "playing"
		arg_714_1.curTalkId_ = 1104105175
		arg_714_1.duration_ = 5

		SetActive(arg_714_1.tipsGo_, false)

		function arg_714_1.onSingleLineFinish_()
			arg_714_1.onSingleLineUpdate_ = nil
			arg_714_1.onSingleLineFinish_ = nil
			arg_714_1.state_ = "waiting"
		end

		function arg_714_1.playNext_(arg_716_0)
			if arg_716_0 == 1 then
				arg_714_0:Play1104105176(arg_714_1)
			end
		end

		function arg_714_1.onSingleLineUpdate_(arg_717_0)
			local var_717_0 = 0.225

			if 0 < arg_714_1.time_ and arg_714_1.time_ <= 0 + arg_717_0 then
				arg_714_1.talkMaxDuration = 0
				arg_714_1.dialogCg_.alpha = 1

				arg_714_1.dialog_:SetActive(true)
				SetActive(arg_714_1.leftNameGo_, true)

				arg_714_1.leftNameTxt_.text = arg_714_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_714_1.leftNameTxt_.transform)

				arg_714_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_714_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_714_1:RecordName(arg_714_1.leftNameTxt_.text)
				SetActive(arg_714_1.iconTrs_.gameObject, true)
				arg_714_1.iconController_:SetSelectedState("hero")

				arg_714_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_714_1.callingController_:SetSelectedState("normal")

				arg_714_1.keyicon_.color = Color.New(1, 1, 1)
				arg_714_1.icon_.color = Color.New(1, 1, 1)

				local var_717_1 = arg_714_1:FormatText(arg_714_1:GetWordFromCfg(1104105175).content)

				arg_714_1.text_.text = var_717_1

				LuaForUtil.ClearLinePrefixSymbol(arg_714_1.text_)

				local var_717_3 = 9 <= 0 and var_717_0 or var_717_0 * (utf8.len(var_717_1) / 9)

				if (9 <= 0 and var_717_0 or var_717_0 * (utf8.len(var_717_1) / 9)) > 0 and var_717_0 < var_717_3 then
					arg_714_1.talkMaxDuration = var_717_3

					if var_717_3 + 0 > arg_714_1.duration_ then
						arg_714_1.duration_ = var_717_3 + 0
					end
				end

				arg_714_1.text_.text = var_717_1
				arg_714_1.typewritter.percent = 0

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(false)
				arg_714_1:RecordContent(arg_714_1.text_.text)
			end

			local var_717_4 = math.max(var_717_0, arg_714_1.talkMaxDuration)

			if 0 <= arg_714_1.time_ and arg_714_1.time_ < 0 + var_717_4 then
				arg_714_1.typewritter.percent = (arg_714_1.time_ - 0) / var_717_4

				arg_714_1.typewritter:SetDirty()
			end

			if arg_714_1.time_ >= 0 + var_717_4 and arg_714_1.time_ < 0 + var_717_4 + arg_717_0 then
				arg_714_1.typewritter.percent = 1

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(true)
			end
		end

		arg_714_1.nodeConfigList_ = {}

		arg_714_1:InitPlayNodeList()
	end,
	Play1104105176 = function(arg_718_0, arg_718_1)
		arg_718_1.time_ = 0
		arg_718_1.frameCnt_ = 0
		arg_718_1.state_ = "playing"
		arg_718_1.curTalkId_ = 1104105176
		arg_718_1.duration_ = 2

		SetActive(arg_718_1.tipsGo_, false)

		function arg_718_1.onSingleLineFinish_()
			arg_718_1.onSingleLineUpdate_ = nil
			arg_718_1.onSingleLineFinish_ = nil
			arg_718_1.state_ = "waiting"
		end

		function arg_718_1.playNext_(arg_720_0)
			if arg_720_0 == 1 then
				arg_718_0:Play1104105177(arg_718_1)
			end
		end

		function arg_718_1.onSingleLineUpdate_(arg_721_0)
			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 and not isNil(arg_718_1.actors_["1041ui_story"]) and arg_718_1.var_.characterEffect1041ui_story == nil then
				arg_718_1.var_.characterEffect1041ui_story = arg_718_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_721_0 = 0.200000002980232

			if 0 <= arg_718_1.time_ and arg_718_1.time_ < 0 + var_721_0 and not isNil(arg_718_1.actors_["1041ui_story"]) then
				if arg_718_1.var_.characterEffect1041ui_story and not isNil(arg_718_1.actors_["1041ui_story"]) then
					arg_718_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_718_1.time_ >= 0 + var_721_0 and arg_718_1.time_ < 0 + var_721_0 + arg_721_0 and not isNil(arg_718_1.actors_["1041ui_story"]) and arg_718_1.var_.characterEffect1041ui_story then
				arg_718_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 then
				arg_718_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_721_2 = 0
			local var_721_3 = 0.05

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= var_721_2 + arg_721_0 then
				arg_718_1.talkMaxDuration = 0
				arg_718_1.dialogCg_.alpha = 1

				arg_718_1.dialog_:SetActive(true)
				SetActive(arg_718_1.leftNameGo_, true)

				arg_718_1.leftNameTxt_.text = arg_718_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_718_1.leftNameTxt_.transform)

				arg_718_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_718_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_718_1:RecordName(arg_718_1.leftNameTxt_.text)
				SetActive(arg_718_1.iconTrs_.gameObject, false)
				arg_718_1.callingController_:SetSelectedState("normal")

				local var_721_4 = arg_718_1:GetWordFromCfg(1104105176)
				local var_721_5 = arg_718_1:FormatText(var_721_4.content)

				arg_718_1.text_.text = var_721_5

				LuaForUtil.ClearLinePrefixSymbol(arg_718_1.text_)

				local var_721_7 = 2 <= 0 and var_721_3 or var_721_3 * (utf8.len(var_721_5) / 2)

				if (2 <= 0 and var_721_3 or var_721_3 * (utf8.len(var_721_5) / 2)) > 0 and var_721_3 < var_721_7 then
					arg_718_1.talkMaxDuration = var_721_7

					if var_721_7 + var_721_2 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_7 + var_721_2
					end
				end

				arg_718_1.text_.text = var_721_5
				arg_718_1.typewritter.percent = 0

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105176", "story_v_side_new_1104105.awb") ~= 0 then
					local var_721_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105176", "story_v_side_new_1104105.awb") / 1000

					if var_721_8 + var_721_2 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_8 + var_721_2
					end

					if var_721_4.prefab_name ~= "" and arg_718_1.actors_[var_721_4.prefab_name] ~= nil then
						local var_721_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_718_1.actors_[var_721_4.prefab_name].transform, "story_v_side_new_1104105", "1104105176", "story_v_side_new_1104105.awb")

						arg_718_1:RecordAudio("1104105176", var_721_9)
						arg_718_1:RecordAudio("1104105176", var_721_9)
					else
						arg_718_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105176", "story_v_side_new_1104105.awb")
					end

					arg_718_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105176", "story_v_side_new_1104105.awb")
				end

				arg_718_1:RecordContent(arg_718_1.text_.text)
			end

			local var_721_10 = math.max(var_721_3, arg_718_1.talkMaxDuration)

			if var_721_2 <= arg_718_1.time_ and arg_718_1.time_ < var_721_2 + var_721_10 then
				arg_718_1.typewritter.percent = (arg_718_1.time_ - var_721_2) / var_721_10

				arg_718_1.typewritter:SetDirty()
			end

			if arg_718_1.time_ >= var_721_2 + var_721_10 and arg_718_1.time_ < var_721_2 + var_721_10 + arg_721_0 then
				arg_718_1.typewritter.percent = 1

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(true)
			end
		end

		arg_718_1.nodeConfigList_ = {}

		arg_718_1:InitPlayNodeList()
	end,
	Play1104105177 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1104105177
		arg_722_1.duration_ = 5

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1104105178(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 and not isNil(arg_722_1.actors_["1041ui_story"]) and arg_722_1.var_.characterEffect1041ui_story == nil then
				arg_722_1.var_.characterEffect1041ui_story = arg_722_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_725_0 = 0.200000002980232

			if 0 <= arg_722_1.time_ and arg_722_1.time_ < 0 + var_725_0 and not isNil(arg_722_1.actors_["1041ui_story"]) then
				if arg_722_1.var_.characterEffect1041ui_story and not isNil(arg_722_1.actors_["1041ui_story"]) then
					arg_722_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_722_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_722_1.time_ - 0) / var_725_0)
				end
			end

			if arg_722_1.time_ >= 0 + var_725_0 and arg_722_1.time_ < 0 + var_725_0 + arg_725_0 and not isNil(arg_722_1.actors_["1041ui_story"]) and arg_722_1.var_.characterEffect1041ui_story then
				arg_722_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_722_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_725_1 = 0
			local var_725_2 = 0.65

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= var_725_1 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				arg_722_1.leftNameTxt_.text = arg_722_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, true)
				arg_722_1.iconController_:SetSelectedState("hero")

				arg_722_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_722_1.callingController_:SetSelectedState("normal")

				arg_722_1.keyicon_.color = Color.New(1, 1, 1)
				arg_722_1.icon_.color = Color.New(1, 1, 1)

				local var_725_3 = arg_722_1:FormatText(arg_722_1:GetWordFromCfg(1104105177).content)

				arg_722_1.text_.text = var_725_3

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_5 = 26 <= 0 and var_725_2 or var_725_2 * (utf8.len(var_725_3) / 26)

				if (26 <= 0 and var_725_2 or var_725_2 * (utf8.len(var_725_3) / 26)) > 0 and var_725_2 < var_725_5 then
					arg_722_1.talkMaxDuration = var_725_5

					if var_725_5 + var_725_1 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_5 + var_725_1
					end
				end

				arg_722_1.text_.text = var_725_3
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)
				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_6 = math.max(var_725_2, arg_722_1.talkMaxDuration)

			if var_725_1 <= arg_722_1.time_ and arg_722_1.time_ < var_725_1 + var_725_6 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_1) / var_725_6

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_1 + var_725_6 and arg_722_1.time_ < var_725_1 + var_725_6 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {}

		arg_722_1:InitPlayNodeList()
	end,
	Play1104105178 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1104105178
		arg_726_1.duration_ = 2

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1104105179(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 and not isNil(arg_726_1.actors_["1041ui_story"]) and arg_726_1.var_.characterEffect1041ui_story == nil then
				arg_726_1.var_.characterEffect1041ui_story = arg_726_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_729_0 = 0.200000002980232

			if 0 <= arg_726_1.time_ and arg_726_1.time_ < 0 + var_729_0 and not isNil(arg_726_1.actors_["1041ui_story"]) then
				if arg_726_1.var_.characterEffect1041ui_story and not isNil(arg_726_1.actors_["1041ui_story"]) then
					arg_726_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_726_1.time_ >= 0 + var_729_0 and arg_726_1.time_ < 0 + var_729_0 + arg_729_0 and not isNil(arg_726_1.actors_["1041ui_story"]) and arg_726_1.var_.characterEffect1041ui_story then
				arg_726_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_729_2 = 0
			local var_729_3 = 0.075

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= var_729_2 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				arg_726_1.leftNameTxt_.text = arg_726_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, false)
				arg_726_1.callingController_:SetSelectedState("normal")

				local var_729_4 = arg_726_1:GetWordFromCfg(1104105178)
				local var_729_5 = arg_726_1:FormatText(var_729_4.content)

				arg_726_1.text_.text = var_729_5

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_7 = 3 <= 0 and var_729_3 or var_729_3 * (utf8.len(var_729_5) / 3)

				if (3 <= 0 and var_729_3 or var_729_3 * (utf8.len(var_729_5) / 3)) > 0 and var_729_3 < var_729_7 then
					arg_726_1.talkMaxDuration = var_729_7

					if var_729_7 + var_729_2 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_7 + var_729_2
					end
				end

				arg_726_1.text_.text = var_729_5
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105178", "story_v_side_new_1104105.awb") ~= 0 then
					local var_729_8 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105178", "story_v_side_new_1104105.awb") / 1000

					if var_729_8 + var_729_2 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_8 + var_729_2
					end

					if var_729_4.prefab_name ~= "" and arg_726_1.actors_[var_729_4.prefab_name] ~= nil then
						local var_729_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_726_1.actors_[var_729_4.prefab_name].transform, "story_v_side_new_1104105", "1104105178", "story_v_side_new_1104105.awb")

						arg_726_1:RecordAudio("1104105178", var_729_9)
						arg_726_1:RecordAudio("1104105178", var_729_9)
					else
						arg_726_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105178", "story_v_side_new_1104105.awb")
					end

					arg_726_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105178", "story_v_side_new_1104105.awb")
				end

				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_10 = math.max(var_729_3, arg_726_1.talkMaxDuration)

			if var_729_2 <= arg_726_1.time_ and arg_726_1.time_ < var_729_2 + var_729_10 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_2) / var_729_10

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_2 + var_729_10 and arg_726_1.time_ < var_729_2 + var_729_10 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {}

		arg_726_1:InitPlayNodeList()
	end,
	Play1104105179 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1104105179
		arg_730_1.duration_ = 8.87

		local var_730_0 = {
			zh = 5.9,
			ja = 8.866
		}
		local var_730_1 = manager.audio:GetLocalizationFlag()

		if var_730_0[var_730_1] ~= nil then
			arg_730_1.duration_ = var_730_0[var_730_1]
		end

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1104105180(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			local var_733_0 = 0.475

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				arg_730_1.leftNameTxt_.text = arg_730_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, false)
				arg_730_1.callingController_:SetSelectedState("normal")

				local var_733_1 = arg_730_1:GetWordFromCfg(1104105179)
				local var_733_2 = arg_730_1:FormatText(var_733_1.content)

				arg_730_1.text_.text = var_733_2

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_4 = 19 <= 0 and var_733_0 or var_733_0 * (utf8.len(var_733_2) / 19)

				if (19 <= 0 and var_733_0 or var_733_0 * (utf8.len(var_733_2) / 19)) > 0 and var_733_0 < var_733_4 then
					arg_730_1.talkMaxDuration = var_733_4

					if var_733_4 + 0 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_4 + 0
					end
				end

				arg_730_1.text_.text = var_733_2
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105179", "story_v_side_new_1104105.awb") ~= 0 then
					local var_733_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105179", "story_v_side_new_1104105.awb") / 1000

					if var_733_5 + 0 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_5 + 0
					end

					if var_733_1.prefab_name ~= "" and arg_730_1.actors_[var_733_1.prefab_name] ~= nil then
						local var_733_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_730_1.actors_[var_733_1.prefab_name].transform, "story_v_side_new_1104105", "1104105179", "story_v_side_new_1104105.awb")

						arg_730_1:RecordAudio("1104105179", var_733_6)
						arg_730_1:RecordAudio("1104105179", var_733_6)
					else
						arg_730_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105179", "story_v_side_new_1104105.awb")
					end

					arg_730_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105179", "story_v_side_new_1104105.awb")
				end

				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_7 = math.max(var_733_0, arg_730_1.talkMaxDuration)

			if 0 <= arg_730_1.time_ and arg_730_1.time_ < 0 + var_733_7 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - 0) / var_733_7

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= 0 + var_733_7 and arg_730_1.time_ < 0 + var_733_7 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play1104105180 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1104105180
		arg_734_1.duration_ = 7.4

		local var_734_0 = {
			zh = 3.766,
			ja = 7.4
		}
		local var_734_1 = manager.audio:GetLocalizationFlag()

		if var_734_0[var_734_1] ~= nil then
			arg_734_1.duration_ = var_734_0[var_734_1]
		end

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1104105181(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			local var_737_0 = 0.675

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				arg_734_1.leftNameTxt_.text = arg_734_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, false)
				arg_734_1.callingController_:SetSelectedState("normal")

				local var_737_1 = arg_734_1:GetWordFromCfg(1104105180)
				local var_737_2 = arg_734_1:FormatText(var_737_1.content)

				arg_734_1.text_.text = var_737_2

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_4 = 27 <= 0 and var_737_0 or var_737_0 * (utf8.len(var_737_2) / 27)

				if (27 <= 0 and var_737_0 or var_737_0 * (utf8.len(var_737_2) / 27)) > 0 and var_737_0 < var_737_4 then
					arg_734_1.talkMaxDuration = var_737_4

					if var_737_4 + 0 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_4 + 0
					end
				end

				arg_734_1.text_.text = var_737_2
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105180", "story_v_side_new_1104105.awb") ~= 0 then
					local var_737_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105180", "story_v_side_new_1104105.awb") / 1000

					if var_737_5 + 0 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_5 + 0
					end

					if var_737_1.prefab_name ~= "" and arg_734_1.actors_[var_737_1.prefab_name] ~= nil then
						local var_737_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_734_1.actors_[var_737_1.prefab_name].transform, "story_v_side_new_1104105", "1104105180", "story_v_side_new_1104105.awb")

						arg_734_1:RecordAudio("1104105180", var_737_6)
						arg_734_1:RecordAudio("1104105180", var_737_6)
					else
						arg_734_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105180", "story_v_side_new_1104105.awb")
					end

					arg_734_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105180", "story_v_side_new_1104105.awb")
				end

				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_7 = math.max(var_737_0, arg_734_1.talkMaxDuration)

			if 0 <= arg_734_1.time_ and arg_734_1.time_ < 0 + var_737_7 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - 0) / var_737_7

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= 0 + var_737_7 and arg_734_1.time_ < 0 + var_737_7 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1104105181 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1104105181
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1104105182(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			if 0 < arg_738_1.time_ and arg_738_1.time_ <= 0 + arg_741_0 and not isNil(arg_738_1.actors_["1041ui_story"]) and arg_738_1.var_.characterEffect1041ui_story == nil then
				arg_738_1.var_.characterEffect1041ui_story = arg_738_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_741_0 = 0.200000002980232

			if 0 <= arg_738_1.time_ and arg_738_1.time_ < 0 + var_741_0 and not isNil(arg_738_1.actors_["1041ui_story"]) then
				if arg_738_1.var_.characterEffect1041ui_story and not isNil(arg_738_1.actors_["1041ui_story"]) then
					arg_738_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_738_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_738_1.time_ - 0) / var_741_0)
				end
			end

			if arg_738_1.time_ >= 0 + var_741_0 and arg_738_1.time_ < 0 + var_741_0 + arg_741_0 and not isNil(arg_738_1.actors_["1041ui_story"]) and arg_738_1.var_.characterEffect1041ui_story then
				arg_738_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_738_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_741_1 = 0
			local var_741_2 = 0.65

			if 0 < arg_738_1.time_ and arg_738_1.time_ <= var_741_1 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, false)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_738_1.iconTrs_.gameObject, false)
				arg_738_1.callingController_:SetSelectedState("normal")

				local var_741_3 = arg_738_1:FormatText(arg_738_1:GetWordFromCfg(1104105181).content)

				arg_738_1.text_.text = var_741_3

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_5 = 26 <= 0 and var_741_2 or var_741_2 * (utf8.len(var_741_3) / 26)

				if (26 <= 0 and var_741_2 or var_741_2 * (utf8.len(var_741_3) / 26)) > 0 and var_741_2 < var_741_5 then
					arg_738_1.talkMaxDuration = var_741_5

					if var_741_5 + var_741_1 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_5 + var_741_1
					end
				end

				arg_738_1.text_.text = var_741_3
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_6 = math.max(var_741_2, arg_738_1.talkMaxDuration)

			if var_741_1 <= arg_738_1.time_ and arg_738_1.time_ < var_741_1 + var_741_6 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_1) / var_741_6

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_1 + var_741_6 and arg_738_1.time_ < var_741_1 + var_741_6 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1104105182 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1104105182
		arg_742_1.duration_ = 5

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1104105183(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			local var_745_0 = 0.125

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				arg_742_1.leftNameTxt_.text = arg_742_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, true)
				arg_742_1.iconController_:SetSelectedState("hero")

				arg_742_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_742_1.callingController_:SetSelectedState("normal")

				arg_742_1.keyicon_.color = Color.New(1, 1, 1)
				arg_742_1.icon_.color = Color.New(1, 1, 1)

				local var_745_1 = arg_742_1:FormatText(arg_742_1:GetWordFromCfg(1104105182).content)

				arg_742_1.text_.text = var_745_1

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_3 = 5 <= 0 and var_745_0 or var_745_0 * (utf8.len(var_745_1) / 5)

				if (5 <= 0 and var_745_0 or var_745_0 * (utf8.len(var_745_1) / 5)) > 0 and var_745_0 < var_745_3 then
					arg_742_1.talkMaxDuration = var_745_3

					if var_745_3 + 0 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_3 + 0
					end
				end

				arg_742_1.text_.text = var_745_1
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)
				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_4 = math.max(var_745_0, arg_742_1.talkMaxDuration)

			if 0 <= arg_742_1.time_ and arg_742_1.time_ < 0 + var_745_4 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - 0) / var_745_4

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= 0 + var_745_4 and arg_742_1.time_ < 0 + var_745_4 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	Play1104105183 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1104105183
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1104105184(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			local var_749_0 = 0.6

			if 0 < arg_746_1.time_ and arg_746_1.time_ <= 0 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, false)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_746_1.iconTrs_.gameObject, false)
				arg_746_1.callingController_:SetSelectedState("normal")

				local var_749_1 = arg_746_1:FormatText(arg_746_1:GetWordFromCfg(1104105183).content)

				arg_746_1.text_.text = var_749_1

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_3 = 24 <= 0 and var_749_0 or var_749_0 * (utf8.len(var_749_1) / 24)

				if (24 <= 0 and var_749_0 or var_749_0 * (utf8.len(var_749_1) / 24)) > 0 and var_749_0 < var_749_3 then
					arg_746_1.talkMaxDuration = var_749_3

					if var_749_3 + 0 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_3 + 0
					end
				end

				arg_746_1.text_.text = var_749_1
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_4 = math.max(var_749_0, arg_746_1.talkMaxDuration)

			if 0 <= arg_746_1.time_ and arg_746_1.time_ < 0 + var_749_4 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - 0) / var_749_4

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= 0 + var_749_4 and arg_746_1.time_ < 0 + var_749_4 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {}

		arg_746_1:InitPlayNodeList()
	end,
	Play1104105184 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1104105184
		arg_750_1.duration_ = 9.67

		local var_750_0 = {
			zh = 9.666,
			ja = 3.7
		}
		local var_750_1 = manager.audio:GetLocalizationFlag()

		if var_750_0[var_750_1] ~= nil then
			arg_750_1.duration_ = var_750_0[var_750_1]
		end

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1104105185(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1.var_.moveOldPos1041ui_story = arg_750_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_753_0 = 0.001

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_0 then
				arg_750_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_750_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_750_1.time_ - 0) / var_753_0)
				arg_750_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_750_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1041ui_story"].transform.position).z)
				arg_750_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_750_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_750_1.actors_["1041ui_story"].transform.localEulerAngles = arg_750_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_750_1.time_ >= 0 + var_753_0 and arg_750_1.time_ < 0 + var_753_0 + arg_753_0 then
				arg_750_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_750_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_750_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_750_1.actors_["1041ui_story"].transform.position).z)
				arg_750_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_750_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_750_1.actors_["1041ui_story"].transform.localEulerAngles = arg_750_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_753_1 = arg_750_1.actors_["1041ui_story"]

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 and not isNil(var_753_1) and arg_750_1.var_.characterEffect1041ui_story == nil then
				arg_750_1.var_.characterEffect1041ui_story = var_753_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_753_2 = 0.200000002980232

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_2 and not isNil(var_753_1) then
				if arg_750_1.var_.characterEffect1041ui_story and not isNil(var_753_1) then
					arg_750_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_750_1.time_ >= 0 + var_753_2 and arg_750_1.time_ < 0 + var_753_2 + arg_753_0 and not isNil(var_753_1) and arg_750_1.var_.characterEffect1041ui_story then
				arg_750_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_753_4 = 0
			local var_753_5 = 1.075

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= var_753_4 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, true)

				arg_750_1.leftNameTxt_.text = arg_750_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_750_1.leftNameTxt_.transform)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1.leftNameTxt_.text)
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_6 = arg_750_1:GetWordFromCfg(1104105184)
				local var_753_7 = arg_750_1:FormatText(var_753_6.content)

				arg_750_1.text_.text = var_753_7

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_9 = 43 <= 0 and var_753_5 or var_753_5 * (utf8.len(var_753_7) / 43)

				if (43 <= 0 and var_753_5 or var_753_5 * (utf8.len(var_753_7) / 43)) > 0 and var_753_5 < var_753_9 then
					arg_750_1.talkMaxDuration = var_753_9

					if var_753_9 + var_753_4 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_9 + var_753_4
					end
				end

				arg_750_1.text_.text = var_753_7
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105184", "story_v_side_new_1104105.awb") ~= 0 then
					local var_753_10 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105184", "story_v_side_new_1104105.awb") / 1000

					if var_753_10 + var_753_4 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_10 + var_753_4
					end

					if var_753_6.prefab_name ~= "" and arg_750_1.actors_[var_753_6.prefab_name] ~= nil then
						local var_753_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_750_1.actors_[var_753_6.prefab_name].transform, "story_v_side_new_1104105", "1104105184", "story_v_side_new_1104105.awb")

						arg_750_1:RecordAudio("1104105184", var_753_11)
						arg_750_1:RecordAudio("1104105184", var_753_11)
					else
						arg_750_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105184", "story_v_side_new_1104105.awb")
					end

					arg_750_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105184", "story_v_side_new_1104105.awb")
				end

				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_12 = math.max(var_753_5, arg_750_1.talkMaxDuration)

			if var_753_4 <= arg_750_1.time_ and arg_750_1.time_ < var_753_4 + var_753_12 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_4) / var_753_12

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_4 + var_753_12 and arg_750_1.time_ < var_753_4 + var_753_12 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_750_1:InitPlayNodeList()
	end,
	Play1104105185 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1104105185
		arg_754_1.duration_ = 2.4

		local var_754_0 = {
			zh = 2.233,
			ja = 2.4
		}
		local var_754_1 = manager.audio:GetLocalizationFlag()

		if var_754_0[var_754_1] ~= nil then
			arg_754_1.duration_ = var_754_0[var_754_1]
		end

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
			arg_754_1.auto_ = false
		end

		function arg_754_1.playNext_(arg_756_0)
			arg_754_1.onStoryFinished_()
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			local var_757_0 = 0.4

			if 0 < arg_754_1.time_ and arg_754_1.time_ <= 0 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				arg_754_1.leftNameTxt_.text = arg_754_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, false)
				arg_754_1.callingController_:SetSelectedState("normal")

				local var_757_1 = arg_754_1:GetWordFromCfg(1104105185)
				local var_757_2 = arg_754_1:FormatText(var_757_1.content)

				arg_754_1.text_.text = var_757_2

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_4 = 16 <= 0 and var_757_0 or var_757_0 * (utf8.len(var_757_2) / 16)

				if (16 <= 0 and var_757_0 or var_757_0 * (utf8.len(var_757_2) / 16)) > 0 and var_757_0 < var_757_4 then
					arg_754_1.talkMaxDuration = var_757_4

					if var_757_4 + 0 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_4 + 0
					end
				end

				arg_754_1.text_.text = var_757_2
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105185", "story_v_side_new_1104105.awb") ~= 0 then
					local var_757_5 = manager.audio:GetVoiceLength("story_v_side_new_1104105", "1104105185", "story_v_side_new_1104105.awb") / 1000

					if var_757_5 + 0 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_5 + 0
					end

					if var_757_1.prefab_name ~= "" and arg_754_1.actors_[var_757_1.prefab_name] ~= nil then
						local var_757_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_754_1.actors_[var_757_1.prefab_name].transform, "story_v_side_new_1104105", "1104105185", "story_v_side_new_1104105.awb")

						arg_754_1:RecordAudio("1104105185", var_757_6)
						arg_754_1:RecordAudio("1104105185", var_757_6)
					else
						arg_754_1:AudioAction("play", "voice", "story_v_side_new_1104105", "1104105185", "story_v_side_new_1104105.awb")
					end

					arg_754_1:RecordHistoryTalkVoice("story_v_side_new_1104105", "1104105185", "story_v_side_new_1104105.awb")
				end

				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_7 = math.max(var_757_0, arg_754_1.talkMaxDuration)

			if 0 <= arg_754_1.time_ and arg_754_1.time_ < 0 + var_757_7 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - 0) / var_757_7

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= 0 + var_757_7 and arg_754_1.time_ < 0 + var_757_7 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST24a"
	},
	voices = {
		"story_v_side_new_1104105.awb"
	}
}
