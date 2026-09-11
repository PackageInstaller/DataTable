return {
	Play221051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 221051001
		arg_1_1.duration_ = 5.3

		local var_1_0 = {
			ja = 5.3,
			ko = 4.866,
			zh = 4.866
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
				arg_1_0:Play221051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST40 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST40")
				var_4_0.name = "ST40"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST40 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST40

				arg_1_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST40" then
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
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
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

			if 1.33333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.33333333333333 + arg_4_0 then
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
			local var_4_24 = 0.2

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

				local var_4_26 = arg_1_1:GetWordFromCfg(221051001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 8 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 8)

				if (8 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 8)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051001", "story_v_out_221051.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_221051", "221051001", "story_v_out_221051.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_221051", "221051001", "story_v_out_221051.awb")

						arg_1_1:RecordAudio("221051001", var_4_31)
						arg_1_1:RecordAudio("221051001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_221051", "221051001", "story_v_out_221051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_221051", "221051001", "story_v_out_221051.awb")
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
	Play221051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 221051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play221051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1072ui_story = arg_9_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).z)
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles = arg_9_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).z)
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles = arg_9_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1072ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1072ui_story == nil then
				arg_9_1.var_.characterEffect1072ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1072ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1072ui_story then
				arg_9_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_12_3 = 0
			local var_12_4 = 0.975

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(221051002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 36 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 36)

				if (36 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 36)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play221051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 221051003
		arg_13_1.duration_ = 6.37

		local var_13_0 = {
			ja = 6.366,
			ko = 3.766,
			zh = 3.766
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
				arg_13_0:Play221051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1076ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1076ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1076ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1076ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1076ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1076ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1076ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1076ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1076ui_story == nil then
				arg_13_1.var_.characterEffect1076ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1076ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1076ui_story then
				arg_13_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(221051003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 18 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 18)

				if (18 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 18)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051003", "story_v_out_221051.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_221051", "221051003", "story_v_out_221051.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_221051", "221051003", "story_v_out_221051.awb")

						arg_13_1:RecordAudio("221051003", var_16_15)
						arg_13_1:RecordAudio("221051003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_221051", "221051003", "story_v_out_221051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_221051", "221051003", "story_v_out_221051.awb")
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
				actorName = "1076ui_story",
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
	Play221051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 221051004
		arg_17_1.duration_ = 3.67

		local var_17_0 = {
			ja = 3.6,
			ko = 3.666,
			zh = 3.666
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
				arg_17_0:Play221051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1072ui_story = arg_17_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = arg_17_1.actors_["1076ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1076ui_story == nil then
				arg_17_1.var_.characterEffect1076ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect1076ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1076ui_story then
				arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
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

				local var_20_8 = arg_17_1:GetWordFromCfg(221051004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 15 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 15)

				if (15 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 15)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051004", "story_v_out_221051.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051004", "story_v_out_221051.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_221051", "221051004", "story_v_out_221051.awb")

						arg_17_1:RecordAudio("221051004", var_20_13)
						arg_17_1:RecordAudio("221051004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_221051", "221051004", "story_v_out_221051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_221051", "221051004", "story_v_out_221051.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
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
	Play221051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 221051005
		arg_21_1.duration_ = 9.33

		local var_21_0 = {
			ja = 9.333,
			ko = 4.533,
			zh = 4.533
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
				arg_21_0:Play221051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1076ui_story = arg_21_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1076ui_story"].transform.position).z)
				arg_21_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1076ui_story"].transform.localEulerAngles = arg_21_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_21_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1076ui_story"].transform.position).z)
				arg_21_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1076ui_story"].transform.localEulerAngles = arg_21_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1076ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1076ui_story == nil then
				arg_21_1.var_.characterEffect1076ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1076ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1076ui_story then
				arg_21_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = arg_21_1.actors_["1072ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect1072ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1072ui_story then
				arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_24_6 = 0
			local var_24_7 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(221051005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 20 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 20)

				if (20 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 20)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051005", "story_v_out_221051.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051005", "story_v_out_221051.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_221051", "221051005", "story_v_out_221051.awb")

						arg_21_1:RecordAudio("221051005", var_24_13)
						arg_21_1:RecordAudio("221051005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_221051", "221051005", "story_v_out_221051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_221051", "221051005", "story_v_out_221051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play221051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 221051006
		arg_25_1.duration_ = 8.8

		local var_25_0 = {
			ja = 8.8,
			ko = 5.833,
			zh = 5.833
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
				arg_25_0:Play221051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1072ui_story = arg_25_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1072ui_story"].transform.position).z)
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1072ui_story"].transform.localEulerAngles = arg_25_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = arg_25_1.actors_["1076ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1076ui_story then
				arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 0.75

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
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

				local var_28_8 = arg_25_1:GetWordFromCfg(221051006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 30 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 30)

				if (30 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 30)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051006", "story_v_out_221051.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051006", "story_v_out_221051.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_221051", "221051006", "story_v_out_221051.awb")

						arg_25_1:RecordAudio("221051006", var_28_13)
						arg_25_1:RecordAudio("221051006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_221051", "221051006", "story_v_out_221051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_221051", "221051006", "story_v_out_221051.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
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
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play221051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 221051007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play221051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1072ui_story"]) and arg_29_1.var_.characterEffect1072ui_story == nil then
				arg_29_1.var_.characterEffect1072ui_story = arg_29_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1072ui_story"]) then
				if arg_29_1.var_.characterEffect1072ui_story and not isNil(arg_29_1.actors_["1072ui_story"]) then
					arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1072ui_story"]) and arg_29_1.var_.characterEffect1072ui_story then
				arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(221051007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 29 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 29)

				if (29 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 29)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play221051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 221051008
		arg_33_1.duration_ = 4.8

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play221051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1072ui_story = arg_33_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1072ui_story"].transform.position).z)
				arg_33_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1072ui_story"].transform.localEulerAngles = arg_33_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_33_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1072ui_story"].transform.position).z)
				arg_33_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1072ui_story"].transform.localEulerAngles = arg_33_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1072ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1072ui_story == nil then
				arg_33_1.var_.characterEffect1072ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1072ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1072ui_story then
				arg_33_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(221051008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 20 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 20)

				if (20 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 20)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051008", "story_v_out_221051.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051008", "story_v_out_221051.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_221051", "221051008", "story_v_out_221051.awb")

						arg_33_1:RecordAudio("221051008", var_36_11)
						arg_33_1:RecordAudio("221051008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_221051", "221051008", "story_v_out_221051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_221051", "221051008", "story_v_out_221051.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play221051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 221051009
		arg_37_1.duration_ = 4.03

		local var_37_0 = {
			ja = 4.033,
			ko = 3.6,
			zh = 3.6
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
				arg_37_0:Play221051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1072ui_story = arg_37_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1072ui_story"].transform.position).z)
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1072ui_story"].transform.localEulerAngles = arg_37_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action473")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
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

				local var_40_6 = arg_37_1:GetWordFromCfg(221051009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 10 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 10)

				if (10 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 10)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051009", "story_v_out_221051.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051009", "story_v_out_221051.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_221051", "221051009", "story_v_out_221051.awb")

						arg_37_1:RecordAudio("221051009", var_40_11)
						arg_37_1:RecordAudio("221051009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_221051", "221051009", "story_v_out_221051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_221051", "221051009", "story_v_out_221051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
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
	Play221051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 221051010
		arg_41_1.duration_ = 2

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play221051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1076ui_story = arg_41_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1076ui_story"].transform.position).z)
				arg_41_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1076ui_story"].transform.localEulerAngles = arg_41_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_41_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1076ui_story"].transform.position).z)
				arg_41_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1076ui_story"].transform.localEulerAngles = arg_41_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1076ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1076ui_story == nil then
				arg_41_1.var_.characterEffect1076ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1076ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1076ui_story then
				arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_4 = arg_41_1.actors_["1072ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1072ui_story == nil then
				arg_41_1.var_.characterEffect1072ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1072ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1072ui_story then
				arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 0.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(221051010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 3 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 3)

				if (3 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 3)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051010", "story_v_out_221051.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051010", "story_v_out_221051.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_221051", "221051010", "story_v_out_221051.awb")

						arg_41_1:RecordAudio("221051010", var_44_13)
						arg_41_1:RecordAudio("221051010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_221051", "221051010", "story_v_out_221051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_221051", "221051010", "story_v_out_221051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play221051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 221051011
		arg_45_1.duration_ = 10.3

		local var_45_0 = {
			ja = 9.1,
			ko = 10.3,
			zh = 10.3
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
				arg_45_0:Play221051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1072ui_story = arg_45_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1072ui_story"].transform.position).z)
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1072ui_story"].transform.localEulerAngles = arg_45_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_48_4 = arg_45_1.actors_["1076ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1076ui_story == nil then
				arg_45_1.var_.characterEffect1076ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect1076ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1076ui_story then
				arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 1.025

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
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

				local var_48_8 = arg_45_1:GetWordFromCfg(221051011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 41 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 41)

				if (41 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 41)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051011", "story_v_out_221051.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051011", "story_v_out_221051.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_221051", "221051011", "story_v_out_221051.awb")

						arg_45_1:RecordAudio("221051011", var_48_13)
						arg_45_1:RecordAudio("221051011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_221051", "221051011", "story_v_out_221051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_221051", "221051011", "story_v_out_221051.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
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
	Play221051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 221051012
		arg_49_1.duration_ = 15

		local var_49_0 = {
			ja = 15,
			ko = 11.966,
			zh = 11.966
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
				arg_49_0:Play221051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1072ui_story = arg_49_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).z)
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles = arg_49_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_49_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).z)
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles = arg_49_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1072ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1072ui_story then
				arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action435")
			end

			local var_52_4 = 0
			local var_52_5 = 1.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(221051012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 42 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 42)

				if (42 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 42)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051012", "story_v_out_221051.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051012", "story_v_out_221051.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_221051", "221051012", "story_v_out_221051.awb")

						arg_49_1:RecordAudio("221051012", var_52_11)
						arg_49_1:RecordAudio("221051012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_221051", "221051012", "story_v_out_221051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_221051", "221051012", "story_v_out_221051.awb")
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
				actorName = "1072ui_story",
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
	Play221051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 221051013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play221051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1076ui_story = arg_53_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).z)
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles = arg_53_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_53_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1076ui_story"].transform.position).z)
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1076ui_story"].transform.localEulerAngles = arg_53_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1076ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1076ui_story == nil then
				arg_53_1.var_.characterEffect1076ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1076ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1076ui_story then
				arg_53_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_56_4 = arg_53_1.actors_["1072ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1072ui_story == nil then
				arg_53_1.var_.characterEffect1072ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect1072ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1072ui_story then
				arg_53_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_56_6 = 0
			local var_56_7 = 0.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
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

				local var_56_8 = arg_53_1:GetWordFromCfg(221051013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 2 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 2)

				if (2 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 2)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051013", "story_v_out_221051.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051013", "story_v_out_221051.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_221051", "221051013", "story_v_out_221051.awb")

						arg_53_1:RecordAudio("221051013", var_56_13)
						arg_53_1:RecordAudio("221051013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_221051", "221051013", "story_v_out_221051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_221051", "221051013", "story_v_out_221051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
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
	Play221051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 221051014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play221051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1076ui_story"]) and arg_57_1.var_.characterEffect1076ui_story == nil then
				arg_57_1.var_.characterEffect1076ui_story = arg_57_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1076ui_story"]) then
				if arg_57_1.var_.characterEffect1076ui_story and not isNil(arg_57_1.actors_["1076ui_story"]) then
					arg_57_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1076ui_story"]) and arg_57_1.var_.characterEffect1076ui_story then
				arg_57_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.575

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

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(221051014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 23 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 23)

				if (23 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 23)) > 0 and var_60_2 < var_60_5 then
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
	Play221051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 221051015
		arg_61_1.duration_ = 13.2

		local var_61_0 = {
			ja = 13.2,
			ko = 8.4,
			zh = 8.4
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
				arg_61_0:Play221051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1072ui_story = arg_61_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1072ui_story"].transform.position).z)
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1072ui_story"].transform.localEulerAngles = arg_61_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_64_4 = 0
			local var_64_5 = 1

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

				local var_64_6 = arg_61_1:GetWordFromCfg(221051015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 40 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 40)

				if (40 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 40)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051015", "story_v_out_221051.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051015", "story_v_out_221051.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_221051", "221051015", "story_v_out_221051.awb")

						arg_61_1:RecordAudio("221051015", var_64_11)
						arg_61_1:RecordAudio("221051015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_221051", "221051015", "story_v_out_221051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_221051", "221051015", "story_v_out_221051.awb")
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
	Play221051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 221051016
		arg_65_1.duration_ = 17.43

		local var_65_0 = {
			ja = 17.433,
			ko = 16.133,
			zh = 16.133
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
				arg_65_0:Play221051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(221051016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 64 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 64)

				if (64 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 64)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051016", "story_v_out_221051.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051016", "story_v_out_221051.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_221051", "221051016", "story_v_out_221051.awb")

						arg_65_1:RecordAudio("221051016", var_68_6)
						arg_65_1:RecordAudio("221051016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_221051", "221051016", "story_v_out_221051.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_221051", "221051016", "story_v_out_221051.awb")
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
	Play221051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 221051017
		arg_69_1.duration_ = 16.2

		local var_69_0 = {
			ja = 16.2,
			ko = 11.333,
			zh = 11.333
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
				arg_69_0:Play221051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1072ui_story = arg_69_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1072ui_story"].transform.position).z)
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1072ui_story"].transform.localEulerAngles = arg_69_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_72_4 = 0
			local var_72_5 = 1.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
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

				local var_72_6 = arg_69_1:GetWordFromCfg(221051017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 57 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 57)

				if (57 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 57)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051017", "story_v_out_221051.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051017", "story_v_out_221051.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_221051", "221051017", "story_v_out_221051.awb")

						arg_69_1:RecordAudio("221051017", var_72_11)
						arg_69_1:RecordAudio("221051017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_221051", "221051017", "story_v_out_221051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_221051", "221051017", "story_v_out_221051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
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
	Play221051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 221051018
		arg_73_1.duration_ = 5.37

		local var_73_0 = {
			ja = 5.366,
			ko = 3.233,
			zh = 3.233
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
				arg_73_0:Play221051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1072ui_story = arg_73_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1072ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1072ui_story == nil then
				arg_73_1.var_.characterEffect1072ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1072ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1072ui_story then
				arg_73_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_4 = 0
			local var_76_5 = 0.35

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
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

				local var_76_6 = arg_73_1:GetWordFromCfg(221051018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 14 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 14)

				if (14 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 14)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051018", "story_v_out_221051.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051018", "story_v_out_221051.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_221051", "221051018", "story_v_out_221051.awb")

						arg_73_1:RecordAudio("221051018", var_76_11)
						arg_73_1:RecordAudio("221051018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_221051", "221051018", "story_v_out_221051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_221051", "221051018", "story_v_out_221051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
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
	Play221051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 221051019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play221051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1072ui_story"]) and arg_77_1.var_.characterEffect1072ui_story == nil then
				arg_77_1.var_.characterEffect1072ui_story = arg_77_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1072ui_story"]) then
				if arg_77_1.var_.characterEffect1072ui_story and not isNil(arg_77_1.actors_["1072ui_story"]) then
					arg_77_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1072ui_story"]) and arg_77_1.var_.characterEffect1072ui_story then
				arg_77_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.825

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(221051019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 33 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 33)

				if (33 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 33)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play221051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 221051020
		arg_81_1.duration_ = 6.1

		local var_81_0 = {
			ja = 6.1,
			ko = 3.7,
			zh = 3.7
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
				arg_81_0:Play221051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1076ui_story = arg_81_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).z)
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles = arg_81_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_81_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).z)
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles = arg_81_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1076ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1076ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1076ui_story then
				arg_81_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076actionlink/1076action467")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.325

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(221051020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 13 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 13)

				if (13 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 13)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051020", "story_v_out_221051.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051020", "story_v_out_221051.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_221051", "221051020", "story_v_out_221051.awb")

						arg_81_1:RecordAudio("221051020", var_84_11)
						arg_81_1:RecordAudio("221051020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_221051", "221051020", "story_v_out_221051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_221051", "221051020", "story_v_out_221051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play221051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 221051021
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play221051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1072ui_story = arg_85_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).z)
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles = arg_85_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_85_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).z)
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles = arg_85_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1072ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1072ui_story == nil then
				arg_85_1.var_.characterEffect1072ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1072ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1072ui_story then
				arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = arg_85_1.actors_["1076ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1076ui_story == nil then
				arg_85_1.var_.characterEffect1076ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect1076ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1076ui_story then
				arg_85_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_88_6 = 0
			local var_88_7 = 0.05

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
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

				local var_88_8 = arg_85_1:GetWordFromCfg(221051021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 2 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 2)

				if (2 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 2)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051021", "story_v_out_221051.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051021", "story_v_out_221051.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_221051", "221051021", "story_v_out_221051.awb")

						arg_85_1:RecordAudio("221051021", var_88_13)
						arg_85_1:RecordAudio("221051021", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_221051", "221051021", "story_v_out_221051.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_221051", "221051021", "story_v_out_221051.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
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
	Play221051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 221051022
		arg_89_1.duration_ = 6.47

		local var_89_0 = {
			ja = 6.466,
			ko = 5.233,
			zh = 5.233
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
				arg_89_0:Play221051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1076ui_story = arg_89_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1076ui_story"].transform.position).z)
				arg_89_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1076ui_story"].transform.localEulerAngles = arg_89_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_89_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1076ui_story"].transform.position).z)
				arg_89_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1076ui_story"].transform.localEulerAngles = arg_89_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1076ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1076ui_story == nil then
				arg_89_1.var_.characterEffect1076ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1076ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1076ui_story then
				arg_89_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_92_4 = arg_89_1.actors_["1072ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1072ui_story == nil then
				arg_89_1.var_.characterEffect1072ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect1072ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1072ui_story then
				arg_89_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_92_6 = 0
			local var_92_7 = 0.525

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(221051022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 21 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 21)

				if (21 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 21)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051022", "story_v_out_221051.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051022", "story_v_out_221051.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_221051", "221051022", "story_v_out_221051.awb")

						arg_89_1:RecordAudio("221051022", var_92_13)
						arg_89_1:RecordAudio("221051022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_221051", "221051022", "story_v_out_221051.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_221051", "221051022", "story_v_out_221051.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play221051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 221051023
		arg_93_1.duration_ = 5.1

		local var_93_0 = {
			ja = 5.1,
			ko = 3.266,
			zh = 3.266
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
				arg_93_0:Play221051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1076ui_story = arg_93_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).z)
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles = arg_93_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_93_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1076ui_story"].transform.position).z)
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1076ui_story"].transform.localEulerAngles = arg_93_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_1 = 0
			local var_96_2 = 0.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
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

				local var_96_3 = arg_93_1:GetWordFromCfg(221051023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 13 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 13)

				if (13 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 13)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051023", "story_v_out_221051.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051023", "story_v_out_221051.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_221051", "221051023", "story_v_out_221051.awb")

						arg_93_1:RecordAudio("221051023", var_96_8)
						arg_93_1:RecordAudio("221051023", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_221051", "221051023", "story_v_out_221051.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_221051", "221051023", "story_v_out_221051.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
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
	Play221051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 221051024
		arg_97_1.duration_ = 4.3

		local var_97_0 = {
			ja = 2.866,
			ko = 4.3,
			zh = 4.3
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
				arg_97_0:Play221051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1072ui_story = arg_97_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).z)
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles = arg_97_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
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
				arg_97_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
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
			local var_100_7 = 0.225

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

				local var_100_8 = arg_97_1:GetWordFromCfg(221051024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 9 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 9)

				if (9 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 9)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051024", "story_v_out_221051.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051024", "story_v_out_221051.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_221051", "221051024", "story_v_out_221051.awb")

						arg_97_1:RecordAudio("221051024", var_100_13)
						arg_97_1:RecordAudio("221051024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_221051", "221051024", "story_v_out_221051.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_221051", "221051024", "story_v_out_221051.awb")
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
	Play221051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 221051025
		arg_101_1.duration_ = 5.17

		local var_101_0 = {
			ja = 5.166,
			ko = 3.1,
			zh = 3.1
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
				arg_101_0:Play221051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1076ui_story = arg_101_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1076ui_story"].transform.position).z)
				arg_101_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1076ui_story"].transform.localEulerAngles = arg_101_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_101_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1076ui_story"].transform.position).z)
				arg_101_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1076ui_story"].transform.localEulerAngles = arg_101_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1076ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1076ui_story == nil then
				arg_101_1.var_.characterEffect1076ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1076ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1076ui_story then
				arg_101_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action7_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = arg_101_1.actors_["1072ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1072ui_story == nil then
				arg_101_1.var_.characterEffect1072ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect1072ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1072ui_story then
				arg_101_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_104_6 = 0
			local var_104_7 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(221051025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 11 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 11)

				if (11 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 11)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051025", "story_v_out_221051.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051025", "story_v_out_221051.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_221051", "221051025", "story_v_out_221051.awb")

						arg_101_1:RecordAudio("221051025", var_104_13)
						arg_101_1:RecordAudio("221051025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_221051", "221051025", "story_v_out_221051.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_221051", "221051025", "story_v_out_221051.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play221051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 221051026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play221051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1076ui_story"]) and arg_105_1.var_.characterEffect1076ui_story == nil then
				arg_105_1.var_.characterEffect1076ui_story = arg_105_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1076ui_story"]) then
				if arg_105_1.var_.characterEffect1076ui_story and not isNil(arg_105_1.actors_["1076ui_story"]) then
					arg_105_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1076ui_story"]) and arg_105_1.var_.characterEffect1076ui_story then
				arg_105_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.5

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

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(221051026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 20 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 20)

				if (20 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 20)) > 0 and var_108_2 < var_108_5 then
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
	Play221051027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 221051027
		arg_109_1.duration_ = 6.1

		local var_109_0 = {
			ja = 4.9,
			ko = 6.1,
			zh = 6.1
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play221051028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1072ui_story = arg_109_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).z)
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles = arg_109_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_109_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1072ui_story"].transform.position).z)
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1072ui_story"].transform.localEulerAngles = arg_109_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1072ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1072ui_story == nil then
				arg_109_1.var_.characterEffect1072ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1072ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1072ui_story then
				arg_109_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.55

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(221051027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 22 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 22)

				if (22 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 22)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051027", "story_v_out_221051.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051027", "story_v_out_221051.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_221051", "221051027", "story_v_out_221051.awb")

						arg_109_1:RecordAudio("221051027", var_112_11)
						arg_109_1:RecordAudio("221051027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_221051", "221051027", "story_v_out_221051.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_221051", "221051027", "story_v_out_221051.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play221051028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 221051028
		arg_113_1.duration_ = 3.9

		local var_113_0 = {
			ja = 3.9,
			ko = 2.5,
			zh = 2.5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play221051029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1076ui_story = arg_113_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1076ui_story"].transform.position).z)
				arg_113_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1076ui_story"].transform.localEulerAngles = arg_113_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_113_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1076ui_story"].transform.position).z)
				arg_113_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1076ui_story"].transform.localEulerAngles = arg_113_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1076ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1076ui_story == nil then
				arg_113_1.var_.characterEffect1076ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1076ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1076ui_story then
				arg_113_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = arg_113_1.actors_["1072ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1072ui_story == nil then
				arg_113_1.var_.characterEffect1072ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect1072ui_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1072ui_story then
				arg_113_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_116_6 = 0
			local var_116_7 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(221051028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 12 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 12)

				if (12 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 12)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051028", "story_v_out_221051.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051028", "story_v_out_221051.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_221051", "221051028", "story_v_out_221051.awb")

						arg_113_1:RecordAudio("221051028", var_116_13)
						arg_113_1:RecordAudio("221051028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_221051", "221051028", "story_v_out_221051.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_221051", "221051028", "story_v_out_221051.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play221051029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 221051029
		arg_117_1.duration_ = 12.7

		local var_117_0 = {
			ja = 12.7,
			ko = 8.766,
			zh = 8.766
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play221051030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1072ui_story = arg_117_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).z)
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles = arg_117_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_117_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1072ui_story"].transform.position).z)
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1072ui_story"].transform.localEulerAngles = arg_117_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1072ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1072ui_story == nil then
				arg_117_1.var_.characterEffect1072ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1072ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1072ui_story then
				arg_117_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_120_4 = arg_117_1.actors_["1076ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1076ui_story == nil then
				arg_117_1.var_.characterEffect1076ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect1076ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1076ui_story then
				arg_117_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_120_6 = 0
			local var_120_7 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(221051029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 45 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 45)

				if (45 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 45)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051029", "story_v_out_221051.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051029", "story_v_out_221051.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_221051", "221051029", "story_v_out_221051.awb")

						arg_117_1:RecordAudio("221051029", var_120_13)
						arg_117_1:RecordAudio("221051029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_221051", "221051029", "story_v_out_221051.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_221051", "221051029", "story_v_out_221051.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play221051030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 221051030
		arg_121_1.duration_ = 7.13

		local var_121_0 = {
			ja = 7.133,
			ko = 5.999999999999,
			zh = 5.999999999999
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play221051031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if arg_121_1.bgs_.ST45 == nil then
				local var_124_0 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST45")
				var_124_0.name = "ST45"
				var_124_0.transform.parent = arg_121_1.stage_.transform
				var_124_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_.ST45 = var_124_0
			end

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= 2 + arg_124_0 then
				local var_124_1 = arg_121_1.bgs_.ST45

				arg_121_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_2 = var_124_1:GetComponent("SpriteRenderer")

				if var_124_2 and var_124_2.sprite then
					local var_124_3 = 2 * (var_124_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_1.transform.localScale = Vector3.New(var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST45" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_4 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_5 = 2

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_5 then
				local var_124_6 = Color.New(0, 0, 0)

				var_124_6.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - var_124_4) / var_124_5)
				arg_121_1.mask_.color = var_124_6
			end

			if arg_121_1.time_ >= var_124_4 + var_124_5 and arg_121_1.time_ < var_124_4 + var_124_5 + arg_124_0 then
				local var_124_7 = Color.New(0, 0, 0)

				var_124_7.a = 1
				arg_121_1.mask_.color = var_124_7
			end

			local var_124_8 = 2

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_9 = 2

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 then
				local var_124_10 = Color.New(0, 0, 0)

				var_124_10.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_8) / var_124_9)
				arg_121_1.mask_.color = var_124_10
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 then
				local var_124_11 = Color.New(0, 0, 0)

				arg_121_1.mask_.enabled = false
				var_124_11.a = 0
				arg_121_1.mask_.color = var_124_11
			end

			local var_124_12 = arg_121_1.actors_["1076ui_story"].transform

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= 4 + arg_124_0 then
				arg_121_1.var_.moveOldPos1076ui_story = var_124_12.localPosition
			end

			local var_124_13 = 0.001

			if 4 <= arg_121_1.time_ and arg_121_1.time_ < 4 + var_124_13 then
				var_124_12.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_121_1.time_ - 4) / var_124_13)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			if arg_121_1.time_ >= 4 + var_124_13 and arg_121_1.time_ < 4 + var_124_13 + arg_124_0 then
				var_124_12.localPosition = Vector3.New(0, -1.06, -6.2)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			local var_124_14 = arg_121_1.actors_["1076ui_story"]

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= 4 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect1076ui_story == nil then
				arg_121_1.var_.characterEffect1076ui_story = var_124_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_15 = 0.200000002980232

			if 4 <= arg_121_1.time_ and arg_121_1.time_ < 4 + var_124_15 and not isNil(var_124_14) then
				if arg_121_1.var_.characterEffect1076ui_story and not isNil(var_124_14) then
					arg_121_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 4 + var_124_15 and arg_121_1.time_ < 4 + var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect1076ui_story then
				arg_121_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= 4 + arg_124_0 then
				arg_121_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= 4 + arg_124_0 then
				arg_121_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_17 = arg_121_1.actors_["1072ui_story"]

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= 4 + arg_124_0 and not isNil(var_124_17) and arg_121_1.var_.characterEffect1072ui_story == nil then
				arg_121_1.var_.characterEffect1072ui_story = var_124_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_18 = 0.200000002980232

			if 4 <= arg_121_1.time_ and arg_121_1.time_ < 4 + var_124_18 and not isNil(var_124_17) then
				if arg_121_1.var_.characterEffect1072ui_story and not isNil(var_124_17) then
					arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 4) / var_124_18)
				end
			end

			if arg_121_1.time_ >= 4 + var_124_18 and arg_121_1.time_ < 4 + var_124_18 + arg_124_0 and not isNil(var_124_17) and arg_121_1.var_.characterEffect1072ui_story then
				arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_124_19 = arg_121_1.actors_["1072ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1072ui_story = var_124_19.localPosition
			end

			local var_124_20 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_20 then
				var_124_19.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_20)
				var_124_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_19.position).x, (manager.ui.mainCamera.transform.position - var_124_19.position).y, (manager.ui.mainCamera.transform.position - var_124_19.position).z)
				var_124_19.localEulerAngles.z = 0
				var_124_19.localEulerAngles.x = 0
				var_124_19.localEulerAngles = var_124_19.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_20 and arg_121_1.time_ < 0 + var_124_20 + arg_124_0 then
				var_124_19.localPosition = Vector3.New(0, 100, 0)
				var_124_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_19.position).x, (manager.ui.mainCamera.transform.position - var_124_19.position).y, (manager.ui.mainCamera.transform.position - var_124_19.position).z)
				var_124_19.localEulerAngles.z = 0
				var_124_19.localEulerAngles.x = 0
				var_124_19.localEulerAngles = var_124_19.localEulerAngles
			end

			local var_124_21 = arg_121_1.actors_["1076ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1076ui_story = var_124_21.localPosition
			end

			local var_124_22 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_22 then
				var_124_21.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_22)
				var_124_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_21.position).x, (manager.ui.mainCamera.transform.position - var_124_21.position).y, (manager.ui.mainCamera.transform.position - var_124_21.position).z)
				var_124_21.localEulerAngles.z = 0
				var_124_21.localEulerAngles.x = 0
				var_124_21.localEulerAngles = var_124_21.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_22 and arg_121_1.time_ < 0 + var_124_22 + arg_124_0 then
				var_124_21.localPosition = Vector3.New(0, 100, 0)
				var_124_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_21.position).x, (manager.ui.mainCamera.transform.position - var_124_21.position).y, (manager.ui.mainCamera.transform.position - var_124_21.position).z)
				var_124_21.localEulerAngles.z = 0
				var_124_21.localEulerAngles.x = 0
				var_124_21.localEulerAngles = var_124_21.localEulerAngles
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_23 = 4
			local var_124_24 = 0.225

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_25 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_25:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_26 = arg_121_1:GetWordFromCfg(221051030)
				local var_124_27 = arg_121_1:FormatText(var_124_26.content)

				arg_121_1.text_.text = var_124_27

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_29 = 9 <= 0 and var_124_24 or var_124_24 * (utf8.len(var_124_27) / 9)

				if (9 <= 0 and var_124_24 or var_124_24 * (utf8.len(var_124_27) / 9)) > 0 and var_124_24 < var_124_29 then
					arg_121_1.talkMaxDuration = var_124_29
					var_124_23 = var_124_23 + 0.3

					if var_124_29 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_23
					end
				end

				arg_121_1.text_.text = var_124_27
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051030", "story_v_out_221051.awb") ~= 0 then
					local var_124_30 = manager.audio:GetVoiceLength("story_v_out_221051", "221051030", "story_v_out_221051.awb") / 1000

					if var_124_30 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_30 + var_124_23
					end

					if var_124_26.prefab_name ~= "" and arg_121_1.actors_[var_124_26.prefab_name] ~= nil then
						local var_124_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_26.prefab_name].transform, "story_v_out_221051", "221051030", "story_v_out_221051.awb")

						arg_121_1:RecordAudio("221051030", var_124_31)
						arg_121_1:RecordAudio("221051030", var_124_31)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_221051", "221051030", "story_v_out_221051.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_221051", "221051030", "story_v_out_221051.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_32 = var_124_23 + 0.3
			local var_124_33 = math.max(var_124_24, arg_121_1.talkMaxDuration)

			if var_124_23 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_32 + var_124_33 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_32) / var_124_33

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_32 + var_124_33 and arg_121_1.time_ < var_124_32 + var_124_33 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
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

		arg_121_1:InitPlayNodeList()
	end,
	Play221051031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 221051031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play221051032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1076ui_story = arg_127_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).z)
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles = arg_127_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).z)
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles = arg_127_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1076ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1076ui_story == nil then
				arg_127_1.var_.characterEffect1076ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1076ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_2)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1076ui_story then
				arg_127_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_130_3 = 0
			local var_130_4 = 0.425

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_5 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(221051031).content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 17 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_5) / 17)

				if (17 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_5) / 17)) > 0 and var_130_4 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_3
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_4, arg_127_1.talkMaxDuration)

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_3) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_3 + var_130_8 and arg_127_1.time_ < var_130_3 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play221051032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 221051032
		arg_131_1.duration_ = 12.4

		local var_131_0 = {
			ja = 12.4,
			ko = 10.8,
			zh = 10.8
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
				arg_131_0:Play221051033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.bgs_.ST29 == nil then
				local var_134_0 = Object.Instantiate(arg_131_1.paintGo_)

				var_134_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29")
				var_134_0.name = "ST29"
				var_134_0.transform.parent = arg_131_1.stage_.transform
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.bgs_.ST29 = var_134_0
			end

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 then
				local var_134_1 = arg_131_1.bgs_.ST29

				arg_131_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_134_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_2 = var_134_1:GetComponent("SpriteRenderer")

				if var_134_2 and var_134_2.sprite then
					local var_134_3 = 2 * (var_134_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_134_1.transform.localScale = Vector3.New(var_134_3 / var_134_2.sprite.bounds.size.y < var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x and var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x or var_134_3 / var_134_2.sprite.bounds.size.y, var_134_3 / var_134_2.sprite.bounds.size.y < var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x and var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x or var_134_3 / var_134_2.sprite.bounds.size.y, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "ST29" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_134_4 = 0

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_5 = 2

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_5 then
				local var_134_6 = Color.New(0, 0, 0)

				var_134_6.a = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_4) / var_134_5)
				arg_131_1.mask_.color = var_134_6
			end

			if arg_131_1.time_ >= var_134_4 + var_134_5 and arg_131_1.time_ < var_134_4 + var_134_5 + arg_134_0 then
				local var_134_7 = Color.New(0, 0, 0)

				var_134_7.a = 1
				arg_131_1.mask_.color = var_134_7
			end

			local var_134_8 = 2

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_9 = 2

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 then
				local var_134_10 = Color.New(0, 0, 0)

				var_134_10.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_8) / var_134_9)
				arg_131_1.mask_.color = var_134_10
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 then
				local var_134_11 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_11.a = 0
				arg_131_1.mask_.color = var_134_11
			end

			local var_134_12 = "1075ui_story"

			if arg_131_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_134_13 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_131_1.stage_.transform)

				var_134_13.name = var_134_12
				var_134_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_[var_134_12] = var_134_13

				local var_134_14 = var_134_13:GetComponentInChildren(typeof(CharacterEffect))

				var_134_14.enabled = true

				local var_134_15 = GameObjectTools.GetOrAddComponent(var_134_13, typeof(DynamicBoneHelper))

				if var_134_15 then
					var_134_15:EnableDynamicBone(false)
				end

				arg_131_1:ShowWeapon(var_134_14.transform, false)

				arg_131_1.var_[var_134_12 .. "Animator"] = var_134_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_131_1.var_[var_134_12 .. "Animator"].applyRootMotion = true
				arg_131_1.var_[var_134_12 .. "LipSync"] = var_134_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_134_16 = arg_131_1.actors_["1075ui_story"].transform

			if 4 < arg_131_1.time_ and arg_131_1.time_ <= 4 + arg_134_0 then
				arg_131_1.var_.moveOldPos1075ui_story = var_134_16.localPosition
			end

			local var_134_17 = 0.001

			if 4 <= arg_131_1.time_ and arg_131_1.time_ < 4 + var_134_17 then
				var_134_16.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_131_1.time_ - 4) / var_134_17)
				var_134_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_16.position).x, (manager.ui.mainCamera.transform.position - var_134_16.position).y, (manager.ui.mainCamera.transform.position - var_134_16.position).z)
				var_134_16.localEulerAngles.z = 0
				var_134_16.localEulerAngles.x = 0
				var_134_16.localEulerAngles = var_134_16.localEulerAngles
			end

			if arg_131_1.time_ >= 4 + var_134_17 and arg_131_1.time_ < 4 + var_134_17 + arg_134_0 then
				var_134_16.localPosition = Vector3.New(0, -1.055, -6.16)
				var_134_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_16.position).x, (manager.ui.mainCamera.transform.position - var_134_16.position).y, (manager.ui.mainCamera.transform.position - var_134_16.position).z)
				var_134_16.localEulerAngles.z = 0
				var_134_16.localEulerAngles.x = 0
				var_134_16.localEulerAngles = var_134_16.localEulerAngles
			end

			local var_134_18 = arg_131_1.actors_["1075ui_story"]

			if 4 < arg_131_1.time_ and arg_131_1.time_ <= 4 + arg_134_0 and not isNil(var_134_18) and arg_131_1.var_.characterEffect1075ui_story == nil then
				arg_131_1.var_.characterEffect1075ui_story = var_134_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_19 = 0.200000002980232

			if 4 <= arg_131_1.time_ and arg_131_1.time_ < 4 + var_134_19 and not isNil(var_134_18) then
				if arg_131_1.var_.characterEffect1075ui_story and not isNil(var_134_18) then
					arg_131_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 4 + var_134_19 and arg_131_1.time_ < 4 + var_134_19 + arg_134_0 and not isNil(var_134_18) and arg_131_1.var_.characterEffect1075ui_story then
				arg_131_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 4 < arg_131_1.time_ and arg_131_1.time_ <= 4 + arg_134_0 then
				arg_131_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 4 < arg_131_1.time_ and arg_131_1.time_ <= 4 + arg_134_0 then
				arg_131_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_21 = 2

			arg_131_1.isInRecall_ = false

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				arg_131_1.screenFilterGo_:SetActive(true)

				arg_131_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_134_2, iter_134_3 in pairs(arg_131_1.actors_) do
					for iter_134_4, iter_134_5 in ipairs((iter_134_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_134_5.color = iter_134_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_134_22 = 0.0166666666666667

			if var_134_21 <= arg_131_1.time_ and arg_131_1.time_ < var_134_21 + var_134_22 then
				arg_131_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_21) / var_134_22)
			end

			if arg_131_1.time_ >= var_134_21 + var_134_22 and arg_131_1.time_ < var_134_21 + var_134_22 + arg_134_0 then
				arg_131_1.screenFilterEffect_.weight = 1
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_23 = 4
			local var_134_24 = 0.75

			if 4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_25 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_25:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_26 = arg_131_1:GetWordFromCfg(221051032)
				local var_134_27 = arg_131_1:FormatText(var_134_26.content)

				arg_131_1.text_.text = var_134_27

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_29 = 30 <= 0 and var_134_24 or var_134_24 * (utf8.len(var_134_27) / 30)

				if (30 <= 0 and var_134_24 or var_134_24 * (utf8.len(var_134_27) / 30)) > 0 and var_134_24 < var_134_29 then
					arg_131_1.talkMaxDuration = var_134_29
					var_134_23 = var_134_23 + 0.3

					if var_134_29 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_29 + var_134_23
					end
				end

				arg_131_1.text_.text = var_134_27
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051032", "story_v_out_221051.awb") ~= 0 then
					local var_134_30 = manager.audio:GetVoiceLength("story_v_out_221051", "221051032", "story_v_out_221051.awb") / 1000

					if var_134_30 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_30 + var_134_23
					end

					if var_134_26.prefab_name ~= "" and arg_131_1.actors_[var_134_26.prefab_name] ~= nil then
						local var_134_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_26.prefab_name].transform, "story_v_out_221051", "221051032", "story_v_out_221051.awb")

						arg_131_1:RecordAudio("221051032", var_134_31)
						arg_131_1:RecordAudio("221051032", var_134_31)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_221051", "221051032", "story_v_out_221051.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_221051", "221051032", "story_v_out_221051.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_32 = var_134_23 + 0.3
			local var_134_33 = math.max(var_134_24, arg_131_1.talkMaxDuration)

			if var_134_23 + 0.3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_32 + var_134_33 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_32) / var_134_33

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_32 + var_134_33 and arg_131_1.time_ < var_134_32 + var_134_33 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play221051033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 221051033
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play221051034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				local var_140_0 = arg_137_1.bgs_.ST45

				arg_137_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_1 = var_140_0:GetComponent("SpriteRenderer")

				if var_140_1 and var_140_1.sprite then
					local var_140_2 = 2 * (var_140_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_0.transform.localScale = Vector3.New(var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "ST45" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_3 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_4 = 2

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_4 then
				local var_140_5 = Color.New(0, 0, 0)

				var_140_5.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_3) / var_140_4)
				arg_137_1.mask_.color = var_140_5
			end

			if arg_137_1.time_ >= var_140_3 + var_140_4 and arg_137_1.time_ < var_140_3 + var_140_4 + arg_140_0 then
				local var_140_6 = Color.New(0, 0, 0)

				var_140_6.a = 1
				arg_137_1.mask_.color = var_140_6
			end

			local var_140_7 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_8 = 2

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 then
				local var_140_9 = Color.New(0, 0, 0)

				var_140_9.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_7) / var_140_8)
				arg_137_1.mask_.color = var_140_9
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 then
				local var_140_10 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_10.a = 0
				arg_137_1.mask_.color = var_140_10
			end

			local var_140_11 = arg_137_1.actors_["1075ui_story"].transform

			if 1.98333333333333 < arg_137_1.time_ and arg_137_1.time_ <= 1.98333333333333 + arg_140_0 then
				arg_137_1.var_.moveOldPos1075ui_story = var_140_11.localPosition
			end

			local var_140_12 = 0.001

			if 1.98333333333333 <= arg_137_1.time_ and arg_137_1.time_ < 1.98333333333333 + var_140_12 then
				var_140_11.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 1.98333333333333) / var_140_12)
				var_140_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_11.position).x, (manager.ui.mainCamera.transform.position - var_140_11.position).y, (manager.ui.mainCamera.transform.position - var_140_11.position).z)
				var_140_11.localEulerAngles.z = 0
				var_140_11.localEulerAngles.x = 0
				var_140_11.localEulerAngles = var_140_11.localEulerAngles
			end

			if arg_137_1.time_ >= 1.98333333333333 + var_140_12 and arg_137_1.time_ < 1.98333333333333 + var_140_12 + arg_140_0 then
				var_140_11.localPosition = Vector3.New(0, 100, 0)
				var_140_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_11.position).x, (manager.ui.mainCamera.transform.position - var_140_11.position).y, (manager.ui.mainCamera.transform.position - var_140_11.position).z)
				var_140_11.localEulerAngles.z = 0
				var_140_11.localEulerAngles.x = 0
				var_140_11.localEulerAngles = var_140_11.localEulerAngles
			end

			local var_140_13 = 2

			arg_137_1.isInRecall_ = false

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1.screenFilterGo_:SetActive(false)

				for iter_140_2, iter_140_3 in pairs(arg_137_1.actors_) do
					for iter_140_4, iter_140_5 in ipairs((iter_140_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_140_5.color = iter_140_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_140_14 = 0.0166666666666667

			if var_140_13 <= arg_137_1.time_ and arg_137_1.time_ < var_140_13 + var_140_14 then
				arg_137_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_13) / var_140_14)
			end

			if arg_137_1.time_ >= var_140_13 + var_140_14 and arg_137_1.time_ < var_140_13 + var_140_14 + arg_140_0 then
				arg_137_1.screenFilterEffect_.weight = 0
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_15 = 4
			local var_140_16 = 0.375

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_17 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_17:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(221051033).content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 15 <= 0 and var_140_16 or var_140_16 * (utf8.len(var_140_18) / 15)

				if (15 <= 0 and var_140_16 or var_140_16 * (utf8.len(var_140_18) / 15)) > 0 and var_140_16 < var_140_20 then
					arg_137_1.talkMaxDuration = var_140_20
					var_140_15 = var_140_15 + 0.3

					if var_140_20 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_21 = var_140_15 + 0.3
			local var_140_22 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_21) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_21 + var_140_22 and arg_137_1.time_ < var_140_21 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666668,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play221051034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 221051034
		arg_143_1.duration_ = 4.83

		local var_143_0 = {
			ja = 4.2,
			ko = 4.833,
			zh = 4.833
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
				arg_143_0:Play221051035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1072ui_story = arg_143_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).z)
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles = arg_143_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
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
					arg_143_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1072ui_story then
				arg_143_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(221051034)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 17 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 17)

				if (17 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 17)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051034", "story_v_out_221051.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051034", "story_v_out_221051.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_221051", "221051034", "story_v_out_221051.awb")

						arg_143_1:RecordAudio("221051034", var_146_11)
						arg_143_1:RecordAudio("221051034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_221051", "221051034", "story_v_out_221051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_221051", "221051034", "story_v_out_221051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
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
	Play221051035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 221051035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play221051036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1072ui_story"]) and arg_147_1.var_.characterEffect1072ui_story == nil then
				arg_147_1.var_.characterEffect1072ui_story = arg_147_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1072ui_story"]) then
				if arg_147_1.var_.characterEffect1072ui_story and not isNil(arg_147_1.actors_["1072ui_story"]) then
					arg_147_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1072ui_story"]) and arg_147_1.var_.characterEffect1072ui_story then
				arg_147_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.875

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

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(221051035).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 35 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 35)

				if (35 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 35)) > 0 and var_150_2 < var_150_5 then
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

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play221051036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 221051036
		arg_151_1.duration_ = 15.03

		local var_151_0 = {
			ja = 15.033,
			ko = 10,
			zh = 10
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
				arg_151_0:Play221051037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1072ui_story = arg_151_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1072ui_story"].transform.position).z)
				arg_151_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1072ui_story"].transform.localEulerAngles = arg_151_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_151_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1072ui_story"].transform.position).z)
				arg_151_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1072ui_story"].transform.localEulerAngles = arg_151_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1072ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1072ui_story == nil then
				arg_151_1.var_.characterEffect1072ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1072ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1072ui_story then
				arg_151_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_154_3 = arg_151_1.actors_["1076ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1076ui_story = var_154_3.localPosition
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_3.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_151_1.time_ - 0) / var_154_4)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			local var_154_5 = arg_151_1.actors_["1076ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.characterEffect1076ui_story == nil then
				arg_151_1.var_.characterEffect1076ui_story = var_154_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_6 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 and not isNil(var_154_5) then
				if arg_151_1.var_.characterEffect1076ui_story and not isNil(var_154_5) then
					arg_151_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.characterEffect1076ui_story then
				arg_151_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_154_8 = 0
			local var_154_9 = 0.975

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(221051036)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 39 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 39)

				if (39 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 39)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051036", "story_v_out_221051.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_221051", "221051036", "story_v_out_221051.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_221051", "221051036", "story_v_out_221051.awb")

						arg_151_1:RecordAudio("221051036", var_154_15)
						arg_151_1:RecordAudio("221051036", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_221051", "221051036", "story_v_out_221051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_221051", "221051036", "story_v_out_221051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_16 and arg_151_1.time_ < var_154_8 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play221051037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 221051037
		arg_155_1.duration_ = 4.5

		local var_155_0 = {
			ja = 4.166,
			ko = 4.5,
			zh = 4.5
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
				arg_155_0:Play221051038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1072ui_story = arg_155_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1072ui_story"].transform.position).z)
				arg_155_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1072ui_story"].transform.localEulerAngles = arg_155_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_155_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1072ui_story"].transform.position).z)
				arg_155_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1072ui_story"].transform.localEulerAngles = arg_155_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1072ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1072ui_story == nil then
				arg_155_1.var_.characterEffect1072ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1072ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1072ui_story then
				arg_155_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_158_4 = arg_155_1.actors_["1076ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect1076ui_story == nil then
				arg_155_1.var_.characterEffect1076ui_story = var_158_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_5 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 and not isNil(var_158_4) then
				if arg_155_1.var_.characterEffect1076ui_story and not isNil(var_158_4) then
					arg_155_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_5)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect1076ui_story then
				arg_155_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_158_6 = 0
			local var_158_7 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(221051037)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 22 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 22)

				if (22 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 22)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051037", "story_v_out_221051.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051037", "story_v_out_221051.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_221051", "221051037", "story_v_out_221051.awb")

						arg_155_1:RecordAudio("221051037", var_158_13)
						arg_155_1:RecordAudio("221051037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_221051", "221051037", "story_v_out_221051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_221051", "221051037", "story_v_out_221051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play221051038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 221051038
		arg_159_1.duration_ = 7.87

		local var_159_0 = {
			ja = 7.866,
			ko = 3.2,
			zh = 3.2
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
				arg_159_0:Play221051039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1072ui_story = arg_159_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).z)
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles = arg_159_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_159_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).z)
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles = arg_159_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_1 = 0
			local var_162_2 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
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

				local var_162_3 = arg_159_1:GetWordFromCfg(221051038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 14 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_4) / 14)

				if (14 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_4) / 14)) > 0 and var_162_2 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051038", "story_v_out_221051.awb") ~= 0 then
					local var_162_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051038", "story_v_out_221051.awb") / 1000

					if var_162_7 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_1
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_221051", "221051038", "story_v_out_221051.awb")

						arg_159_1:RecordAudio("221051038", var_162_8)
						arg_159_1:RecordAudio("221051038", var_162_8)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_221051", "221051038", "story_v_out_221051.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_221051", "221051038", "story_v_out_221051.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_9 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_9 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_9

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_9 and arg_159_1.time_ < var_162_1 + var_162_9 + arg_162_0 then
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
	Play221051039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 221051039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play221051040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1072ui_story"]) and arg_163_1.var_.characterEffect1072ui_story == nil then
				arg_163_1.var_.characterEffect1072ui_story = arg_163_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1072ui_story"]) then
				if arg_163_1.var_.characterEffect1072ui_story and not isNil(arg_163_1.actors_["1072ui_story"]) then
					arg_163_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1072ui_story"]) and arg_163_1.var_.characterEffect1072ui_story then
				arg_163_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.825

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(221051039).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 33 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 33)

				if (33 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 33)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play221051040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 221051040
		arg_167_1.duration_ = 6.7

		local var_167_0 = {
			ja = 6.233,
			ko = 6.7,
			zh = 6.7
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
				arg_167_0:Play221051041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1072ui_story = arg_167_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1072ui_story"].transform.position).z)
				arg_167_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1072ui_story"].transform.localEulerAngles = arg_167_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1072ui_story"].transform.position).z)
				arg_167_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1072ui_story"].transform.localEulerAngles = arg_167_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1072ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1072ui_story == nil then
				arg_167_1.var_.characterEffect1072ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1072ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_2)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1072ui_story then
				arg_167_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_170_3 = arg_167_1.actors_["1076ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1076ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0, 100, 0)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = arg_167_1.actors_["1076ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1076ui_story == nil then
				arg_167_1.var_.characterEffect1076ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.characterEffect1076ui_story and not isNil(var_170_5) then
					arg_167_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_6)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1076ui_story then
				arg_167_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_170_7 = 0
			local var_170_8 = 0.55

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(221051040)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_12 = 22 <= 0 and var_170_8 or var_170_8 * (utf8.len(var_170_10) / 22)

				if (22 <= 0 and var_170_8 or var_170_8 * (utf8.len(var_170_10) / 22)) > 0 and var_170_8 < var_170_12 then
					arg_167_1.talkMaxDuration = var_170_12

					if var_170_12 + var_170_7 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_7
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051040", "story_v_out_221051.awb") ~= 0 then
					local var_170_13 = manager.audio:GetVoiceLength("story_v_out_221051", "221051040", "story_v_out_221051.awb") / 1000

					if var_170_13 + var_170_7 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_7
					end

					if var_170_9.prefab_name ~= "" and arg_167_1.actors_[var_170_9.prefab_name] ~= nil then
						local var_170_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_9.prefab_name].transform, "story_v_out_221051", "221051040", "story_v_out_221051.awb")

						arg_167_1:RecordAudio("221051040", var_170_14)
						arg_167_1:RecordAudio("221051040", var_170_14)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_221051", "221051040", "story_v_out_221051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_221051", "221051040", "story_v_out_221051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_15 = math.max(var_170_8, arg_167_1.talkMaxDuration)

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_15 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_7) / var_170_15

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_7 + var_170_15 and arg_167_1.time_ < var_170_7 + var_170_15 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play221051041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 221051041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play221051042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.775

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

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(221051041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 31 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 31)

				if (31 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 31)) > 0 and var_174_0 < var_174_3 then
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
	Play221051042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 221051042
		arg_175_1.duration_ = 11.77

		local var_175_0 = {
			ja = 11.766,
			ko = 5.3,
			zh = 5.3
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
				arg_175_0:Play221051043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1072ui_story = arg_175_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1072ui_story"].transform.position).z)
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1072ui_story"].transform.localEulerAngles = arg_175_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
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
					arg_175_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1072ui_story then
				arg_175_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_4 = 0
			local var_178_5 = 0.75

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(221051042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 30 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 30)

				if (30 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 30)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051042", "story_v_out_221051.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051042", "story_v_out_221051.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_221051", "221051042", "story_v_out_221051.awb")

						arg_175_1:RecordAudio("221051042", var_178_11)
						arg_175_1:RecordAudio("221051042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_221051", "221051042", "story_v_out_221051.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_221051", "221051042", "story_v_out_221051.awb")
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
	Play221051043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 221051043
		arg_179_1.duration_ = 1

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play221051044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1076ui_story = arg_179_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1076ui_story"].transform.position).z)
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1076ui_story"].transform.localEulerAngles = arg_179_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
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

			local var_182_4 = arg_179_1.actors_["1072ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1072ui_story == nil then
				arg_179_1.var_.characterEffect1072ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_5 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 and not isNil(var_182_4) then
				if arg_179_1.var_.characterEffect1072ui_story and not isNil(var_182_4) then
					arg_179_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_5)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1072ui_story then
				arg_179_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_182_6 = 0
			local var_182_7 = 0.05

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
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

				local var_182_8 = arg_179_1:GetWordFromCfg(221051043)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 2 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 2)

				if (2 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 2)) > 0 and var_182_7 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051043", "story_v_out_221051.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051043", "story_v_out_221051.awb") / 1000

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_221051", "221051043", "story_v_out_221051.awb")

						arg_179_1:RecordAudio("221051043", var_182_13)
						arg_179_1:RecordAudio("221051043", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_221051", "221051043", "story_v_out_221051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_221051", "221051043", "story_v_out_221051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
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
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play221051044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 221051044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play221051045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1076ui_story"]) and arg_183_1.var_.characterEffect1076ui_story == nil then
				arg_183_1.var_.characterEffect1076ui_story = arg_183_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1076ui_story"]) then
				if arg_183_1.var_.characterEffect1076ui_story and not isNil(arg_183_1.actors_["1076ui_story"]) then
					arg_183_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1076ui_story"]) and arg_183_1.var_.characterEffect1076ui_story then
				arg_183_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.875

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(221051044).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 35 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 35)

				if (35 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 35)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play221051045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 221051045
		arg_187_1.duration_ = 9.37

		local var_187_0 = {
			ja = 9.366,
			ko = 7,
			zh = 7
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play221051046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.875

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(221051045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 34 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 34)

				if (34 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 34)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051045", "story_v_out_221051.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051045", "story_v_out_221051.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_221051", "221051045", "story_v_out_221051.awb")

						arg_187_1:RecordAudio("221051045", var_190_6)
						arg_187_1:RecordAudio("221051045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_221051", "221051045", "story_v_out_221051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_221051", "221051045", "story_v_out_221051.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play221051046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 221051046
		arg_191_1.duration_ = 2

		local var_191_0 = {
			ja = 1.999999999999,
			ko = 2,
			zh = 2
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
				arg_191_0:Play221051047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1072ui_story = arg_191_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1072ui_story"].transform.position).z)
				arg_191_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1072ui_story"].transform.localEulerAngles = arg_191_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_191_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1072ui_story"].transform.position).z)
				arg_191_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1072ui_story"].transform.localEulerAngles = arg_191_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1072ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1072ui_story == nil then
				arg_191_1.var_.characterEffect1072ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1072ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1072ui_story then
				arg_191_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.2

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(221051046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 8 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 8)

				if (8 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 8)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051046", "story_v_out_221051.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051046", "story_v_out_221051.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_221051", "221051046", "story_v_out_221051.awb")

						arg_191_1:RecordAudio("221051046", var_194_11)
						arg_191_1:RecordAudio("221051046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_221051", "221051046", "story_v_out_221051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_221051", "221051046", "story_v_out_221051.awb")
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
				actorName = "1072ui_story",
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
	Play221051047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 221051047
		arg_195_1.duration_ = 3.07

		local var_195_0 = {
			ja = 2.833,
			ko = 3.066,
			zh = 3.066
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
				arg_195_0:Play221051048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1076ui_story = arg_195_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1076ui_story"].transform.position).z)
				arg_195_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1076ui_story"].transform.localEulerAngles = arg_195_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_195_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1076ui_story"].transform.position).z)
				arg_195_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1076ui_story"].transform.localEulerAngles = arg_195_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1076ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1076ui_story == nil then
				arg_195_1.var_.characterEffect1076ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1076ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1076ui_story then
				arg_195_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action7_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_4 = arg_195_1.actors_["1072ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1072ui_story == nil then
				arg_195_1.var_.characterEffect1072ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_5 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 and not isNil(var_198_4) then
				if arg_195_1.var_.characterEffect1072ui_story and not isNil(var_198_4) then
					arg_195_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_5)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1072ui_story then
				arg_195_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_198_6 = 0
			local var_198_7 = 0.25

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(221051047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 10 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 10)

				if (10 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 10)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051047", "story_v_out_221051.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051047", "story_v_out_221051.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_221051", "221051047", "story_v_out_221051.awb")

						arg_195_1:RecordAudio("221051047", var_198_13)
						arg_195_1:RecordAudio("221051047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_221051", "221051047", "story_v_out_221051.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_221051", "221051047", "story_v_out_221051.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play221051048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 221051048
		arg_199_1.duration_ = 4.97

		local var_199_0 = {
			ja = 4.966,
			ko = 3.8,
			zh = 3.8
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play221051049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1076ui_story = arg_199_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1076ui_story"].transform.position).z)
				arg_199_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1076ui_story"].transform.localEulerAngles = arg_199_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_199_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1076ui_story"].transform.position).z)
				arg_199_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1076ui_story"].transform.localEulerAngles = arg_199_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1076ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1076ui_story == nil then
				arg_199_1.var_.characterEffect1076ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1076ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1076ui_story then
				arg_199_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.425

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(221051048)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 17 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 17)

				if (17 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 17)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051048", "story_v_out_221051.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051048", "story_v_out_221051.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_221051", "221051048", "story_v_out_221051.awb")

						arg_199_1:RecordAudio("221051048", var_202_11)
						arg_199_1:RecordAudio("221051048", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_221051", "221051048", "story_v_out_221051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_221051", "221051048", "story_v_out_221051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play221051049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 221051049
		arg_203_1.duration_ = 6.4

		local var_203_0 = {
			ja = 6.4,
			ko = 5.066,
			zh = 5.066
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
				arg_203_0:Play221051050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1072ui_story = arg_203_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).z)
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles = arg_203_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_203_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).z)
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles = arg_203_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1072ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1072ui_story == nil then
				arg_203_1.var_.characterEffect1072ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1072ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1072ui_story then
				arg_203_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_206_4 = arg_203_1.actors_["1076ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1076ui_story == nil then
				arg_203_1.var_.characterEffect1076ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect1076ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1076ui_story then
				arg_203_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.575

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(221051049)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 23 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 23)

				if (23 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 23)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051049", "story_v_out_221051.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051049", "story_v_out_221051.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_221051", "221051049", "story_v_out_221051.awb")

						arg_203_1:RecordAudio("221051049", var_206_13)
						arg_203_1:RecordAudio("221051049", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_221051", "221051049", "story_v_out_221051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_221051", "221051049", "story_v_out_221051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play221051050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 221051050
		arg_207_1.duration_ = 5.6

		local var_207_0 = {
			ja = 5.6,
			ko = 3.533,
			zh = 3.533
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play221051051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1072ui_story = arg_207_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1072ui_story"].transform.position).z)
				arg_207_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1072ui_story"].transform.localEulerAngles = arg_207_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1072ui_story"].transform.position).z)
				arg_207_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1072ui_story"].transform.localEulerAngles = arg_207_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1072ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1072ui_story == nil then
				arg_207_1.var_.characterEffect1072ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1072ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1072ui_story then
				arg_207_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_210_3 = arg_207_1.actors_["1076ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1076ui_story = var_210_3.localPosition
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_3.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_4)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_3.localPosition = Vector3.New(0, 100, 0)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			local var_210_5 = arg_207_1.actors_["1076ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1076ui_story == nil then
				arg_207_1.var_.characterEffect1076ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect1076ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_6)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1076ui_story then
				arg_207_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_210_7 = 0
			local var_210_8 = 0.225

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(221051050)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_12 = 9 <= 0 and var_210_8 or var_210_8 * (utf8.len(var_210_10) / 9)

				if (9 <= 0 and var_210_8 or var_210_8 * (utf8.len(var_210_10) / 9)) > 0 and var_210_8 < var_210_12 then
					arg_207_1.talkMaxDuration = var_210_12

					if var_210_12 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_7
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051050", "story_v_out_221051.awb") ~= 0 then
					local var_210_13 = manager.audio:GetVoiceLength("story_v_out_221051", "221051050", "story_v_out_221051.awb") / 1000

					if var_210_13 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_7
					end

					if var_210_9.prefab_name ~= "" and arg_207_1.actors_[var_210_9.prefab_name] ~= nil then
						local var_210_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_9.prefab_name].transform, "story_v_out_221051", "221051050", "story_v_out_221051.awb")

						arg_207_1:RecordAudio("221051050", var_210_14)
						arg_207_1:RecordAudio("221051050", var_210_14)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_221051", "221051050", "story_v_out_221051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_221051", "221051050", "story_v_out_221051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_15 = math.max(var_210_8, arg_207_1.talkMaxDuration)

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_15 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_7) / var_210_15

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_7 + var_210_15 and arg_207_1.time_ < var_210_7 + var_210_15 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play221051051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 221051051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play221051052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.575

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(221051051).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 23 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 23)

				if (23 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 23)) > 0 and var_214_0 < var_214_3 then
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
	Play221051052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 221051052
		arg_215_1.duration_ = 14.53

		local var_215_0 = {
			ja = 14.533,
			ko = 8.7,
			zh = 8.7
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
				arg_215_0:Play221051053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.225

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(221051052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 49 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 49)

				if (49 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 49)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051052", "story_v_out_221051.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051052", "story_v_out_221051.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_221051", "221051052", "story_v_out_221051.awb")

						arg_215_1:RecordAudio("221051052", var_218_6)
						arg_215_1:RecordAudio("221051052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_221051", "221051052", "story_v_out_221051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_221051", "221051052", "story_v_out_221051.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play221051053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 221051053
		arg_219_1.duration_ = 6.2

		local var_219_0 = {
			ja = 4.5,
			ko = 6.2,
			zh = 6.2
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
				arg_219_0:Play221051054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1072ui_story = arg_219_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1072ui_story"].transform.position).z)
				arg_219_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1072ui_story"].transform.localEulerAngles = arg_219_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_219_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1072ui_story"].transform.position).z)
				arg_219_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1072ui_story"].transform.localEulerAngles = arg_219_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1072ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1072ui_story == nil then
				arg_219_1.var_.characterEffect1072ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1072ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1072ui_story then
				arg_219_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_222_4 = 0
			local var_222_5 = 0.725

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(221051053)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 29 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 29)

				if (29 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 29)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051053", "story_v_out_221051.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051053", "story_v_out_221051.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_221051", "221051053", "story_v_out_221051.awb")

						arg_219_1:RecordAudio("221051053", var_222_11)
						arg_219_1:RecordAudio("221051053", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_221051", "221051053", "story_v_out_221051.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_221051", "221051053", "story_v_out_221051.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play221051054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 221051054
		arg_223_1.duration_ = 7.8

		local var_223_0 = {
			ja = 7.8,
			ko = 4,
			zh = 4
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
				arg_223_0:Play221051055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1072ui_story = arg_223_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1072ui_story"].transform.position).z)
				arg_223_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1072ui_story"].transform.localEulerAngles = arg_223_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_223_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1072ui_story"].transform.position).z)
				arg_223_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1072ui_story"].transform.localEulerAngles = arg_223_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1072ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1072ui_story == nil then
				arg_223_1.var_.characterEffect1072ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1072ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1072ui_story then
				arg_223_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.5

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(221051054)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 20 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 20)

				if (20 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 20)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051054", "story_v_out_221051.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051054", "story_v_out_221051.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_221051", "221051054", "story_v_out_221051.awb")

						arg_223_1:RecordAudio("221051054", var_226_11)
						arg_223_1:RecordAudio("221051054", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_221051", "221051054", "story_v_out_221051.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_221051", "221051054", "story_v_out_221051.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play221051055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 221051055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play221051056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1072ui_story = arg_227_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1072ui_story"].transform.position).z)
				arg_227_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1072ui_story"].transform.localEulerAngles = arg_227_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1072ui_story"].transform.position).z)
				arg_227_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1072ui_story"].transform.localEulerAngles = arg_227_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1072ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1072ui_story == nil then
				arg_227_1.var_.characterEffect1072ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1072ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_2)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1072ui_story then
				arg_227_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_230_3 = 0
			local var_230_4 = 1.075

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(221051055).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 43 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 43)

				if (43 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 43)) > 0 and var_230_4 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_3
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_4, arg_227_1.talkMaxDuration)

			if var_230_3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_3 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_3) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_3 + var_230_8 and arg_227_1.time_ < var_230_3 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play221051056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 221051056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play221051057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.4

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(221051056).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 15 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 15)

				if (15 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 15)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play221051057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 221051057
		arg_235_1.duration_ = 3.17

		local var_235_0 = {
			ja = 2.966,
			ko = 3.166,
			zh = 3.166
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
				arg_235_0:Play221051058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.35

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(221051057)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 14 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 14)

				if (14 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 14)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051057", "story_v_out_221051.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051057", "story_v_out_221051.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_221051", "221051057", "story_v_out_221051.awb")

						arg_235_1:RecordAudio("221051057", var_238_6)
						arg_235_1:RecordAudio("221051057", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_221051", "221051057", "story_v_out_221051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_221051", "221051057", "story_v_out_221051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play221051058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 221051058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play221051059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.475

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(221051058).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 19 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 19)

				if (19 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 19)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play221051059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 221051059
		arg_243_1.duration_ = 2.8

		local var_243_0 = {
			ja = 2.8,
			ko = 2.533,
			zh = 2.533
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
				arg_243_0:Play221051060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1072ui_story = arg_243_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1072ui_story"].transform.position).z)
				arg_243_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1072ui_story"].transform.localEulerAngles = arg_243_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_243_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1072ui_story"].transform.position).z)
				arg_243_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1072ui_story"].transform.localEulerAngles = arg_243_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1072ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1072ui_story == nil then
				arg_243_1.var_.characterEffect1072ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1072ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1072ui_story then
				arg_243_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_246_4 = 0
			local var_246_5 = 0.25

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(221051059)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 10 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 10)

				if (10 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 10)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051059", "story_v_out_221051.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051059", "story_v_out_221051.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_221051", "221051059", "story_v_out_221051.awb")

						arg_243_1:RecordAudio("221051059", var_246_11)
						arg_243_1:RecordAudio("221051059", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_221051", "221051059", "story_v_out_221051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_221051", "221051059", "story_v_out_221051.awb")
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
				actorName = "1072ui_story",
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
	Play221051060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 221051060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play221051061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1072ui_story = arg_247_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1072ui_story"].transform.position).z)
				arg_247_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1072ui_story"].transform.localEulerAngles = arg_247_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1072ui_story"].transform.position).z)
				arg_247_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1072ui_story"].transform.localEulerAngles = arg_247_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1072ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1072ui_story == nil then
				arg_247_1.var_.characterEffect1072ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1072ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_2)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1072ui_story then
				arg_247_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_250_3 = 0
			local var_250_4 = 0.65

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_5 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(221051060).content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 26 <= 0 and var_250_4 or var_250_4 * (utf8.len(var_250_5) / 26)

				if (26 <= 0 and var_250_4 or var_250_4 * (utf8.len(var_250_5) / 26)) > 0 and var_250_4 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_3 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_3
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_4, arg_247_1.talkMaxDuration)

			if var_250_3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_3 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_3) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_3 + var_250_8 and arg_247_1.time_ < var_250_3 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play221051061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 221051061
		arg_251_1.duration_ = 8.2

		local var_251_0 = {
			ja = 8.2,
			ko = 5.066,
			zh = 5.066
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
				arg_251_0:Play221051062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.625

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(221051061)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 25 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 25)

				if (25 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 25)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051061", "story_v_out_221051.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051061", "story_v_out_221051.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_221051", "221051061", "story_v_out_221051.awb")

						arg_251_1:RecordAudio("221051061", var_254_6)
						arg_251_1:RecordAudio("221051061", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_221051", "221051061", "story_v_out_221051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_221051", "221051061", "story_v_out_221051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play221051062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 221051062
		arg_255_1.duration_ = 9.17

		local var_255_0 = {
			ja = 9.166,
			ko = 8.566,
			zh = 8.566
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
				arg_255_0:Play221051063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1.2

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[427].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(221051062)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 48 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 48)

				if (48 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 48)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051062", "story_v_out_221051.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051062", "story_v_out_221051.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_221051", "221051062", "story_v_out_221051.awb")

						arg_255_1:RecordAudio("221051062", var_258_6)
						arg_255_1:RecordAudio("221051062", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_221051", "221051062", "story_v_out_221051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_221051", "221051062", "story_v_out_221051.awb")
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
	Play221051063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 221051063
		arg_259_1.duration_ = 5.47

		local var_259_0 = {
			ja = 5.466,
			ko = 4.533,
			zh = 4.533
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
				arg_259_0:Play221051064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1072ui_story = arg_259_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1072ui_story"].transform.position).z)
				arg_259_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1072ui_story"].transform.localEulerAngles = arg_259_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_259_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1072ui_story"].transform.position).z)
				arg_259_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1072ui_story"].transform.localEulerAngles = arg_259_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1072ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1072ui_story == nil then
				arg_259_1.var_.characterEffect1072ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1072ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1072ui_story then
				arg_259_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_4 = 0
			local var_262_5 = 0.425

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(221051063)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 17 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 17)

				if (17 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 17)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051063", "story_v_out_221051.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051063", "story_v_out_221051.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_221051", "221051063", "story_v_out_221051.awb")

						arg_259_1:RecordAudio("221051063", var_262_11)
						arg_259_1:RecordAudio("221051063", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_221051", "221051063", "story_v_out_221051.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_221051", "221051063", "story_v_out_221051.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play221051064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 221051064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play221051065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1072ui_story"]) and arg_263_1.var_.characterEffect1072ui_story == nil then
				arg_263_1.var_.characterEffect1072ui_story = arg_263_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1072ui_story"]) then
				if arg_263_1.var_.characterEffect1072ui_story and not isNil(arg_263_1.actors_["1072ui_story"]) then
					arg_263_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1072ui_story"]) and arg_263_1.var_.characterEffect1072ui_story then
				arg_263_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_266_1 = arg_263_1.actors_["1072ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1072ui_story = var_266_1.localPosition
			end

			local var_266_2 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 then
				var_266_1.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_2)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 then
				var_266_1.localPosition = Vector3.New(0, 100, 0)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			local var_266_3 = 0
			local var_266_4 = 0.325

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_5 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(221051064).content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 13 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 13)

				if (13 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 13)) > 0 and var_266_4 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_3
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_4, arg_263_1.talkMaxDuration)

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_3) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_3 + var_266_8 and arg_263_1.time_ < var_266_3 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play221051065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 221051065
		arg_267_1.duration_ = 5.53

		local var_267_0 = {
			ja = 5.533,
			ko = 4.966,
			zh = 4.966
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
				arg_267_0:Play221051066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1076ui_story = arg_267_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1076ui_story"].transform.position).z)
				arg_267_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1076ui_story"].transform.localEulerAngles = arg_267_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_267_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1076ui_story"].transform.position).z)
				arg_267_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1076ui_story"].transform.localEulerAngles = arg_267_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1076ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1076ui_story == nil then
				arg_267_1.var_.characterEffect1076ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1076ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1076ui_story then
				arg_267_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_270_4 = 0
			local var_270_5 = 0.6

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(221051065)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 24 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 24)

				if (24 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 24)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051065", "story_v_out_221051.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051065", "story_v_out_221051.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_out_221051", "221051065", "story_v_out_221051.awb")

						arg_267_1:RecordAudio("221051065", var_270_11)
						arg_267_1:RecordAudio("221051065", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_221051", "221051065", "story_v_out_221051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_221051", "221051065", "story_v_out_221051.awb")
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
				actorName = "1076ui_story",
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
	Play221051066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 221051066
		arg_271_1.duration_ = 2.57

		local var_271_0 = {
			ja = 1.999999999999,
			ko = 2.566,
			zh = 2.566
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
				arg_271_0:Play221051067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1072ui_story = arg_271_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1072ui_story"].transform.position).z)
				arg_271_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1072ui_story"].transform.localEulerAngles = arg_271_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_271_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1072ui_story"].transform.position).z)
				arg_271_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1072ui_story"].transform.localEulerAngles = arg_271_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1072ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1072ui_story == nil then
				arg_271_1.var_.characterEffect1072ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1072ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1072ui_story then
				arg_271_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_274_4 = arg_271_1.actors_["1076ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect1076ui_story == nil then
				arg_271_1.var_.characterEffect1076ui_story = var_274_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_5 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 and not isNil(var_274_4) then
				if arg_271_1.var_.characterEffect1076ui_story and not isNil(var_274_4) then
					arg_271_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_5)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect1076ui_story then
				arg_271_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_274_6 = 0
			local var_274_7 = 0.25

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(221051066)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 10 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 10)

				if (10 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 10)) > 0 and var_274_7 < var_274_11 then
					arg_271_1.talkMaxDuration = var_274_11

					if var_274_11 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051066", "story_v_out_221051.awb") ~= 0 then
					local var_274_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051066", "story_v_out_221051.awb") / 1000

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end

					if var_274_8.prefab_name ~= "" and arg_271_1.actors_[var_274_8.prefab_name] ~= nil then
						local var_274_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_8.prefab_name].transform, "story_v_out_221051", "221051066", "story_v_out_221051.awb")

						arg_271_1:RecordAudio("221051066", var_274_13)
						arg_271_1:RecordAudio("221051066", var_274_13)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_221051", "221051066", "story_v_out_221051.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_221051", "221051066", "story_v_out_221051.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play221051067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 221051067
		arg_275_1.duration_ = 5

		local var_275_0 = {
			ja = 5,
			ko = 4.933,
			zh = 4.933
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
				arg_275_0:Play221051068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1076ui_story = arg_275_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).z)
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles = arg_275_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_275_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).z)
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles = arg_275_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1076ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1076ui_story == nil then
				arg_275_1.var_.characterEffect1076ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1076ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1076ui_story then
				arg_275_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_278_4 = arg_275_1.actors_["1072ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect1072ui_story == nil then
				arg_275_1.var_.characterEffect1072ui_story = var_278_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_5 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 and not isNil(var_278_4) then
				if arg_275_1.var_.characterEffect1072ui_story and not isNil(var_278_4) then
					arg_275_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_5)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect1072ui_story then
				arg_275_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_278_6 = 0
			local var_278_7 = 0.55

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(221051067)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 22 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 22)

				if (22 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 22)) > 0 and var_278_7 < var_278_11 then
					arg_275_1.talkMaxDuration = var_278_11

					if var_278_11 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051067", "story_v_out_221051.awb") ~= 0 then
					local var_278_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051067", "story_v_out_221051.awb") / 1000

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end

					if var_278_8.prefab_name ~= "" and arg_275_1.actors_[var_278_8.prefab_name] ~= nil then
						local var_278_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_8.prefab_name].transform, "story_v_out_221051", "221051067", "story_v_out_221051.awb")

						arg_275_1:RecordAudio("221051067", var_278_13)
						arg_275_1:RecordAudio("221051067", var_278_13)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_221051", "221051067", "story_v_out_221051.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_221051", "221051067", "story_v_out_221051.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play221051068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 221051068
		arg_279_1.duration_ = 5.43

		local var_279_0 = {
			ja = 4.833,
			ko = 5.433,
			zh = 5.433
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play221051069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1076ui_story = arg_279_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1076ui_story"].transform.position).z)
				arg_279_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1076ui_story"].transform.localEulerAngles = arg_279_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_279_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1076ui_story"].transform.position).z)
				arg_279_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1076ui_story"].transform.localEulerAngles = arg_279_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_282_1 = 0
			local var_282_2 = 0.6

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:GetWordFromCfg(221051068)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 24 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_4) / 24)

				if (24 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_4) / 24)) > 0 and var_282_2 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051068", "story_v_out_221051.awb") ~= 0 then
					local var_282_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051068", "story_v_out_221051.awb") / 1000

					if var_282_7 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_1
					end

					if var_282_3.prefab_name ~= "" and arg_279_1.actors_[var_282_3.prefab_name] ~= nil then
						local var_282_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_3.prefab_name].transform, "story_v_out_221051", "221051068", "story_v_out_221051.awb")

						arg_279_1:RecordAudio("221051068", var_282_8)
						arg_279_1:RecordAudio("221051068", var_282_8)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_221051", "221051068", "story_v_out_221051.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_221051", "221051068", "story_v_out_221051.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_9 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_9 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_9

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_9 and arg_279_1.time_ < var_282_1 + var_282_9 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play221051069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 221051069
		arg_283_1.duration_ = 9

		local var_283_0 = {
			ja = 9,
			ko = 7.1,
			zh = 7.1
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
				arg_283_0:Play221051070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1076ui_story = arg_283_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1076ui_story"].transform.position).z)
				arg_283_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1076ui_story"].transform.localEulerAngles = arg_283_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_283_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1076ui_story"].transform.position).z)
				arg_283_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1076ui_story"].transform.localEulerAngles = arg_283_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076actionlink/1076action425")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_1 = 0
			local var_286_2 = 0.775

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(221051069)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 31 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_4) / 31)

				if (31 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_4) / 31)) > 0 and var_286_2 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051069", "story_v_out_221051.awb") ~= 0 then
					local var_286_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051069", "story_v_out_221051.awb") / 1000

					if var_286_7 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_1
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_221051", "221051069", "story_v_out_221051.awb")

						arg_283_1:RecordAudio("221051069", var_286_8)
						arg_283_1:RecordAudio("221051069", var_286_8)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_221051", "221051069", "story_v_out_221051.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_221051", "221051069", "story_v_out_221051.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_9 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_9 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_9

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_9 and arg_283_1.time_ < var_286_1 + var_286_9 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play221051070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 221051070
		arg_287_1.duration_ = 7.4

		local var_287_0 = {
			ja = 7.4,
			ko = 4.366,
			zh = 4.366
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
				arg_287_0:Play221051071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1072ui_story = arg_287_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1072ui_story"].transform.position).z)
				arg_287_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1072ui_story"].transform.localEulerAngles = arg_287_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_287_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1072ui_story"].transform.position).z)
				arg_287_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1072ui_story"].transform.localEulerAngles = arg_287_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1072ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1072ui_story == nil then
				arg_287_1.var_.characterEffect1072ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1072ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1072ui_story then
				arg_287_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action424")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_4 = arg_287_1.actors_["1076ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect1076ui_story == nil then
				arg_287_1.var_.characterEffect1076ui_story = var_290_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_5 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 and not isNil(var_290_4) then
				if arg_287_1.var_.characterEffect1076ui_story and not isNil(var_290_4) then
					arg_287_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_5)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect1076ui_story then
				arg_287_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_290_6 = 0
			local var_290_7 = 0.4

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_8 = arg_287_1:GetWordFromCfg(221051070)
				local var_290_9 = arg_287_1:FormatText(var_290_8.content)

				arg_287_1.text_.text = var_290_9

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 16 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 16)

				if (16 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 16)) > 0 and var_290_7 < var_290_11 then
					arg_287_1.talkMaxDuration = var_290_11

					if var_290_11 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_9
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051070", "story_v_out_221051.awb") ~= 0 then
					local var_290_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051070", "story_v_out_221051.awb") / 1000

					if var_290_12 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_6
					end

					if var_290_8.prefab_name ~= "" and arg_287_1.actors_[var_290_8.prefab_name] ~= nil then
						local var_290_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_8.prefab_name].transform, "story_v_out_221051", "221051070", "story_v_out_221051.awb")

						arg_287_1:RecordAudio("221051070", var_290_13)
						arg_287_1:RecordAudio("221051070", var_290_13)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_221051", "221051070", "story_v_out_221051.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_221051", "221051070", "story_v_out_221051.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play221051071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 221051071
		arg_291_1.duration_ = 8.2

		local var_291_0 = {
			ja = 7.966,
			ko = 8.2,
			zh = 8.2
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play221051072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1072ui_story = arg_291_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1072ui_story"].transform.position).z)
				arg_291_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1072ui_story"].transform.localEulerAngles = arg_291_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_291_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1072ui_story"].transform.position).z)
				arg_291_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1072ui_story"].transform.localEulerAngles = arg_291_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action446")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_294_1 = 0
			local var_294_2 = 0.9

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:GetWordFromCfg(221051071)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_6 = 36 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_4) / 36)

				if (36 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_4) / 36)) > 0 and var_294_2 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051071", "story_v_out_221051.awb") ~= 0 then
					local var_294_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051071", "story_v_out_221051.awb") / 1000

					if var_294_7 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_1
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_221051", "221051071", "story_v_out_221051.awb")

						arg_291_1:RecordAudio("221051071", var_294_8)
						arg_291_1:RecordAudio("221051071", var_294_8)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_221051", "221051071", "story_v_out_221051.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_221051", "221051071", "story_v_out_221051.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_9 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_9 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_9

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_9 and arg_291_1.time_ < var_294_1 + var_294_9 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play221051072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 221051072
		arg_295_1.duration_ = 13.93

		local var_295_0 = {
			ja = 13.933,
			ko = 9.1,
			zh = 9.1
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
				arg_295_0:Play221051073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 1.05

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:GetWordFromCfg(221051072)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 42 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 42)

				if (42 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 42)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051072", "story_v_out_221051.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051072", "story_v_out_221051.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_221051", "221051072", "story_v_out_221051.awb")

						arg_295_1:RecordAudio("221051072", var_298_6)
						arg_295_1:RecordAudio("221051072", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_221051", "221051072", "story_v_out_221051.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_221051", "221051072", "story_v_out_221051.awb")
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
	Play221051073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 221051073
		arg_299_1.duration_ = 16.37

		local var_299_0 = {
			ja = 16.366,
			ko = 11.4,
			zh = 11.4
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
				arg_299_0:Play221051074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.275

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(221051073)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 51 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 51)

				if (51 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 51)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051073", "story_v_out_221051.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051073", "story_v_out_221051.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_221051", "221051073", "story_v_out_221051.awb")

						arg_299_1:RecordAudio("221051073", var_302_6)
						arg_299_1:RecordAudio("221051073", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_221051", "221051073", "story_v_out_221051.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_221051", "221051073", "story_v_out_221051.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play221051074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 221051074
		arg_303_1.duration_ = 9.27

		local var_303_0 = {
			ja = 9.266,
			ko = 3.633,
			zh = 3.633
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play221051075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1072ui_story = arg_303_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1072ui_story"].transform.position).z)
				arg_303_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1072ui_story"].transform.localEulerAngles = arg_303_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_303_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1072ui_story"].transform.position).z)
				arg_303_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1072ui_story"].transform.localEulerAngles = arg_303_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_1 = 0
			local var_306_2 = 0.45

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(221051074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 18 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 18)

				if (18 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 18)) > 0 and var_306_2 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051074", "story_v_out_221051.awb") ~= 0 then
					local var_306_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051074", "story_v_out_221051.awb") / 1000

					if var_306_7 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_1
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_221051", "221051074", "story_v_out_221051.awb")

						arg_303_1:RecordAudio("221051074", var_306_8)
						arg_303_1:RecordAudio("221051074", var_306_8)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_221051", "221051074", "story_v_out_221051.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_221051", "221051074", "story_v_out_221051.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_9 and arg_303_1.time_ < var_306_1 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play221051075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 221051075
		arg_307_1.duration_ = 10.63

		local var_307_0 = {
			ja = 10.633,
			ko = 6.333,
			zh = 6.333
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play221051076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1076ui_story = arg_307_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1076ui_story"].transform.position).z)
				arg_307_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1076ui_story"].transform.localEulerAngles = arg_307_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_307_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1076ui_story"].transform.position).z)
				arg_307_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1076ui_story"].transform.localEulerAngles = arg_307_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1076ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1076ui_story == nil then
				arg_307_1.var_.characterEffect1076ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1076ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1076ui_story then
				arg_307_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_4 = arg_307_1.actors_["1072ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_4) and arg_307_1.var_.characterEffect1072ui_story == nil then
				arg_307_1.var_.characterEffect1072ui_story = var_310_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_5 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_5 and not isNil(var_310_4) then
				if arg_307_1.var_.characterEffect1072ui_story and not isNil(var_310_4) then
					arg_307_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_5)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_5 and arg_307_1.time_ < 0 + var_310_5 + arg_310_0 and not isNil(var_310_4) and arg_307_1.var_.characterEffect1072ui_story then
				arg_307_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_310_6 = 0
			local var_310_7 = 0.65

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(221051075)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 26 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 26)

				if (26 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 26)) > 0 and var_310_7 < var_310_11 then
					arg_307_1.talkMaxDuration = var_310_11

					if var_310_11 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051075", "story_v_out_221051.awb") ~= 0 then
					local var_310_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051075", "story_v_out_221051.awb") / 1000

					if var_310_12 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_6
					end

					if var_310_8.prefab_name ~= "" and arg_307_1.actors_[var_310_8.prefab_name] ~= nil then
						local var_310_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_8.prefab_name].transform, "story_v_out_221051", "221051075", "story_v_out_221051.awb")

						arg_307_1:RecordAudio("221051075", var_310_13)
						arg_307_1:RecordAudio("221051075", var_310_13)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_221051", "221051075", "story_v_out_221051.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_221051", "221051075", "story_v_out_221051.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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

		arg_307_1:InitPlayNodeList()
	end,
	Play221051076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 221051076
		arg_311_1.duration_ = 5.57

		local var_311_0 = {
			ja = 5.566,
			ko = 5.166,
			zh = 5.166
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
				arg_311_0:Play221051077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1072ui_story = arg_311_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).z)
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles = arg_311_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_311_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).z)
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles = arg_311_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1072ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1072ui_story == nil then
				arg_311_1.var_.characterEffect1072ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1072ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1072ui_story then
				arg_311_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_314_4 = arg_311_1.actors_["1076ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect1076ui_story == nil then
				arg_311_1.var_.characterEffect1076ui_story = var_314_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_5 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_5 and not isNil(var_314_4) then
				if arg_311_1.var_.characterEffect1076ui_story and not isNil(var_314_4) then
					arg_311_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_5)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_5 and arg_311_1.time_ < 0 + var_314_5 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect1076ui_story then
				arg_311_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_314_6 = 0
			local var_314_7 = 0.475

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_8 = arg_311_1:GetWordFromCfg(221051076)
				local var_314_9 = arg_311_1:FormatText(var_314_8.content)

				arg_311_1.text_.text = var_314_9

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 19 <= 0 and var_314_7 or var_314_7 * (utf8.len(var_314_9) / 19)

				if (19 <= 0 and var_314_7 or var_314_7 * (utf8.len(var_314_9) / 19)) > 0 and var_314_7 < var_314_11 then
					arg_311_1.talkMaxDuration = var_314_11

					if var_314_11 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_9
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051076", "story_v_out_221051.awb") ~= 0 then
					local var_314_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051076", "story_v_out_221051.awb") / 1000

					if var_314_12 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_12 + var_314_6
					end

					if var_314_8.prefab_name ~= "" and arg_311_1.actors_[var_314_8.prefab_name] ~= nil then
						local var_314_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_8.prefab_name].transform, "story_v_out_221051", "221051076", "story_v_out_221051.awb")

						arg_311_1:RecordAudio("221051076", var_314_13)
						arg_311_1:RecordAudio("221051076", var_314_13)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_221051", "221051076", "story_v_out_221051.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_221051", "221051076", "story_v_out_221051.awb")
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
				actorName = "1072ui_story",
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
	Play221051077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 221051077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play221051078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1076ui_story = arg_315_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1076ui_story"].transform.position).z)
				arg_315_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1076ui_story"].transform.localEulerAngles = arg_315_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_315_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1076ui_story"].transform.position).z)
				arg_315_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1076ui_story"].transform.localEulerAngles = arg_315_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1076ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1076ui_story == nil then
				arg_315_1.var_.characterEffect1076ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1076ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_2)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1076ui_story then
				arg_315_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_318_3 = arg_315_1.actors_["1072ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1072ui_story = var_318_3.localPosition
			end

			local var_318_4 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				var_318_3.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_4)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				var_318_3.localPosition = Vector3.New(0, 100, 0)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles
			end

			local var_318_5 = arg_315_1.actors_["1072ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.characterEffect1072ui_story == nil then
				arg_315_1.var_.characterEffect1072ui_story = var_318_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_6 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_6 and not isNil(var_318_5) then
				if arg_315_1.var_.characterEffect1072ui_story and not isNil(var_318_5) then
					arg_315_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_6)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_6 and arg_315_1.time_ < 0 + var_318_6 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.characterEffect1072ui_story then
				arg_315_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_318_7 = 0
			local var_318_8 = 1.075

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_7 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_9 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(221051077).content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 43 <= 0 and var_318_8 or var_318_8 * (utf8.len(var_318_9) / 43)

				if (43 <= 0 and var_318_8 or var_318_8 * (utf8.len(var_318_9) / 43)) > 0 and var_318_8 < var_318_11 then
					arg_315_1.talkMaxDuration = var_318_11

					if var_318_11 + var_318_7 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_7
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_8, arg_315_1.talkMaxDuration)

			if var_318_7 <= arg_315_1.time_ and arg_315_1.time_ < var_318_7 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_7) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_7 + var_318_12 and arg_315_1.time_ < var_318_7 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play221051078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 221051078
		arg_319_1.duration_ = 8.2

		local var_319_0 = {
			ja = 8.2,
			ko = 7.4,
			zh = 7.4
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
				arg_319_0:Play221051079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if arg_319_1.bgs_.ST31 == nil then
				local var_322_0 = Object.Instantiate(arg_319_1.paintGo_)

				var_322_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_322_0.name = "ST31"
				var_322_0.transform.parent = arg_319_1.stage_.transform
				var_322_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_319_1.bgs_.ST31 = var_322_0
			end

			if 2 < arg_319_1.time_ and arg_319_1.time_ <= 2 + arg_322_0 then
				local var_322_1 = arg_319_1.bgs_.ST31

				arg_319_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_322_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_322_2 = var_322_1:GetComponent("SpriteRenderer")

				if var_322_2 and var_322_2.sprite then
					local var_322_3 = 2 * (var_322_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_322_1.transform.localScale = Vector3.New(var_322_3 / var_322_2.sprite.bounds.size.y < var_322_3 * manager.ui.mainCameraCom_.aspect / var_322_2.sprite.bounds.size.x and var_322_3 * manager.ui.mainCameraCom_.aspect / var_322_2.sprite.bounds.size.x or var_322_3 / var_322_2.sprite.bounds.size.y, var_322_3 / var_322_2.sprite.bounds.size.y < var_322_3 * manager.ui.mainCameraCom_.aspect / var_322_2.sprite.bounds.size.x and var_322_3 * manager.ui.mainCameraCom_.aspect / var_322_2.sprite.bounds.size.x or var_322_3 / var_322_2.sprite.bounds.size.y, 0)
				end

				for iter_322_0, iter_322_1 in pairs(arg_319_1.bgs_) do
					if iter_322_0 ~= "ST31" then
						iter_322_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_322_4 = 0

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_5 = 2

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_5 then
				local var_322_6 = Color.New(0, 0, 0)

				var_322_6.a = Mathf.Lerp(0, 1, (arg_319_1.time_ - var_322_4) / var_322_5)
				arg_319_1.mask_.color = var_322_6
			end

			if arg_319_1.time_ >= var_322_4 + var_322_5 and arg_319_1.time_ < var_322_4 + var_322_5 + arg_322_0 then
				local var_322_7 = Color.New(0, 0, 0)

				var_322_7.a = 1
				arg_319_1.mask_.color = var_322_7
			end

			local var_322_8 = 2

			if 2 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_9 = 2

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_9 then
				local var_322_10 = Color.New(0, 0, 0)

				var_322_10.a = Mathf.Lerp(1, 0, (arg_319_1.time_ - var_322_8) / var_322_9)
				arg_319_1.mask_.color = var_322_10
			end

			if arg_319_1.time_ >= var_322_8 + var_322_9 and arg_319_1.time_ < var_322_8 + var_322_9 + arg_322_0 then
				local var_322_11 = Color.New(0, 0, 0)

				arg_319_1.mask_.enabled = false
				var_322_11.a = 0
				arg_319_1.mask_.color = var_322_11
			end

			local var_322_12 = arg_319_1.actors_["1072ui_story"].transform

			if 4 < arg_319_1.time_ and arg_319_1.time_ <= 4 + arg_322_0 then
				arg_319_1.var_.moveOldPos1072ui_story = var_322_12.localPosition
			end

			local var_322_13 = 0.001

			if 4 <= arg_319_1.time_ and arg_319_1.time_ < 4 + var_322_13 then
				var_322_12.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_319_1.time_ - 4) / var_322_13)
				var_322_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_12.position).x, (manager.ui.mainCamera.transform.position - var_322_12.position).y, (manager.ui.mainCamera.transform.position - var_322_12.position).z)
				var_322_12.localEulerAngles.z = 0
				var_322_12.localEulerAngles.x = 0
				var_322_12.localEulerAngles = var_322_12.localEulerAngles
			end

			if arg_319_1.time_ >= 4 + var_322_13 and arg_319_1.time_ < 4 + var_322_13 + arg_322_0 then
				var_322_12.localPosition = Vector3.New(0, -0.71, -6)
				var_322_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_12.position).x, (manager.ui.mainCamera.transform.position - var_322_12.position).y, (manager.ui.mainCamera.transform.position - var_322_12.position).z)
				var_322_12.localEulerAngles.z = 0
				var_322_12.localEulerAngles.x = 0
				var_322_12.localEulerAngles = var_322_12.localEulerAngles
			end

			local var_322_14 = arg_319_1.actors_["1072ui_story"]

			if 4 < arg_319_1.time_ and arg_319_1.time_ <= 4 + arg_322_0 and not isNil(var_322_14) and arg_319_1.var_.characterEffect1072ui_story == nil then
				arg_319_1.var_.characterEffect1072ui_story = var_322_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_15 = 0.200000002980232

			if 4 <= arg_319_1.time_ and arg_319_1.time_ < 4 + var_322_15 and not isNil(var_322_14) then
				if arg_319_1.var_.characterEffect1072ui_story and not isNil(var_322_14) then
					arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 4 + var_322_15 and arg_319_1.time_ < 4 + var_322_15 + arg_322_0 and not isNil(var_322_14) and arg_319_1.var_.characterEffect1072ui_story then
				arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 4 < arg_319_1.time_ and arg_319_1.time_ <= 4 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 4 < arg_319_1.time_ and arg_319_1.time_ <= 4 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_17 = 4
			local var_322_18 = 0.35

			if 4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_17 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_19 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_19:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_20 = arg_319_1:GetWordFromCfg(221051078)
				local var_322_21 = arg_319_1:FormatText(var_322_20.content)

				arg_319_1.text_.text = var_322_21

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_23 = 14 <= 0 and var_322_18 or var_322_18 * (utf8.len(var_322_21) / 14)

				if (14 <= 0 and var_322_18 or var_322_18 * (utf8.len(var_322_21) / 14)) > 0 and var_322_18 < var_322_23 then
					arg_319_1.talkMaxDuration = var_322_23
					var_322_17 = var_322_17 + 0.3

					if var_322_23 + var_322_17 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_17
					end
				end

				arg_319_1.text_.text = var_322_21
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051078", "story_v_out_221051.awb") ~= 0 then
					local var_322_24 = manager.audio:GetVoiceLength("story_v_out_221051", "221051078", "story_v_out_221051.awb") / 1000

					if var_322_24 + var_322_17 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_17
					end

					if var_322_20.prefab_name ~= "" and arg_319_1.actors_[var_322_20.prefab_name] ~= nil then
						local var_322_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_20.prefab_name].transform, "story_v_out_221051", "221051078", "story_v_out_221051.awb")

						arg_319_1:RecordAudio("221051078", var_322_25)
						arg_319_1:RecordAudio("221051078", var_322_25)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_221051", "221051078", "story_v_out_221051.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_221051", "221051078", "story_v_out_221051.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_26 = var_322_17 + 0.3
			local var_322_27 = math.max(var_322_18, arg_319_1.talkMaxDuration)

			if var_322_17 + 0.3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_26 + var_322_27 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_26) / var_322_27

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_26 + var_322_27 and arg_319_1.time_ < var_322_26 + var_322_27 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play221051079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 221051079
		arg_325_1.duration_ = 20

		local var_325_0 = {
			ja = 20,
			ko = 15.233,
			zh = 15.233
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
				arg_325_0:Play221051080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1072ui_story"]) and arg_325_1.var_.characterEffect1072ui_story == nil then
				arg_325_1.var_.characterEffect1072ui_story = arg_325_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1072ui_story"]) then
				if arg_325_1.var_.characterEffect1072ui_story and not isNil(arg_325_1.actors_["1072ui_story"]) then
					arg_325_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1072ui_story"]) and arg_325_1.var_.characterEffect1072ui_story then
				arg_325_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 1.175

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(221051079)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 47 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_4) / 47)

				if (47 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_4) / 47)) > 0 and var_328_2 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051079", "story_v_out_221051.awb") ~= 0 then
					local var_328_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051079", "story_v_out_221051.awb") / 1000

					if var_328_7 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_1
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_221051", "221051079", "story_v_out_221051.awb")

						arg_325_1:RecordAudio("221051079", var_328_8)
						arg_325_1:RecordAudio("221051079", var_328_8)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_221051", "221051079", "story_v_out_221051.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_221051", "221051079", "story_v_out_221051.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_9 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_9 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_9

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_9 and arg_325_1.time_ < var_328_1 + var_328_9 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play221051080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 221051080
		arg_329_1.duration_ = 2.8

		local var_329_0 = {
			ja = 2.8,
			ko = 2.5,
			zh = 2.5
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play221051081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1072ui_story = arg_329_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).z)
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles = arg_329_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_329_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).z)
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles = arg_329_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1072ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1072ui_story == nil then
				arg_329_1.var_.characterEffect1072ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1072ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1072ui_story then
				arg_329_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_332_4 = 0
			local var_332_5 = 0.25

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(221051080)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 10 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 10)

				if (10 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 10)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051080", "story_v_out_221051.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051080", "story_v_out_221051.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_out_221051", "221051080", "story_v_out_221051.awb")

						arg_329_1:RecordAudio("221051080", var_332_11)
						arg_329_1:RecordAudio("221051080", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_221051", "221051080", "story_v_out_221051.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_221051", "221051080", "story_v_out_221051.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play221051081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 221051081
		arg_333_1.duration_ = 9.53

		local var_333_0 = {
			ja = 9.533,
			ko = 3.933,
			zh = 3.933
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play221051082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1072ui_story = arg_333_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).z)
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles = arg_333_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_333_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).z)
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles = arg_333_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_336_1 = 0
			local var_336_2 = 0.575

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:GetWordFromCfg(221051081)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_6 = 23 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_4) / 23)

				if (23 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_4) / 23)) > 0 and var_336_2 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051081", "story_v_out_221051.awb") ~= 0 then
					local var_336_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051081", "story_v_out_221051.awb") / 1000

					if var_336_7 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_1
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_221051", "221051081", "story_v_out_221051.awb")

						arg_333_1:RecordAudio("221051081", var_336_8)
						arg_333_1:RecordAudio("221051081", var_336_8)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_221051", "221051081", "story_v_out_221051.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_221051", "221051081", "story_v_out_221051.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_9 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_9 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_9

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_9 and arg_333_1.time_ < var_336_1 + var_336_9 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play221051082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 221051082
		arg_337_1.duration_ = 1.73

		local var_337_0 = {
			ja = 1.333,
			ko = 1.733,
			zh = 1.733
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
				arg_337_0:Play221051083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1072ui_story"]) and arg_337_1.var_.characterEffect1072ui_story == nil then
				arg_337_1.var_.characterEffect1072ui_story = arg_337_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1072ui_story"]) then
				if arg_337_1.var_.characterEffect1072ui_story and not isNil(arg_337_1.actors_["1072ui_story"]) then
					arg_337_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1072ui_story"]) and arg_337_1.var_.characterEffect1072ui_story then
				arg_337_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.05

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(221051082)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_6 = 2 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_4) / 2)

				if (2 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_4) / 2)) > 0 and var_340_2 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051082", "story_v_out_221051.awb") ~= 0 then
					local var_340_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051082", "story_v_out_221051.awb") / 1000

					if var_340_7 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_1
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_221051", "221051082", "story_v_out_221051.awb")

						arg_337_1:RecordAudio("221051082", var_340_8)
						arg_337_1:RecordAudio("221051082", var_340_8)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_221051", "221051082", "story_v_out_221051.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_221051", "221051082", "story_v_out_221051.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_9 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_9 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_9

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_9 and arg_337_1.time_ < var_340_1 + var_340_9 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play221051083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 221051083
		arg_341_1.duration_ = 24.07

		local var_341_0 = {
			ja = 24.066,
			ko = 15.7,
			zh = 15.7
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
				arg_341_0:Play221051084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.6

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_1 = arg_341_1:GetWordFromCfg(221051083)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 63 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 63)

				if (63 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 63)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051083", "story_v_out_221051.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051083", "story_v_out_221051.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_221051", "221051083", "story_v_out_221051.awb")

						arg_341_1:RecordAudio("221051083", var_344_6)
						arg_341_1:RecordAudio("221051083", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_221051", "221051083", "story_v_out_221051.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_221051", "221051083", "story_v_out_221051.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play221051084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 221051084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play221051085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1072ui_story = arg_345_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1072ui_story"].transform.position).z)
				arg_345_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1072ui_story"].transform.localEulerAngles = arg_345_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1072ui_story"].transform.position).z)
				arg_345_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1072ui_story"].transform.localEulerAngles = arg_345_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1072ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1072ui_story == nil then
				arg_345_1.var_.characterEffect1072ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1072ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_2)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1072ui_story then
				arg_345_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_348_3 = 0
			local var_348_4 = 1.3

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_5 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(221051084).content)

				arg_345_1.text_.text = var_348_5

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 52 <= 0 and var_348_4 or var_348_4 * (utf8.len(var_348_5) / 52)

				if (52 <= 0 and var_348_4 or var_348_4 * (utf8.len(var_348_5) / 52)) > 0 and var_348_4 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_3 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_3
					end
				end

				arg_345_1.text_.text = var_348_5
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_8 = math.max(var_348_4, arg_345_1.talkMaxDuration)

			if var_348_3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_3 + var_348_8 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_3) / var_348_8

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_3 + var_348_8 and arg_345_1.time_ < var_348_3 + var_348_8 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play221051085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 221051085
		arg_349_1.duration_ = 5.47

		local var_349_0 = {
			ja = 5.466,
			ko = 3.033,
			zh = 3.033
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
				arg_349_0:Play221051086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1072ui_story = arg_349_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1072ui_story"].transform.position).z)
				arg_349_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1072ui_story"].transform.localEulerAngles = arg_349_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_349_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1072ui_story"].transform.position).z)
				arg_349_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1072ui_story"].transform.localEulerAngles = arg_349_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1072ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1072ui_story == nil then
				arg_349_1.var_.characterEffect1072ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1072ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1072ui_story then
				arg_349_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_4 = 0
			local var_352_5 = 0.35

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(221051085)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 14 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 14)

				if (14 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 14)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051085", "story_v_out_221051.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051085", "story_v_out_221051.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_out_221051", "221051085", "story_v_out_221051.awb")

						arg_349_1:RecordAudio("221051085", var_352_11)
						arg_349_1:RecordAudio("221051085", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_221051", "221051085", "story_v_out_221051.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_221051", "221051085", "story_v_out_221051.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play221051086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 221051086
		arg_353_1.duration_ = 5.67

		local var_353_0 = {
			ja = 5.666,
			ko = 2.533,
			zh = 2.533
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
				arg_353_0:Play221051087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1072ui_story"]) and arg_353_1.var_.characterEffect1072ui_story == nil then
				arg_353_1.var_.characterEffect1072ui_story = arg_353_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1072ui_story"]) then
				if arg_353_1.var_.characterEffect1072ui_story and not isNil(arg_353_1.actors_["1072ui_story"]) then
					arg_353_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1072ui_story"]) and arg_353_1.var_.characterEffect1072ui_story then
				arg_353_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(221051086)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_6 = 11 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_4) / 11)

				if (11 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_4) / 11)) > 0 and var_356_2 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051086", "story_v_out_221051.awb") ~= 0 then
					local var_356_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051086", "story_v_out_221051.awb") / 1000

					if var_356_7 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_1
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_out_221051", "221051086", "story_v_out_221051.awb")

						arg_353_1:RecordAudio("221051086", var_356_8)
						arg_353_1:RecordAudio("221051086", var_356_8)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_221051", "221051086", "story_v_out_221051.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_221051", "221051086", "story_v_out_221051.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_9 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_9 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_9

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_9 and arg_353_1.time_ < var_356_1 + var_356_9 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play221051087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 221051087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play221051088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_360_0 = 0
			local var_360_1 = 0.575

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(221051087).content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 23 <= 0 and var_360_1 or var_360_1 * (utf8.len(var_360_2) / 23)

				if (23 <= 0 and var_360_1 or var_360_1 * (utf8.len(var_360_2) / 23)) > 0 and var_360_1 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_5 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_5 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_5

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_5 and arg_357_1.time_ < var_360_0 + var_360_5 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play221051088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 221051088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play221051089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1072ui_story = arg_361_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1072ui_story"].transform.position).z)
				arg_361_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1072ui_story"].transform.localEulerAngles = arg_361_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_361_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1072ui_story"].transform.position).z)
				arg_361_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1072ui_story"].transform.localEulerAngles = arg_361_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_364_1 = 0
			local var_364_2 = 0.275

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(221051088).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 11 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 11)

				if (11 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 11)) > 0 and var_364_2 < var_364_5 then
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

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play221051089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 221051089
		arg_365_1.duration_ = 5.47

		local var_365_0 = {
			ja = 5.466,
			ko = 3,
			zh = 3
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
				arg_365_0:Play221051090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1072ui_story = arg_365_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1072ui_story"].transform.position).z)
				arg_365_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1072ui_story"].transform.localEulerAngles = arg_365_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_365_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1072ui_story"].transform.position).z)
				arg_365_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1072ui_story"].transform.localEulerAngles = arg_365_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1072ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1072ui_story == nil then
				arg_365_1.var_.characterEffect1072ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1072ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1072ui_story then
				arg_365_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_368_4 = 0
			local var_368_5 = 0.225

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(221051089)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 9 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 9)

				if (9 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 9)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051089", "story_v_out_221051.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051089", "story_v_out_221051.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_out_221051", "221051089", "story_v_out_221051.awb")

						arg_365_1:RecordAudio("221051089", var_368_11)
						arg_365_1:RecordAudio("221051089", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_221051", "221051089", "story_v_out_221051.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_221051", "221051089", "story_v_out_221051.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play221051090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 221051090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play221051091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1072ui_story = arg_369_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1072ui_story"].transform.position).z)
				arg_369_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1072ui_story"].transform.localEulerAngles = arg_369_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1072ui_story"].transform.position).z)
				arg_369_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1072ui_story"].transform.localEulerAngles = arg_369_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1072ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1072ui_story == nil then
				arg_369_1.var_.characterEffect1072ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1072ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_2)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1072ui_story then
				arg_369_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_372_3 = 0
			local var_372_4 = 1.225

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_3 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_5 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(221051090).content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 49 <= 0 and var_372_4 or var_372_4 * (utf8.len(var_372_5) / 49)

				if (49 <= 0 and var_372_4 or var_372_4 * (utf8.len(var_372_5) / 49)) > 0 and var_372_4 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_3 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_3
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_8 = math.max(var_372_4, arg_369_1.talkMaxDuration)

			if var_372_3 <= arg_369_1.time_ and arg_369_1.time_ < var_372_3 + var_372_8 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_3) / var_372_8

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_3 + var_372_8 and arg_369_1.time_ < var_372_3 + var_372_8 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play221051091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 221051091
		arg_373_1.duration_ = 1.5

		local var_373_0 = {
			ja = 1.5,
			ko = 1.2,
			zh = 1.2
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
				arg_373_0:Play221051092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.05

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(221051091)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 2 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 2)

				if (2 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 2)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051091", "story_v_out_221051.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051091", "story_v_out_221051.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_out_221051", "221051091", "story_v_out_221051.awb")

						arg_373_1:RecordAudio("221051091", var_376_6)
						arg_373_1:RecordAudio("221051091", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_221051", "221051091", "story_v_out_221051.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_221051", "221051091", "story_v_out_221051.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play221051092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 221051092
		arg_377_1.duration_ = 2.5

		local var_377_0 = {
			ja = 1.766,
			ko = 2.5,
			zh = 2.5
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
				arg_377_0:Play221051093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.125

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:GetWordFromCfg(221051092)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 5 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 5)

				if (5 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 5)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051092", "story_v_out_221051.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051092", "story_v_out_221051.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_221051", "221051092", "story_v_out_221051.awb")

						arg_377_1:RecordAudio("221051092", var_380_6)
						arg_377_1:RecordAudio("221051092", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_221051", "221051092", "story_v_out_221051.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_221051", "221051092", "story_v_out_221051.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play221051093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 221051093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play221051094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.65

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(221051093).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 26 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 26)

				if (26 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 26)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play221051094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 221051094
		arg_385_1.duration_ = 5.5

		local var_385_0 = {
			ja = 5.5,
			ko = 5.333,
			zh = 5.333
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
				arg_385_0:Play221051095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1072ui_story = arg_385_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1072ui_story"].transform.position).z)
				arg_385_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1072ui_story"].transform.localEulerAngles = arg_385_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_385_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1072ui_story"].transform.position).z)
				arg_385_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1072ui_story"].transform.localEulerAngles = arg_385_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1072ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1072ui_story == nil then
				arg_385_1.var_.characterEffect1072ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1072ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1072ui_story then
				arg_385_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_388_4 = 0
			local var_388_5 = 0.5

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(221051094)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 20 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 20)

				if (20 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 20)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051094", "story_v_out_221051.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051094", "story_v_out_221051.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_out_221051", "221051094", "story_v_out_221051.awb")

						arg_385_1:RecordAudio("221051094", var_388_11)
						arg_385_1:RecordAudio("221051094", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_221051", "221051094", "story_v_out_221051.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_221051", "221051094", "story_v_out_221051.awb")
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
				actorName = "1072ui_story",
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
	Play221051095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 221051095
		arg_389_1.duration_ = 14.83

		local var_389_0 = {
			ja = 14.833,
			ko = 8.6,
			zh = 8.6
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play221051096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1072ui_story"]) and arg_389_1.var_.characterEffect1072ui_story == nil then
				arg_389_1.var_.characterEffect1072ui_story = arg_389_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1072ui_story"]) then
				if arg_389_1.var_.characterEffect1072ui_story and not isNil(arg_389_1.actors_["1072ui_story"]) then
					arg_389_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1072ui_story"]) and arg_389_1.var_.characterEffect1072ui_story then
				arg_389_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 0.975

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[428].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(221051095)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_6 = 39 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_4) / 39)

				if (39 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_4) / 39)) > 0 and var_392_2 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051095", "story_v_out_221051.awb") ~= 0 then
					local var_392_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051095", "story_v_out_221051.awb") / 1000

					if var_392_7 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_1
					end

					if var_392_3.prefab_name ~= "" and arg_389_1.actors_[var_392_3.prefab_name] ~= nil then
						local var_392_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_3.prefab_name].transform, "story_v_out_221051", "221051095", "story_v_out_221051.awb")

						arg_389_1:RecordAudio("221051095", var_392_8)
						arg_389_1:RecordAudio("221051095", var_392_8)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_221051", "221051095", "story_v_out_221051.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_221051", "221051095", "story_v_out_221051.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_9 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_9 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_9

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_9 and arg_389_1.time_ < var_392_1 + var_392_9 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play221051096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 221051096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play221051097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.1

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(221051096).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 44 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 44)

				if (44 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 44)) > 0 and var_396_0 < var_396_3 then
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
	Play221051097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 221051097
		arg_397_1.duration_ = 2.13

		local var_397_0 = {
			ja = 2.1,
			ko = 2.133,
			zh = 2.133
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play221051098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1072ui_story = arg_397_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_400_0 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 then
				arg_397_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_397_1.time_ - 0) / var_400_0)
				arg_397_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1072ui_story"].transform.position).z)
				arg_397_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1072ui_story"].transform.localEulerAngles = arg_397_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 then
				arg_397_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_397_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1072ui_story"].transform.position).z)
				arg_397_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1072ui_story"].transform.localEulerAngles = arg_397_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_400_1 = arg_397_1.actors_["1072ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1072ui_story == nil then
				arg_397_1.var_.characterEffect1072ui_story = var_400_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 and not isNil(var_400_1) then
				if arg_397_1.var_.characterEffect1072ui_story and not isNil(var_400_1) then
					arg_397_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1072ui_story then
				arg_397_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_4 = 0
			local var_400_5 = 0.275

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_6 = arg_397_1:GetWordFromCfg(221051097)
				local var_400_7 = arg_397_1:FormatText(var_400_6.content)

				arg_397_1.text_.text = var_400_7

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_9 = 11 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 11)

				if (11 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 11)) > 0 and var_400_5 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9

					if var_400_9 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_4
					end
				end

				arg_397_1.text_.text = var_400_7
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051097", "story_v_out_221051.awb") ~= 0 then
					local var_400_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051097", "story_v_out_221051.awb") / 1000

					if var_400_10 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_4
					end

					if var_400_6.prefab_name ~= "" and arg_397_1.actors_[var_400_6.prefab_name] ~= nil then
						local var_400_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_6.prefab_name].transform, "story_v_out_221051", "221051097", "story_v_out_221051.awb")

						arg_397_1:RecordAudio("221051097", var_400_11)
						arg_397_1:RecordAudio("221051097", var_400_11)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_221051", "221051097", "story_v_out_221051.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_221051", "221051097", "story_v_out_221051.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_12 = math.max(var_400_5, arg_397_1.talkMaxDuration)

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_12 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_4) / var_400_12

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_4 + var_400_12 and arg_397_1.time_ < var_400_4 + var_400_12 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
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

		arg_397_1:InitPlayNodeList()
	end,
	Play221051098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 221051098
		arg_401_1.duration_ = 5.83

		local var_401_0 = {
			ja = 5.833,
			ko = 5.2,
			zh = 5.2
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play221051099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.55

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(221051098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 22 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 22)

				if (22 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 22)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051098", "story_v_out_221051.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051098", "story_v_out_221051.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_221051", "221051098", "story_v_out_221051.awb")

						arg_401_1:RecordAudio("221051098", var_404_6)
						arg_401_1:RecordAudio("221051098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_221051", "221051098", "story_v_out_221051.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_221051", "221051098", "story_v_out_221051.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play221051099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 221051099
		arg_405_1.duration_ = 2.5

		local var_405_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_405_0:Play221051100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1076ui_story = arg_405_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1076ui_story"].transform.position).z)
				arg_405_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1076ui_story"].transform.localEulerAngles = arg_405_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_405_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1076ui_story"].transform.position).z)
				arg_405_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1076ui_story"].transform.localEulerAngles = arg_405_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1076ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1076ui_story == nil then
				arg_405_1.var_.characterEffect1076ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1076ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1076ui_story then
				arg_405_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_408_4 = arg_405_1.actors_["1072ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect1072ui_story == nil then
				arg_405_1.var_.characterEffect1072ui_story = var_408_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_5 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_5 and not isNil(var_408_4) then
				if arg_405_1.var_.characterEffect1072ui_story and not isNil(var_408_4) then
					arg_405_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_5)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_5 and arg_405_1.time_ < 0 + var_408_5 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect1072ui_story then
				arg_405_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_408_6 = 0
			local var_408_7 = 0.1

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_8 = arg_405_1:GetWordFromCfg(221051099)
				local var_408_9 = arg_405_1:FormatText(var_408_8.content)

				arg_405_1.text_.text = var_408_9

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 4 <= 0 and var_408_7 or var_408_7 * (utf8.len(var_408_9) / 4)

				if (4 <= 0 and var_408_7 or var_408_7 * (utf8.len(var_408_9) / 4)) > 0 and var_408_7 < var_408_11 then
					arg_405_1.talkMaxDuration = var_408_11

					if var_408_11 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_11 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_9
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051099", "story_v_out_221051.awb") ~= 0 then
					local var_408_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051099", "story_v_out_221051.awb") / 1000

					if var_408_12 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_12 + var_408_6
					end

					if var_408_8.prefab_name ~= "" and arg_405_1.actors_[var_408_8.prefab_name] ~= nil then
						local var_408_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_8.prefab_name].transform, "story_v_out_221051", "221051099", "story_v_out_221051.awb")

						arg_405_1:RecordAudio("221051099", var_408_13)
						arg_405_1:RecordAudio("221051099", var_408_13)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_221051", "221051099", "story_v_out_221051.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_221051", "221051099", "story_v_out_221051.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play221051100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 221051100
		arg_409_1.duration_ = 7

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play221051101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if arg_409_1.bgs_.STblack == nil then
				local var_412_0 = Object.Instantiate(arg_409_1.paintGo_)

				var_412_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_412_0.name = "STblack"
				var_412_0.transform.parent = arg_409_1.stage_.transform
				var_412_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.bgs_.STblack = var_412_0
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				local var_412_1 = arg_409_1.bgs_.STblack

				arg_409_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_412_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_412_2 = var_412_1:GetComponent("SpriteRenderer")

				if var_412_2 and var_412_2.sprite then
					local var_412_3 = 2 * (var_412_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_412_1.transform.localScale = Vector3.New(var_412_3 / var_412_2.sprite.bounds.size.y < var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x and var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x or var_412_3 / var_412_2.sprite.bounds.size.y, var_412_3 / var_412_2.sprite.bounds.size.y < var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x and var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x or var_412_3 / var_412_2.sprite.bounds.size.y, 0)
				end

				for iter_412_0, iter_412_1 in pairs(arg_409_1.bgs_) do
					if iter_412_0 ~= "STblack" then
						iter_412_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_412_4 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_5 = 2

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_5 then
				local var_412_6 = Color.New(0, 0, 0)

				var_412_6.a = Mathf.Lerp(1, 0, (arg_409_1.time_ - var_412_4) / var_412_5)
				arg_409_1.mask_.color = var_412_6
			end

			if arg_409_1.time_ >= var_412_4 + var_412_5 and arg_409_1.time_ < var_412_4 + var_412_5 + arg_412_0 then
				local var_412_7 = Color.New(0, 0, 0)

				arg_409_1.mask_.enabled = false
				var_412_7.a = 0
				arg_409_1.mask_.color = var_412_7
			end

			local var_412_8 = arg_409_1.actors_["1072ui_story"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1072ui_story = var_412_8.localPosition
			end

			local var_412_9 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_9 then
				var_412_8.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_9)
				var_412_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_8.position).x, (manager.ui.mainCamera.transform.position - var_412_8.position).y, (manager.ui.mainCamera.transform.position - var_412_8.position).z)
				var_412_8.localEulerAngles.z = 0
				var_412_8.localEulerAngles.x = 0
				var_412_8.localEulerAngles = var_412_8.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_9 and arg_409_1.time_ < 0 + var_412_9 + arg_412_0 then
				var_412_8.localPosition = Vector3.New(0, 100, 0)
				var_412_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_8.position).x, (manager.ui.mainCamera.transform.position - var_412_8.position).y, (manager.ui.mainCamera.transform.position - var_412_8.position).z)
				var_412_8.localEulerAngles.z = 0
				var_412_8.localEulerAngles.x = 0
				var_412_8.localEulerAngles = var_412_8.localEulerAngles
			end

			local var_412_10 = arg_409_1.actors_["1072ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_10) and arg_409_1.var_.characterEffect1072ui_story == nil then
				arg_409_1.var_.characterEffect1072ui_story = var_412_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_11 and not isNil(var_412_10) then
				if arg_409_1.var_.characterEffect1072ui_story and not isNil(var_412_10) then
					arg_409_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_11)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_11 and arg_409_1.time_ < 0 + var_412_11 + arg_412_0 and not isNil(var_412_10) and arg_409_1.var_.characterEffect1072ui_story then
				arg_409_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_412_12 = arg_409_1.actors_["1076ui_story"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1076ui_story = var_412_12.localPosition
			end

			local var_412_13 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_13 then
				var_412_12.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_13)
				var_412_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_12.position).x, (manager.ui.mainCamera.transform.position - var_412_12.position).y, (manager.ui.mainCamera.transform.position - var_412_12.position).z)
				var_412_12.localEulerAngles.z = 0
				var_412_12.localEulerAngles.x = 0
				var_412_12.localEulerAngles = var_412_12.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_13 and arg_409_1.time_ < 0 + var_412_13 + arg_412_0 then
				var_412_12.localPosition = Vector3.New(0, 100, 0)
				var_412_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_12.position).x, (manager.ui.mainCamera.transform.position - var_412_12.position).y, (manager.ui.mainCamera.transform.position - var_412_12.position).z)
				var_412_12.localEulerAngles.z = 0
				var_412_12.localEulerAngles.x = 0
				var_412_12.localEulerAngles = var_412_12.localEulerAngles
			end

			local var_412_14 = arg_409_1.actors_["1076ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_14) and arg_409_1.var_.characterEffect1076ui_story == nil then
				arg_409_1.var_.characterEffect1076ui_story = var_412_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_15 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_15 and not isNil(var_412_14) then
				if arg_409_1.var_.characterEffect1076ui_story and not isNil(var_412_14) then
					arg_409_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_15)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_15 and arg_409_1.time_ < 0 + var_412_15 + arg_412_0 and not isNil(var_412_14) and arg_409_1.var_.characterEffect1076ui_story then
				arg_409_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_16 = 2
			local var_412_17 = 0.575

			if 2 < arg_409_1.time_ and arg_409_1.time_ <= var_412_16 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_18 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_18:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_19 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(221051100).content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_21 = 23 <= 0 and var_412_17 or var_412_17 * (utf8.len(var_412_19) / 23)

				if (23 <= 0 and var_412_17 or var_412_17 * (utf8.len(var_412_19) / 23)) > 0 and var_412_17 < var_412_21 then
					arg_409_1.talkMaxDuration = var_412_21
					var_412_16 = var_412_16 + 0.3

					if var_412_21 + var_412_16 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_21 + var_412_16
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_22 = var_412_16 + 0.3
			local var_412_23 = math.max(var_412_17, arg_409_1.talkMaxDuration)

			if var_412_16 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_22 + var_412_23 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_22) / var_412_23

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_22 + var_412_23 and arg_409_1.time_ < var_412_22 + var_412_23 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play221051101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 221051101
		arg_415_1.duration_ = 8.97

		local var_415_0 = {
			ja = 8.966,
			ko = 7.866,
			zh = 7.866
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play221051102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				local var_418_0 = arg_415_1.bgs_.ST31

				arg_415_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_418_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_1 = var_418_0:GetComponent("SpriteRenderer")

				if var_418_1 and var_418_1.sprite then
					local var_418_2 = 2 * (var_418_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_418_0.transform.localScale = Vector3.New(var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "ST31" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_3 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_4 = 2

			if var_418_3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_3 + var_418_4 then
				local var_418_5 = Color.New(0, 0, 0)

				var_418_5.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_3) / var_418_4)
				arg_415_1.mask_.color = var_418_5
			end

			if arg_415_1.time_ >= var_418_3 + var_418_4 and arg_415_1.time_ < var_418_3 + var_418_4 + arg_418_0 then
				local var_418_6 = Color.New(0, 0, 0)

				arg_415_1.mask_.enabled = false
				var_418_6.a = 0
				arg_415_1.mask_.color = var_418_6
			end

			local var_418_7 = arg_415_1.actors_["1072ui_story"].transform

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 then
				arg_415_1.var_.moveOldPos1072ui_story = var_418_7.localPosition
			end

			local var_418_8 = 0.001

			if 2 <= arg_415_1.time_ and arg_415_1.time_ < 2 + var_418_8 then
				var_418_7.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_415_1.time_ - 2) / var_418_8)
				var_418_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_7.position).x, (manager.ui.mainCamera.transform.position - var_418_7.position).y, (manager.ui.mainCamera.transform.position - var_418_7.position).z)
				var_418_7.localEulerAngles.z = 0
				var_418_7.localEulerAngles.x = 0
				var_418_7.localEulerAngles = var_418_7.localEulerAngles
			end

			if arg_415_1.time_ >= 2 + var_418_8 and arg_415_1.time_ < 2 + var_418_8 + arg_418_0 then
				var_418_7.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_418_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_7.position).x, (manager.ui.mainCamera.transform.position - var_418_7.position).y, (manager.ui.mainCamera.transform.position - var_418_7.position).z)
				var_418_7.localEulerAngles.z = 0
				var_418_7.localEulerAngles.x = 0
				var_418_7.localEulerAngles = var_418_7.localEulerAngles
			end

			local var_418_9 = arg_415_1.actors_["1072ui_story"]

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 and not isNil(var_418_9) and arg_415_1.var_.characterEffect1072ui_story == nil then
				arg_415_1.var_.characterEffect1072ui_story = var_418_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_10 = 0.200000002980232

			if 2 <= arg_415_1.time_ and arg_415_1.time_ < 2 + var_418_10 and not isNil(var_418_9) then
				if arg_415_1.var_.characterEffect1072ui_story and not isNil(var_418_9) then
					arg_415_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 2 + var_418_10 and arg_415_1.time_ < 2 + var_418_10 + arg_418_0 and not isNil(var_418_9) and arg_415_1.var_.characterEffect1072ui_story then
				arg_415_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 then
				arg_415_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 then
				arg_415_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_418_12 = arg_415_1.actors_["1076ui_story"].transform

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 then
				arg_415_1.var_.moveOldPos1076ui_story = var_418_12.localPosition
			end

			local var_418_13 = 0.001

			if 2 <= arg_415_1.time_ and arg_415_1.time_ < 2 + var_418_13 then
				var_418_12.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_415_1.time_ - 2) / var_418_13)
				var_418_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_12.position).x, (manager.ui.mainCamera.transform.position - var_418_12.position).y, (manager.ui.mainCamera.transform.position - var_418_12.position).z)
				var_418_12.localEulerAngles.z = 0
				var_418_12.localEulerAngles.x = 0
				var_418_12.localEulerAngles = var_418_12.localEulerAngles
			end

			if arg_415_1.time_ >= 2 + var_418_13 and arg_415_1.time_ < 2 + var_418_13 + arg_418_0 then
				var_418_12.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_418_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_12.position).x, (manager.ui.mainCamera.transform.position - var_418_12.position).y, (manager.ui.mainCamera.transform.position - var_418_12.position).z)
				var_418_12.localEulerAngles.z = 0
				var_418_12.localEulerAngles.x = 0
				var_418_12.localEulerAngles = var_418_12.localEulerAngles
			end

			local var_418_14 = arg_415_1.actors_["1076ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_14) and arg_415_1.var_.characterEffect1076ui_story == nil then
				arg_415_1.var_.characterEffect1076ui_story = var_418_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_15 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_15 and not isNil(var_418_14) then
				if arg_415_1.var_.characterEffect1076ui_story and not isNil(var_418_14) then
					arg_415_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_15)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_15 and arg_415_1.time_ < 0 + var_418_15 + arg_418_0 and not isNil(var_418_14) and arg_415_1.var_.characterEffect1076ui_story then
				arg_415_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 then
				arg_415_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_16 = 2
			local var_418_17 = 0.725

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_18 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_18:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_19 = arg_415_1:GetWordFromCfg(221051101)
				local var_418_20 = arg_415_1:FormatText(var_418_19.content)

				arg_415_1.text_.text = var_418_20

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_22 = 29 <= 0 and var_418_17 or var_418_17 * (utf8.len(var_418_20) / 29)

				if (29 <= 0 and var_418_17 or var_418_17 * (utf8.len(var_418_20) / 29)) > 0 and var_418_17 < var_418_22 then
					arg_415_1.talkMaxDuration = var_418_22
					var_418_16 = var_418_16 + 0.3

					if var_418_22 + var_418_16 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_22 + var_418_16
					end
				end

				arg_415_1.text_.text = var_418_20
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051101", "story_v_out_221051.awb") ~= 0 then
					local var_418_23 = manager.audio:GetVoiceLength("story_v_out_221051", "221051101", "story_v_out_221051.awb") / 1000

					if var_418_23 + var_418_16 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_23 + var_418_16
					end

					if var_418_19.prefab_name ~= "" and arg_415_1.actors_[var_418_19.prefab_name] ~= nil then
						local var_418_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_19.prefab_name].transform, "story_v_out_221051", "221051101", "story_v_out_221051.awb")

						arg_415_1:RecordAudio("221051101", var_418_24)
						arg_415_1:RecordAudio("221051101", var_418_24)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_221051", "221051101", "story_v_out_221051.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_221051", "221051101", "story_v_out_221051.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_25 = var_418_16 + 0.3
			local var_418_26 = math.max(var_418_17, arg_415_1.talkMaxDuration)

			if var_418_16 + 0.3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_25 + var_418_26 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_25) / var_418_26

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_25 + var_418_26 and arg_415_1.time_ < var_418_25 + var_418_26 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play221051102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 221051102
		arg_421_1.duration_ = 2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play221051103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1076ui_story = arg_421_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1076ui_story"].transform.position).z)
				arg_421_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1076ui_story"].transform.localEulerAngles = arg_421_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_421_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1076ui_story"].transform.position).z)
				arg_421_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1076ui_story"].transform.localEulerAngles = arg_421_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1076ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1076ui_story == nil then
				arg_421_1.var_.characterEffect1076ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1076ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1076ui_story then
				arg_421_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_424_4 = arg_421_1.actors_["1072ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect1072ui_story == nil then
				arg_421_1.var_.characterEffect1072ui_story = var_424_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_5 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_5 and not isNil(var_424_4) then
				if arg_421_1.var_.characterEffect1072ui_story and not isNil(var_424_4) then
					arg_421_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_5)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_5 and arg_421_1.time_ < 0 + var_424_5 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect1072ui_story then
				arg_421_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_424_6 = 0
			local var_424_7 = 0.05

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_8 = arg_421_1:GetWordFromCfg(221051102)
				local var_424_9 = arg_421_1:FormatText(var_424_8.content)

				arg_421_1.text_.text = var_424_9

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 2 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_9) / 2)

				if (2 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_9) / 2)) > 0 and var_424_7 < var_424_11 then
					arg_421_1.talkMaxDuration = var_424_11

					if var_424_11 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_11 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_9
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051102", "story_v_out_221051.awb") ~= 0 then
					local var_424_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051102", "story_v_out_221051.awb") / 1000

					if var_424_12 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_12 + var_424_6
					end

					if var_424_8.prefab_name ~= "" and arg_421_1.actors_[var_424_8.prefab_name] ~= nil then
						local var_424_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_8.prefab_name].transform, "story_v_out_221051", "221051102", "story_v_out_221051.awb")

						arg_421_1:RecordAudio("221051102", var_424_13)
						arg_421_1:RecordAudio("221051102", var_424_13)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_221051", "221051102", "story_v_out_221051.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_221051", "221051102", "story_v_out_221051.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_14 = math.max(var_424_7, arg_421_1.talkMaxDuration)

			if var_424_6 <= arg_421_1.time_ and arg_421_1.time_ < var_424_6 + var_424_14 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_6) / var_424_14

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_6 + var_424_14 and arg_421_1.time_ < var_424_6 + var_424_14 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	Play221051103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 221051103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play221051104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1072ui_story = arg_425_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1072ui_story"].transform.position).z)
				arg_425_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1072ui_story"].transform.localEulerAngles = arg_425_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_425_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1072ui_story"].transform.position).z)
				arg_425_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1072ui_story"].transform.localEulerAngles = arg_425_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1072ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1072ui_story == nil then
				arg_425_1.var_.characterEffect1072ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1072ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_2)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1072ui_story then
				arg_425_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_428_3 = arg_425_1.actors_["1076ui_story"].transform

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1076ui_story = var_428_3.localPosition
			end

			local var_428_4 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				var_428_3.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_4)
				var_428_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_428_3.position).x, (manager.ui.mainCamera.transform.position - var_428_3.position).y, (manager.ui.mainCamera.transform.position - var_428_3.position).z)
				var_428_3.localEulerAngles.z = 0
				var_428_3.localEulerAngles.x = 0
				var_428_3.localEulerAngles = var_428_3.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				var_428_3.localPosition = Vector3.New(0, 100, 0)
				var_428_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_428_3.position).x, (manager.ui.mainCamera.transform.position - var_428_3.position).y, (manager.ui.mainCamera.transform.position - var_428_3.position).z)
				var_428_3.localEulerAngles.z = 0
				var_428_3.localEulerAngles.x = 0
				var_428_3.localEulerAngles = var_428_3.localEulerAngles
			end

			local var_428_5 = arg_425_1.actors_["1076ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_5) and arg_425_1.var_.characterEffect1076ui_story == nil then
				arg_425_1.var_.characterEffect1076ui_story = var_428_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_6 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_6 and not isNil(var_428_5) then
				if arg_425_1.var_.characterEffect1076ui_story and not isNil(var_428_5) then
					arg_425_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_6)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_6 and arg_425_1.time_ < 0 + var_428_6 + arg_428_0 and not isNil(var_428_5) and arg_425_1.var_.characterEffect1076ui_story then
				arg_425_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_428_7 = 0
			local var_428_8 = 1.025

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_7 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_9 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(221051103).content)

				arg_425_1.text_.text = var_428_9

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 41 <= 0 and var_428_8 or var_428_8 * (utf8.len(var_428_9) / 41)

				if (41 <= 0 and var_428_8 or var_428_8 * (utf8.len(var_428_9) / 41)) > 0 and var_428_8 < var_428_11 then
					arg_425_1.talkMaxDuration = var_428_11

					if var_428_11 + var_428_7 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_11 + var_428_7
					end
				end

				arg_425_1.text_.text = var_428_9
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_12 = math.max(var_428_8, arg_425_1.talkMaxDuration)

			if var_428_7 <= arg_425_1.time_ and arg_425_1.time_ < var_428_7 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_7) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_7 + var_428_12 and arg_425_1.time_ < var_428_7 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play221051104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 221051104
		arg_429_1.duration_ = 6.33

		local var_429_0 = {
			ja = 4.5,
			ko = 6.333,
			zh = 6.333
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
				arg_429_0:Play221051105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1072ui_story = arg_429_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1072ui_story"].transform.position).z)
				arg_429_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1072ui_story"].transform.localEulerAngles = arg_429_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_429_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1072ui_story"].transform.position).z)
				arg_429_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1072ui_story"].transform.localEulerAngles = arg_429_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["1072ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1072ui_story == nil then
				arg_429_1.var_.characterEffect1072ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect1072ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1072ui_story then
				arg_429_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_432_4 = 0
			local var_432_5 = 0.675

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(221051104)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 27 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 27)

				if (27 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 27)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051104", "story_v_out_221051.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051104", "story_v_out_221051.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_out_221051", "221051104", "story_v_out_221051.awb")

						arg_429_1:RecordAudio("221051104", var_432_11)
						arg_429_1:RecordAudio("221051104", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_221051", "221051104", "story_v_out_221051.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_221051", "221051104", "story_v_out_221051.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_5, arg_429_1.talkMaxDuration)

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_4) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_4 + var_432_12 and arg_429_1.time_ < var_432_4 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
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

		arg_429_1:InitPlayNodeList()
	end,
	Play221051105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 221051105
		arg_433_1.duration_ = 16.33

		local var_433_0 = {
			ja = 16.333,
			ko = 13.766,
			zh = 13.766
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
				arg_433_0:Play221051106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1072ui_story = arg_433_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1072ui_story"].transform.position).z)
				arg_433_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1072ui_story"].transform.localEulerAngles = arg_433_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_433_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1072ui_story"].transform.position).z)
				arg_433_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1072ui_story"].transform.localEulerAngles = arg_433_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1072ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1072ui_story == nil then
				arg_433_1.var_.characterEffect1072ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1072ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1072ui_story then
				arg_433_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_436_4 = 0
			local var_436_5 = 1.425

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_6 = arg_433_1:GetWordFromCfg(221051105)
				local var_436_7 = arg_433_1:FormatText(var_436_6.content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 57 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 57)

				if (57 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 57)) > 0 and var_436_5 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_4
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051105", "story_v_out_221051.awb") ~= 0 then
					local var_436_10 = manager.audio:GetVoiceLength("story_v_out_221051", "221051105", "story_v_out_221051.awb") / 1000

					if var_436_10 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_4
					end

					if var_436_6.prefab_name ~= "" and arg_433_1.actors_[var_436_6.prefab_name] ~= nil then
						local var_436_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_6.prefab_name].transform, "story_v_out_221051", "221051105", "story_v_out_221051.awb")

						arg_433_1:RecordAudio("221051105", var_436_11)
						arg_433_1:RecordAudio("221051105", var_436_11)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_221051", "221051105", "story_v_out_221051.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_221051", "221051105", "story_v_out_221051.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_12 = math.max(var_436_5, arg_433_1.talkMaxDuration)

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_12 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_4) / var_436_12

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_4 + var_436_12 and arg_433_1.time_ < var_436_4 + var_436_12 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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

		arg_433_1:InitPlayNodeList()
	end,
	Play221051106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 221051106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play221051107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1072ui_story = arg_437_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1072ui_story"].transform.position).z)
				arg_437_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1072ui_story"].transform.localEulerAngles = arg_437_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_437_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1072ui_story"].transform.position).z)
				arg_437_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1072ui_story"].transform.localEulerAngles = arg_437_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1072ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1072ui_story == nil then
				arg_437_1.var_.characterEffect1072ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1072ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_2)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1072ui_story then
				arg_437_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_440_3 = 0
			local var_440_4 = 0.575

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_3 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_5 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(221051106).content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 23 <= 0 and var_440_4 or var_440_4 * (utf8.len(var_440_5) / 23)

				if (23 <= 0 and var_440_4 or var_440_4 * (utf8.len(var_440_5) / 23)) > 0 and var_440_4 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_3 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_3
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = math.max(var_440_4, arg_437_1.talkMaxDuration)

			if var_440_3 <= arg_437_1.time_ and arg_437_1.time_ < var_440_3 + var_440_8 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_3) / var_440_8

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_3 + var_440_8 and arg_437_1.time_ < var_440_3 + var_440_8 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
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

		arg_437_1:InitPlayNodeList()
	end,
	Play221051107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 221051107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play221051108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.75

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(221051107).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 30 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 30)

				if (30 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 30)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play221051108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 221051108
		arg_445_1.duration_ = 9.27

		local var_445_0 = {
			ja = 9.266,
			ko = 5.866,
			zh = 5.866
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
				arg_445_0:Play221051109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1076ui_story = arg_445_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1076ui_story"].transform.position).z)
				arg_445_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1076ui_story"].transform.localEulerAngles = arg_445_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_445_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1076ui_story"].transform.position).z)
				arg_445_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1076ui_story"].transform.localEulerAngles = arg_445_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["1076ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1076ui_story == nil then
				arg_445_1.var_.characterEffect1076ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 and not isNil(var_448_1) then
				if arg_445_1.var_.characterEffect1076ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1076ui_story then
				arg_445_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_448_4 = arg_445_1.actors_["1072ui_story"].transform

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1072ui_story = var_448_4.localPosition
			end

			local var_448_5 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_5 then
				var_448_4.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_445_1.time_ - 0) / var_448_5)
				var_448_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_448_4.position).x, (manager.ui.mainCamera.transform.position - var_448_4.position).y, (manager.ui.mainCamera.transform.position - var_448_4.position).z)
				var_448_4.localEulerAngles.z = 0
				var_448_4.localEulerAngles.x = 0
				var_448_4.localEulerAngles = var_448_4.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_5 and arg_445_1.time_ < 0 + var_448_5 + arg_448_0 then
				var_448_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_448_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_448_4.position).x, (manager.ui.mainCamera.transform.position - var_448_4.position).y, (manager.ui.mainCamera.transform.position - var_448_4.position).z)
				var_448_4.localEulerAngles.z = 0
				var_448_4.localEulerAngles.x = 0
				var_448_4.localEulerAngles = var_448_4.localEulerAngles
			end

			local var_448_6 = arg_445_1.actors_["1072ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_6) and arg_445_1.var_.characterEffect1072ui_story == nil then
				arg_445_1.var_.characterEffect1072ui_story = var_448_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_7 = 0.0166666666666667

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 and not isNil(var_448_6) then
				if arg_445_1.var_.characterEffect1072ui_story and not isNil(var_448_6) then
					arg_445_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_7)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 and not isNil(var_448_6) and arg_445_1.var_.characterEffect1072ui_story then
				arg_445_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_448_8 = 0
			local var_448_9 = 0.6

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_8 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_10 = arg_445_1:GetWordFromCfg(221051108)
				local var_448_11 = arg_445_1:FormatText(var_448_10.content)

				arg_445_1.text_.text = var_448_11

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_13 = 24 <= 0 and var_448_9 or var_448_9 * (utf8.len(var_448_11) / 24)

				if (24 <= 0 and var_448_9 or var_448_9 * (utf8.len(var_448_11) / 24)) > 0 and var_448_9 < var_448_13 then
					arg_445_1.talkMaxDuration = var_448_13

					if var_448_13 + var_448_8 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_13 + var_448_8
					end
				end

				arg_445_1.text_.text = var_448_11
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051108", "story_v_out_221051.awb") ~= 0 then
					local var_448_14 = manager.audio:GetVoiceLength("story_v_out_221051", "221051108", "story_v_out_221051.awb") / 1000

					if var_448_14 + var_448_8 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_14 + var_448_8
					end

					if var_448_10.prefab_name ~= "" and arg_445_1.actors_[var_448_10.prefab_name] ~= nil then
						local var_448_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_10.prefab_name].transform, "story_v_out_221051", "221051108", "story_v_out_221051.awb")

						arg_445_1:RecordAudio("221051108", var_448_15)
						arg_445_1:RecordAudio("221051108", var_448_15)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_221051", "221051108", "story_v_out_221051.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_221051", "221051108", "story_v_out_221051.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_16 = math.max(var_448_9, arg_445_1.talkMaxDuration)

			if var_448_8 <= arg_445_1.time_ and arg_445_1.time_ < var_448_8 + var_448_16 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_8) / var_448_16

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_8 + var_448_16 and arg_445_1.time_ < var_448_8 + var_448_16 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
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

		arg_445_1:InitPlayNodeList()
	end,
	Play221051109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 221051109
		arg_449_1.duration_ = 7.8

		local var_449_0 = {
			ja = 7.8,
			ko = 5.1,
			zh = 5.1
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
				arg_449_0:Play221051110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1072ui_story = arg_449_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1072ui_story"].transform.position).z)
				arg_449_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1072ui_story"].transform.localEulerAngles = arg_449_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_449_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1072ui_story"].transform.position).z)
				arg_449_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1072ui_story"].transform.localEulerAngles = arg_449_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["1072ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1072ui_story == nil then
				arg_449_1.var_.characterEffect1072ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect1072ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1072ui_story then
				arg_449_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_452_4 = arg_449_1.actors_["1076ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_4) and arg_449_1.var_.characterEffect1076ui_story == nil then
				arg_449_1.var_.characterEffect1076ui_story = var_452_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_5 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_5 and not isNil(var_452_4) then
				if arg_449_1.var_.characterEffect1076ui_story and not isNil(var_452_4) then
					arg_449_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_5)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_5 and arg_449_1.time_ < 0 + var_452_5 + arg_452_0 and not isNil(var_452_4) and arg_449_1.var_.characterEffect1076ui_story then
				arg_449_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_452_6 = 0
			local var_452_7 = 0.525

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_8 = arg_449_1:GetWordFromCfg(221051109)
				local var_452_9 = arg_449_1:FormatText(var_452_8.content)

				arg_449_1.text_.text = var_452_9

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_11 = 21 <= 0 and var_452_7 or var_452_7 * (utf8.len(var_452_9) / 21)

				if (21 <= 0 and var_452_7 or var_452_7 * (utf8.len(var_452_9) / 21)) > 0 and var_452_7 < var_452_11 then
					arg_449_1.talkMaxDuration = var_452_11

					if var_452_11 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_11 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_9
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051109", "story_v_out_221051.awb") ~= 0 then
					local var_452_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051109", "story_v_out_221051.awb") / 1000

					if var_452_12 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_12 + var_452_6
					end

					if var_452_8.prefab_name ~= "" and arg_449_1.actors_[var_452_8.prefab_name] ~= nil then
						local var_452_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_8.prefab_name].transform, "story_v_out_221051", "221051109", "story_v_out_221051.awb")

						arg_449_1:RecordAudio("221051109", var_452_13)
						arg_449_1:RecordAudio("221051109", var_452_13)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_221051", "221051109", "story_v_out_221051.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_221051", "221051109", "story_v_out_221051.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_14 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_14 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_14

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_14 and arg_449_1.time_ < var_452_6 + var_452_14 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
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

		arg_449_1:InitPlayNodeList()
	end,
	Play221051110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 221051110
		arg_453_1.duration_ = 7.17

		local var_453_0 = {
			ja = 7.166,
			ko = 4.566,
			zh = 4.566
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
				arg_453_0:Play221051111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1076ui_story = arg_453_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1076ui_story"].transform.position).z)
				arg_453_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1076ui_story"].transform.localEulerAngles = arg_453_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_453_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1076ui_story"].transform.position).z)
				arg_453_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1076ui_story"].transform.localEulerAngles = arg_453_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1076ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1076ui_story == nil then
				arg_453_1.var_.characterEffect1076ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1076ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1076ui_story then
				arg_453_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_456_4 = arg_453_1.actors_["1072ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_4) and arg_453_1.var_.characterEffect1072ui_story == nil then
				arg_453_1.var_.characterEffect1072ui_story = var_456_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_5 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_5 and not isNil(var_456_4) then
				if arg_453_1.var_.characterEffect1072ui_story and not isNil(var_456_4) then
					arg_453_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_5)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_5 and arg_453_1.time_ < 0 + var_456_5 + arg_456_0 and not isNil(var_456_4) and arg_453_1.var_.characterEffect1072ui_story then
				arg_453_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_456_6 = 0
			local var_456_7 = 0.45

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_6 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_8 = arg_453_1:GetWordFromCfg(221051110)
				local var_456_9 = arg_453_1:FormatText(var_456_8.content)

				arg_453_1.text_.text = var_456_9

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_11 = 18 <= 0 and var_456_7 or var_456_7 * (utf8.len(var_456_9) / 18)

				if (18 <= 0 and var_456_7 or var_456_7 * (utf8.len(var_456_9) / 18)) > 0 and var_456_7 < var_456_11 then
					arg_453_1.talkMaxDuration = var_456_11

					if var_456_11 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_11 + var_456_6
					end
				end

				arg_453_1.text_.text = var_456_9
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051110", "story_v_out_221051.awb") ~= 0 then
					local var_456_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051110", "story_v_out_221051.awb") / 1000

					if var_456_12 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_12 + var_456_6
					end

					if var_456_8.prefab_name ~= "" and arg_453_1.actors_[var_456_8.prefab_name] ~= nil then
						local var_456_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_8.prefab_name].transform, "story_v_out_221051", "221051110", "story_v_out_221051.awb")

						arg_453_1:RecordAudio("221051110", var_456_13)
						arg_453_1:RecordAudio("221051110", var_456_13)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_221051", "221051110", "story_v_out_221051.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_221051", "221051110", "story_v_out_221051.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_14 = math.max(var_456_7, arg_453_1.talkMaxDuration)

			if var_456_6 <= arg_453_1.time_ and arg_453_1.time_ < var_456_6 + var_456_14 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_6) / var_456_14

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_6 + var_456_14 and arg_453_1.time_ < var_456_6 + var_456_14 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play221051111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 221051111
		arg_457_1.duration_ = 9.57

		local var_457_0 = {
			ja = 9.566,
			ko = 5.133,
			zh = 5.133
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
				arg_457_0:Play221051112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1072ui_story = arg_457_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1072ui_story"].transform.position).z)
				arg_457_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1072ui_story"].transform.localEulerAngles = arg_457_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_457_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1072ui_story"].transform.position).z)
				arg_457_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1072ui_story"].transform.localEulerAngles = arg_457_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1072ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1072ui_story == nil then
				arg_457_1.var_.characterEffect1072ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1072ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1072ui_story then
				arg_457_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_460_4 = arg_457_1.actors_["1076ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_4) and arg_457_1.var_.characterEffect1076ui_story == nil then
				arg_457_1.var_.characterEffect1076ui_story = var_460_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_5 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_5 and not isNil(var_460_4) then
				if arg_457_1.var_.characterEffect1076ui_story and not isNil(var_460_4) then
					arg_457_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_5)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_5 and arg_457_1.time_ < 0 + var_460_5 + arg_460_0 and not isNil(var_460_4) and arg_457_1.var_.characterEffect1076ui_story then
				arg_457_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_460_6 = 0
			local var_460_7 = 0.625

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_6 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_8 = arg_457_1:GetWordFromCfg(221051111)
				local var_460_9 = arg_457_1:FormatText(var_460_8.content)

				arg_457_1.text_.text = var_460_9

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_11 = 25 <= 0 and var_460_7 or var_460_7 * (utf8.len(var_460_9) / 25)

				if (25 <= 0 and var_460_7 or var_460_7 * (utf8.len(var_460_9) / 25)) > 0 and var_460_7 < var_460_11 then
					arg_457_1.talkMaxDuration = var_460_11

					if var_460_11 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_11 + var_460_6
					end
				end

				arg_457_1.text_.text = var_460_9
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051111", "story_v_out_221051.awb") ~= 0 then
					local var_460_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051111", "story_v_out_221051.awb") / 1000

					if var_460_12 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_12 + var_460_6
					end

					if var_460_8.prefab_name ~= "" and arg_457_1.actors_[var_460_8.prefab_name] ~= nil then
						local var_460_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_8.prefab_name].transform, "story_v_out_221051", "221051111", "story_v_out_221051.awb")

						arg_457_1:RecordAudio("221051111", var_460_13)
						arg_457_1:RecordAudio("221051111", var_460_13)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_221051", "221051111", "story_v_out_221051.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_221051", "221051111", "story_v_out_221051.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_14 = math.max(var_460_7, arg_457_1.talkMaxDuration)

			if var_460_6 <= arg_457_1.time_ and arg_457_1.time_ < var_460_6 + var_460_14 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_6) / var_460_14

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_6 + var_460_14 and arg_457_1.time_ < var_460_6 + var_460_14 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
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

		arg_457_1:InitPlayNodeList()
	end,
	Play221051112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 221051112
		arg_461_1.duration_ = 7.27

		local var_461_0 = {
			ja = 5.4,
			ko = 7.266,
			zh = 7.266
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play221051113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1072ui_story = arg_461_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1072ui_story"].transform.position).z)
				arg_461_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1072ui_story"].transform.localEulerAngles = arg_461_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_461_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1072ui_story"].transform.position).z)
				arg_461_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1072ui_story"].transform.localEulerAngles = arg_461_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action486")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_464_1 = 0
			local var_464_2 = 0.825

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_3 = arg_461_1:GetWordFromCfg(221051112)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 33 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 33)

				if (33 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 33)) > 0 and var_464_2 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051112", "story_v_out_221051.awb") ~= 0 then
					local var_464_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051112", "story_v_out_221051.awb") / 1000

					if var_464_7 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_1
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_out_221051", "221051112", "story_v_out_221051.awb")

						arg_461_1:RecordAudio("221051112", var_464_8)
						arg_461_1:RecordAudio("221051112", var_464_8)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_221051", "221051112", "story_v_out_221051.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_221051", "221051112", "story_v_out_221051.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_9 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_9 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_9

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_9 and arg_461_1.time_ < var_464_1 + var_464_9 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play221051113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 221051113
		arg_465_1.duration_ = 2.27

		local var_465_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_465_0:Play221051114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1076ui_story = arg_465_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1076ui_story"].transform.position).z)
				arg_465_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1076ui_story"].transform.localEulerAngles = arg_465_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_465_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1076ui_story"].transform.position).z)
				arg_465_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1076ui_story"].transform.localEulerAngles = arg_465_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1076ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1076ui_story == nil then
				arg_465_1.var_.characterEffect1076ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1076ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1076ui_story then
				arg_465_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_468_4 = arg_465_1.actors_["1072ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_4) and arg_465_1.var_.characterEffect1072ui_story == nil then
				arg_465_1.var_.characterEffect1072ui_story = var_468_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_5 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_5 and not isNil(var_468_4) then
				if arg_465_1.var_.characterEffect1072ui_story and not isNil(var_468_4) then
					arg_465_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_5)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_5 and arg_465_1.time_ < 0 + var_468_5 + arg_468_0 and not isNil(var_468_4) and arg_465_1.var_.characterEffect1072ui_story then
				arg_465_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_468_6 = 0
			local var_468_7 = 0.25

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_8 = arg_465_1:GetWordFromCfg(221051113)
				local var_468_9 = arg_465_1:FormatText(var_468_8.content)

				arg_465_1.text_.text = var_468_9

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 10 <= 0 and var_468_7 or var_468_7 * (utf8.len(var_468_9) / 10)

				if (10 <= 0 and var_468_7 or var_468_7 * (utf8.len(var_468_9) / 10)) > 0 and var_468_7 < var_468_11 then
					arg_465_1.talkMaxDuration = var_468_11

					if var_468_11 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_11 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_9
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051113", "story_v_out_221051.awb") ~= 0 then
					local var_468_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051113", "story_v_out_221051.awb") / 1000

					if var_468_12 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_6
					end

					if var_468_8.prefab_name ~= "" and arg_465_1.actors_[var_468_8.prefab_name] ~= nil then
						local var_468_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_8.prefab_name].transform, "story_v_out_221051", "221051113", "story_v_out_221051.awb")

						arg_465_1:RecordAudio("221051113", var_468_13)
						arg_465_1:RecordAudio("221051113", var_468_13)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_221051", "221051113", "story_v_out_221051.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_221051", "221051113", "story_v_out_221051.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_14 and arg_465_1.time_ < var_468_6 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
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

		arg_465_1:InitPlayNodeList()
	end,
	Play221051114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 221051114
		arg_469_1.duration_ = 6.53

		local var_469_0 = {
			ja = 6.533,
			ko = 5,
			zh = 5
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play221051115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1072ui_story = arg_469_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1072ui_story"].transform.position).z)
				arg_469_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1072ui_story"].transform.localEulerAngles = arg_469_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_469_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1072ui_story"].transform.position).z)
				arg_469_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1072ui_story"].transform.localEulerAngles = arg_469_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["1072ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1072ui_story == nil then
				arg_469_1.var_.characterEffect1072ui_story = var_472_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 and not isNil(var_472_1) then
				if arg_469_1.var_.characterEffect1072ui_story and not isNil(var_472_1) then
					arg_469_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1072ui_story then
				arg_469_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_4 = arg_469_1.actors_["1076ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_4) and arg_469_1.var_.characterEffect1076ui_story == nil then
				arg_469_1.var_.characterEffect1076ui_story = var_472_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_5 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_5 and not isNil(var_472_4) then
				if arg_469_1.var_.characterEffect1076ui_story and not isNil(var_472_4) then
					arg_469_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_5)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_5 and arg_469_1.time_ < 0 + var_472_5 + arg_472_0 and not isNil(var_472_4) and arg_469_1.var_.characterEffect1076ui_story then
				arg_469_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_472_6 = 0
			local var_472_7 = 0.425

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_8 = arg_469_1:GetWordFromCfg(221051114)
				local var_472_9 = arg_469_1:FormatText(var_472_8.content)

				arg_469_1.text_.text = var_472_9

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 17 <= 0 and var_472_7 or var_472_7 * (utf8.len(var_472_9) / 17)

				if (17 <= 0 and var_472_7 or var_472_7 * (utf8.len(var_472_9) / 17)) > 0 and var_472_7 < var_472_11 then
					arg_469_1.talkMaxDuration = var_472_11

					if var_472_11 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_9
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051114", "story_v_out_221051.awb") ~= 0 then
					local var_472_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051114", "story_v_out_221051.awb") / 1000

					if var_472_12 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_12 + var_472_6
					end

					if var_472_8.prefab_name ~= "" and arg_469_1.actors_[var_472_8.prefab_name] ~= nil then
						local var_472_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_8.prefab_name].transform, "story_v_out_221051", "221051114", "story_v_out_221051.awb")

						arg_469_1:RecordAudio("221051114", var_472_13)
						arg_469_1:RecordAudio("221051114", var_472_13)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_221051", "221051114", "story_v_out_221051.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_221051", "221051114", "story_v_out_221051.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_14 and arg_469_1.time_ < var_472_6 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
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

		arg_469_1:InitPlayNodeList()
	end,
	Play221051115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 221051115
		arg_473_1.duration_ = 3.03

		local var_473_0 = {
			ja = 3.033,
			ko = 2.8,
			zh = 2.8
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play221051116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.35

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:GetWordFromCfg(221051115)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 13 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 13)

				if (13 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 13)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051115", "story_v_out_221051.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051115", "story_v_out_221051.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_221051", "221051115", "story_v_out_221051.awb")

						arg_473_1:RecordAudio("221051115", var_476_6)
						arg_473_1:RecordAudio("221051115", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_221051", "221051115", "story_v_out_221051.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_221051", "221051115", "story_v_out_221051.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play221051116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 221051116
		arg_477_1.duration_ = 5.47

		local var_477_0 = {
			ja = 5.466,
			ko = 5.133,
			zh = 5.133
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
				arg_477_0:Play221051117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_480_0 = 0
			local var_480_1 = 0.625

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_2 = arg_477_1:GetWordFromCfg(221051116)
				local var_480_3 = arg_477_1:FormatText(var_480_2.content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 25 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 25)

				if (25 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 25)) > 0 and var_480_1 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051116", "story_v_out_221051.awb") ~= 0 then
					local var_480_6 = manager.audio:GetVoiceLength("story_v_out_221051", "221051116", "story_v_out_221051.awb") / 1000

					if var_480_6 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_0
					end

					if var_480_2.prefab_name ~= "" and arg_477_1.actors_[var_480_2.prefab_name] ~= nil then
						local var_480_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_2.prefab_name].transform, "story_v_out_221051", "221051116", "story_v_out_221051.awb")

						arg_477_1:RecordAudio("221051116", var_480_7)
						arg_477_1:RecordAudio("221051116", var_480_7)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_221051", "221051116", "story_v_out_221051.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_221051", "221051116", "story_v_out_221051.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play221051117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 221051117
		arg_481_1.duration_ = 6.03

		local var_481_0 = {
			ja = 6.033,
			ko = 3.8,
			zh = 3.8
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
				arg_481_0:Play221051118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1076ui_story = arg_481_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1076ui_story"].transform.position).z)
				arg_481_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1076ui_story"].transform.localEulerAngles = arg_481_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_481_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1076ui_story"].transform.position).z)
				arg_481_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1076ui_story"].transform.localEulerAngles = arg_481_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1076ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1076ui_story == nil then
				arg_481_1.var_.characterEffect1076ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1076ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1076ui_story then
				arg_481_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_4 = arg_481_1.actors_["1072ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_4) and arg_481_1.var_.characterEffect1072ui_story == nil then
				arg_481_1.var_.characterEffect1072ui_story = var_484_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_5 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_5 and not isNil(var_484_4) then
				if arg_481_1.var_.characterEffect1072ui_story and not isNil(var_484_4) then
					arg_481_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_5)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_5 and arg_481_1.time_ < 0 + var_484_5 + arg_484_0 and not isNil(var_484_4) and arg_481_1.var_.characterEffect1072ui_story then
				arg_481_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_484_6 = 0
			local var_484_7 = 0.325

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_8 = arg_481_1:GetWordFromCfg(221051117)
				local var_484_9 = arg_481_1:FormatText(var_484_8.content)

				arg_481_1.text_.text = var_484_9

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 13 <= 0 and var_484_7 or var_484_7 * (utf8.len(var_484_9) / 13)

				if (13 <= 0 and var_484_7 or var_484_7 * (utf8.len(var_484_9) / 13)) > 0 and var_484_7 < var_484_11 then
					arg_481_1.talkMaxDuration = var_484_11

					if var_484_11 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_11 + var_484_6
					end
				end

				arg_481_1.text_.text = var_484_9
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051117", "story_v_out_221051.awb") ~= 0 then
					local var_484_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051117", "story_v_out_221051.awb") / 1000

					if var_484_12 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_12 + var_484_6
					end

					if var_484_8.prefab_name ~= "" and arg_481_1.actors_[var_484_8.prefab_name] ~= nil then
						local var_484_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_8.prefab_name].transform, "story_v_out_221051", "221051117", "story_v_out_221051.awb")

						arg_481_1:RecordAudio("221051117", var_484_13)
						arg_481_1:RecordAudio("221051117", var_484_13)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_221051", "221051117", "story_v_out_221051.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_221051", "221051117", "story_v_out_221051.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_14 = math.max(var_484_7, arg_481_1.talkMaxDuration)

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_6) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_6 + var_484_14 and arg_481_1.time_ < var_484_6 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play221051118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 221051118
		arg_485_1.duration_ = 9.6

		local var_485_0 = {
			ja = 9.6,
			ko = 8.766,
			zh = 8.766
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
				arg_485_0:Play221051119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1072ui_story = arg_485_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1072ui_story"].transform.position).z)
				arg_485_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1072ui_story"].transform.localEulerAngles = arg_485_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_485_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1072ui_story"].transform.position).z)
				arg_485_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1072ui_story"].transform.localEulerAngles = arg_485_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_488_1 = arg_485_1.actors_["1072ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1072ui_story == nil then
				arg_485_1.var_.characterEffect1072ui_story = var_488_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 and not isNil(var_488_1) then
				if arg_485_1.var_.characterEffect1072ui_story and not isNil(var_488_1) then
					arg_485_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1072ui_story then
				arg_485_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_488_4 = arg_485_1.actors_["1076ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_4) and arg_485_1.var_.characterEffect1076ui_story == nil then
				arg_485_1.var_.characterEffect1076ui_story = var_488_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_5 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_5 and not isNil(var_488_4) then
				if arg_485_1.var_.characterEffect1076ui_story and not isNil(var_488_4) then
					arg_485_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_5)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_5 and arg_485_1.time_ < 0 + var_488_5 + arg_488_0 and not isNil(var_488_4) and arg_485_1.var_.characterEffect1076ui_story then
				arg_485_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_488_6 = 0
			local var_488_7 = 1.15

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_8 = arg_485_1:GetWordFromCfg(221051118)
				local var_488_9 = arg_485_1:FormatText(var_488_8.content)

				arg_485_1.text_.text = var_488_9

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_11 = 46 <= 0 and var_488_7 or var_488_7 * (utf8.len(var_488_9) / 46)

				if (46 <= 0 and var_488_7 or var_488_7 * (utf8.len(var_488_9) / 46)) > 0 and var_488_7 < var_488_11 then
					arg_485_1.talkMaxDuration = var_488_11

					if var_488_11 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_11 + var_488_6
					end
				end

				arg_485_1.text_.text = var_488_9
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051118", "story_v_out_221051.awb") ~= 0 then
					local var_488_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051118", "story_v_out_221051.awb") / 1000

					if var_488_12 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_12 + var_488_6
					end

					if var_488_8.prefab_name ~= "" and arg_485_1.actors_[var_488_8.prefab_name] ~= nil then
						local var_488_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_8.prefab_name].transform, "story_v_out_221051", "221051118", "story_v_out_221051.awb")

						arg_485_1:RecordAudio("221051118", var_488_13)
						arg_485_1:RecordAudio("221051118", var_488_13)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_221051", "221051118", "story_v_out_221051.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_221051", "221051118", "story_v_out_221051.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_14 = math.max(var_488_7, arg_485_1.talkMaxDuration)

			if var_488_6 <= arg_485_1.time_ and arg_485_1.time_ < var_488_6 + var_488_14 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_6) / var_488_14

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_6 + var_488_14 and arg_485_1.time_ < var_488_6 + var_488_14 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play221051119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 221051119
		arg_489_1.duration_ = 15.7

		local var_489_0 = {
			ja = 15.7,
			ko = 11.5,
			zh = 11.5
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play221051120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_492_0 = 0
			local var_492_1 = 1.35

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_2 = arg_489_1:GetWordFromCfg(221051119)
				local var_492_3 = arg_489_1:FormatText(var_492_2.content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 54 <= 0 and var_492_1 or var_492_1 * (utf8.len(var_492_3) / 54)

				if (54 <= 0 and var_492_1 or var_492_1 * (utf8.len(var_492_3) / 54)) > 0 and var_492_1 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051119", "story_v_out_221051.awb") ~= 0 then
					local var_492_6 = manager.audio:GetVoiceLength("story_v_out_221051", "221051119", "story_v_out_221051.awb") / 1000

					if var_492_6 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_6 + var_492_0
					end

					if var_492_2.prefab_name ~= "" and arg_489_1.actors_[var_492_2.prefab_name] ~= nil then
						local var_492_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_2.prefab_name].transform, "story_v_out_221051", "221051119", "story_v_out_221051.awb")

						arg_489_1:RecordAudio("221051119", var_492_7)
						arg_489_1:RecordAudio("221051119", var_492_7)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_221051", "221051119", "story_v_out_221051.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_221051", "221051119", "story_v_out_221051.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_8 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_8 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_8

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_8 and arg_489_1.time_ < var_492_0 + var_492_8 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play221051120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 221051120
		arg_493_1.duration_ = 2

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play221051121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1076ui_story = arg_493_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1076ui_story"].transform.position).z)
				arg_493_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1076ui_story"].transform.localEulerAngles = arg_493_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_493_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1076ui_story"].transform.position).z)
				arg_493_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1076ui_story"].transform.localEulerAngles = arg_493_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1076ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1076ui_story == nil then
				arg_493_1.var_.characterEffect1076ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1076ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1076ui_story then
				arg_493_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_496_4 = arg_493_1.actors_["1072ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_4) and arg_493_1.var_.characterEffect1072ui_story == nil then
				arg_493_1.var_.characterEffect1072ui_story = var_496_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_5 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_5 and not isNil(var_496_4) then
				if arg_493_1.var_.characterEffect1072ui_story and not isNil(var_496_4) then
					arg_493_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_5)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_5 and arg_493_1.time_ < 0 + var_496_5 + arg_496_0 and not isNil(var_496_4) and arg_493_1.var_.characterEffect1072ui_story then
				arg_493_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_496_6 = 0
			local var_496_7 = 0.05

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_8 = arg_493_1:GetWordFromCfg(221051120)
				local var_496_9 = arg_493_1:FormatText(var_496_8.content)

				arg_493_1.text_.text = var_496_9

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 2 <= 0 and var_496_7 or var_496_7 * (utf8.len(var_496_9) / 2)

				if (2 <= 0 and var_496_7 or var_496_7 * (utf8.len(var_496_9) / 2)) > 0 and var_496_7 < var_496_11 then
					arg_493_1.talkMaxDuration = var_496_11

					if var_496_11 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_11 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_9
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051120", "story_v_out_221051.awb") ~= 0 then
					local var_496_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051120", "story_v_out_221051.awb") / 1000

					if var_496_12 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_12 + var_496_6
					end

					if var_496_8.prefab_name ~= "" and arg_493_1.actors_[var_496_8.prefab_name] ~= nil then
						local var_496_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_8.prefab_name].transform, "story_v_out_221051", "221051120", "story_v_out_221051.awb")

						arg_493_1:RecordAudio("221051120", var_496_13)
						arg_493_1:RecordAudio("221051120", var_496_13)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_221051", "221051120", "story_v_out_221051.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_221051", "221051120", "story_v_out_221051.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play221051121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 221051121
		arg_497_1.duration_ = 5

		local var_497_0 = {
			ja = 5,
			ko = 4.266,
			zh = 4.266
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
				arg_497_0:Play221051122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1076ui_story = arg_497_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1076ui_story"].transform.position).z)
				arg_497_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1076ui_story"].transform.localEulerAngles = arg_497_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_497_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1076ui_story"].transform.position).z)
				arg_497_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1076ui_story"].transform.localEulerAngles = arg_497_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_500_1 = 0
			local var_500_2 = 0.35

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(221051121)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 14 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_4) / 14)

				if (14 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_4) / 14)) > 0 and var_500_2 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051121", "story_v_out_221051.awb") ~= 0 then
					local var_500_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051121", "story_v_out_221051.awb") / 1000

					if var_500_7 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_1
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_out_221051", "221051121", "story_v_out_221051.awb")

						arg_497_1:RecordAudio("221051121", var_500_8)
						arg_497_1:RecordAudio("221051121", var_500_8)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_221051", "221051121", "story_v_out_221051.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_221051", "221051121", "story_v_out_221051.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_9 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_9 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_9

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_9 and arg_497_1.time_ < var_500_1 + var_500_9 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
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

		arg_497_1:InitPlayNodeList()
	end,
	Play221051122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 221051122
		arg_501_1.duration_ = 5.67

		local var_501_0 = {
			ja = 5.566,
			ko = 5.666,
			zh = 5.666
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play221051123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1072ui_story = arg_501_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1072ui_story"].transform.position).z)
				arg_501_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1072ui_story"].transform.localEulerAngles = arg_501_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_501_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1072ui_story"].transform.position).z)
				arg_501_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1072ui_story"].transform.localEulerAngles = arg_501_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_504_1 = arg_501_1.actors_["1072ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1072ui_story == nil then
				arg_501_1.var_.characterEffect1072ui_story = var_504_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 and not isNil(var_504_1) then
				if arg_501_1.var_.characterEffect1072ui_story and not isNil(var_504_1) then
					arg_501_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1072ui_story then
				arg_501_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_504_4 = arg_501_1.actors_["1076ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.characterEffect1076ui_story == nil then
				arg_501_1.var_.characterEffect1076ui_story = var_504_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_5 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_5 and not isNil(var_504_4) then
				if arg_501_1.var_.characterEffect1076ui_story and not isNil(var_504_4) then
					arg_501_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_5)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_5 and arg_501_1.time_ < 0 + var_504_5 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.characterEffect1076ui_story then
				arg_501_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_504_6 = 0
			local var_504_7 = 0.625

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_8 = arg_501_1:GetWordFromCfg(221051122)
				local var_504_9 = arg_501_1:FormatText(var_504_8.content)

				arg_501_1.text_.text = var_504_9

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_11 = 25 <= 0 and var_504_7 or var_504_7 * (utf8.len(var_504_9) / 25)

				if (25 <= 0 and var_504_7 or var_504_7 * (utf8.len(var_504_9) / 25)) > 0 and var_504_7 < var_504_11 then
					arg_501_1.talkMaxDuration = var_504_11

					if var_504_11 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_11 + var_504_6
					end
				end

				arg_501_1.text_.text = var_504_9
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051122", "story_v_out_221051.awb") ~= 0 then
					local var_504_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051122", "story_v_out_221051.awb") / 1000

					if var_504_12 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_12 + var_504_6
					end

					if var_504_8.prefab_name ~= "" and arg_501_1.actors_[var_504_8.prefab_name] ~= nil then
						local var_504_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_8.prefab_name].transform, "story_v_out_221051", "221051122", "story_v_out_221051.awb")

						arg_501_1:RecordAudio("221051122", var_504_13)
						arg_501_1:RecordAudio("221051122", var_504_13)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_221051", "221051122", "story_v_out_221051.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_221051", "221051122", "story_v_out_221051.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_14 = math.max(var_504_7, arg_501_1.talkMaxDuration)

			if var_504_6 <= arg_501_1.time_ and arg_501_1.time_ < var_504_6 + var_504_14 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_6) / var_504_14

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_6 + var_504_14 and arg_501_1.time_ < var_504_6 + var_504_14 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
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

		arg_501_1:InitPlayNodeList()
	end,
	Play221051123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 221051123
		arg_505_1.duration_ = 6.9

		local var_505_0 = {
			ja = 6.9,
			ko = 4.266,
			zh = 4.266
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
				arg_505_0:Play221051124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.525

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:GetWordFromCfg(221051123)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 21 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 21)

				if (21 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 21)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051123", "story_v_out_221051.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_out_221051", "221051123", "story_v_out_221051.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_out_221051", "221051123", "story_v_out_221051.awb")

						arg_505_1:RecordAudio("221051123", var_508_6)
						arg_505_1:RecordAudio("221051123", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_221051", "221051123", "story_v_out_221051.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_221051", "221051123", "story_v_out_221051.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play221051124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 221051124
		arg_509_1.duration_ = 9.4

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play221051125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1072ui_story = arg_509_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1072ui_story"].transform.position).z)
				arg_509_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1072ui_story"].transform.localEulerAngles = arg_509_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_509_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1072ui_story"].transform.position).z)
				arg_509_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1072ui_story"].transform.localEulerAngles = arg_509_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_512_1 = 0
			local var_512_2 = 0.9

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:GetWordFromCfg(221051124)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_6 = 36 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_4) / 36)

				if (36 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_4) / 36)) > 0 and var_512_2 < var_512_6 then
					arg_509_1.talkMaxDuration = var_512_6

					if var_512_6 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051124", "story_v_out_221051.awb") ~= 0 then
					local var_512_7 = manager.audio:GetVoiceLength("story_v_out_221051", "221051124", "story_v_out_221051.awb") / 1000

					if var_512_7 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_1
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_out_221051", "221051124", "story_v_out_221051.awb")

						arg_509_1:RecordAudio("221051124", var_512_8)
						arg_509_1:RecordAudio("221051124", var_512_8)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_221051", "221051124", "story_v_out_221051.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_221051", "221051124", "story_v_out_221051.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_9 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_9 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_9

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_9 and arg_509_1.time_ < var_512_1 + var_512_9 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
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

		arg_509_1:InitPlayNodeList()
	end,
	Play221051125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 221051125
		arg_513_1.duration_ = 7.6

		local var_513_0 = {
			ja = 7.6,
			ko = 4.5,
			zh = 4.5
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
			arg_513_1.auto_ = false
		end

		function arg_513_1.playNext_(arg_515_0)
			arg_513_1.onStoryFinished_()
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos1076ui_story = arg_513_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_516_0 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 then
				arg_513_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_513_1.time_ - 0) / var_516_0)
				arg_513_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1076ui_story"].transform.position).z)
				arg_513_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["1076ui_story"].transform.localEulerAngles = arg_513_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 then
				arg_513_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_513_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["1076ui_story"].transform.position).z)
				arg_513_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["1076ui_story"].transform.localEulerAngles = arg_513_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_516_1 = arg_513_1.actors_["1076ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect1076ui_story == nil then
				arg_513_1.var_.characterEffect1076ui_story = var_516_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_2 and not isNil(var_516_1) then
				if arg_513_1.var_.characterEffect1076ui_story and not isNil(var_516_1) then
					arg_513_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_2 and arg_513_1.time_ < 0 + var_516_2 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect1076ui_story then
				arg_513_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_516_4 = arg_513_1.actors_["1072ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_4) and arg_513_1.var_.characterEffect1072ui_story == nil then
				arg_513_1.var_.characterEffect1072ui_story = var_516_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_5 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_5 and not isNil(var_516_4) then
				if arg_513_1.var_.characterEffect1072ui_story and not isNil(var_516_4) then
					arg_513_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_5)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_5 and arg_513_1.time_ < 0 + var_516_5 + arg_516_0 and not isNil(var_516_4) and arg_513_1.var_.characterEffect1072ui_story then
				arg_513_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_516_6 = 0
			local var_516_7 = 0.55

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_6 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_8 = arg_513_1:GetWordFromCfg(221051125)
				local var_516_9 = arg_513_1:FormatText(var_516_8.content)

				arg_513_1.text_.text = var_516_9

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_11 = 22 <= 0 and var_516_7 or var_516_7 * (utf8.len(var_516_9) / 22)

				if (22 <= 0 and var_516_7 or var_516_7 * (utf8.len(var_516_9) / 22)) > 0 and var_516_7 < var_516_11 then
					arg_513_1.talkMaxDuration = var_516_11

					if var_516_11 + var_516_6 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_11 + var_516_6
					end
				end

				arg_513_1.text_.text = var_516_9
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221051", "221051125", "story_v_out_221051.awb") ~= 0 then
					local var_516_12 = manager.audio:GetVoiceLength("story_v_out_221051", "221051125", "story_v_out_221051.awb") / 1000

					if var_516_12 + var_516_6 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_12 + var_516_6
					end

					if var_516_8.prefab_name ~= "" and arg_513_1.actors_[var_516_8.prefab_name] ~= nil then
						local var_516_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_8.prefab_name].transform, "story_v_out_221051", "221051125", "story_v_out_221051.awb")

						arg_513_1:RecordAudio("221051125", var_516_13)
						arg_513_1:RecordAudio("221051125", var_516_13)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_221051", "221051125", "story_v_out_221051.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_221051", "221051125", "story_v_out_221051.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_14 = math.max(var_516_7, arg_513_1.talkMaxDuration)

			if var_516_6 <= arg_513_1.time_ and arg_513_1.time_ < var_516_6 + var_516_14 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_6) / var_516_14

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_6 + var_516_14 and arg_513_1.time_ < var_516_6 + var_516_14 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
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

		arg_513_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST40",
		"TextureConfig/Background/ST45",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_221051.awb"
	}
}
